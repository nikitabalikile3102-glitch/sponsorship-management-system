require('dotenv').config();

const express = require('express');
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'sponsorship_management_system',
  dateStrings: true,
  decimalNumbers: true
});

const app = express();

app.use(express.json());
app.use(express.static('public'));

const J_DEAL = `JOIN sponsors s ON s.sponsor_id=d.sponsor_id`;

const T = {
  sponsors: {
    tbl: 'sponsors',
    pk: 'sponsor_id',
    cols: [
      'company_name',
      'industry',
      'contact_name',
      'contact_email',
      'contact_phone',
      'company_size',
      'website'
    ],
    sel: 'SELECT * FROM sponsors'
  },

  events: {
    tbl: 'events',
    pk: 'event_id',
    cols: [
      'event_name',
      'start_date',
      'end_date',
      'venue',
      'total_budget',
      'event_type',
      'expected_attendance',
      'event_status'
    ],
    sel: 'SELECT * FROM events'
  },

  packages: {
    tbl: 'sponsorship_packages',
    pk: 'package_id',
    cols: [
      'event_id',
      'package_name',
      'description',
      'package_price',
      'max_slots',
      'benefits',
      'availability_status'
    ],
    sel: `SELECT p.*, e.event_name,
      p.max_slots -
      (SELECT COUNT(*)
       FROM sponsorship_deals d
       WHERE d.package_id=p.package_id
       AND d.deal_status IN ('Active','Completed')) AS slots_left
      FROM sponsorship_packages p
      JOIN events e ON e.event_id=p.event_id`
  },

  deals: {
    tbl: 'sponsorship_deals',
    pk: 'deal_id',
    cols: [
      'sponsor_id',
      'package_id',
      'deal_date',
      'agreed_amount',
      'deal_status',
      'negotiated_discount',
      'contract_start_date',
      'contract_end_date'
    ],
    sel: `SELECT d.*, s.company_name, p.package_name, e.event_name,
      COALESCE(
        (SELECT SUM(x.amount_paid)
         FROM payments x
         WHERE x.deal_id=d.deal_id), 0
      ) AS received
      FROM sponsorship_deals d
      ${J_DEAL}
      JOIN sponsorship_packages p ON p.package_id=d.package_id
      JOIN events e ON e.event_id=p.event_id`
  },

  payments: {
    tbl: 'payments',
    pk: 'payment_id',
    cols: [
      'deal_id',
      'installment_no',
      'amount_due',
      'due_date',
      'amount_paid',
      'paid_date',
      'payment_status',
      'payment_method',
      'transaction_reference'
    ],
    sel: `SELECT y.*, s.company_name, e.event_name
      FROM payments y
      JOIN sponsorship_deals d ON d.deal_id=y.deal_id
      ${J_DEAL}
      JOIN sponsorship_packages p ON p.package_id=d.package_id
      JOIN events e ON e.event_id=p.event_id`
  },

  deliverables: {
    tbl: 'deliverables',
    pk: 'deliverable_id',
    cols: [
      'deal_id',
      'deliverable_type',
      'description',
      'deadline',
      'completion_status',
      'responsible_person',
      'completion_date',
      'remarks'
    ],
    sel: `SELECT l.*, s.company_name
      FROM deliverables l
      JOIN sponsorship_deals d ON d.deal_id=l.deal_id
      ${J_DEAL}`
  }
};

const wrap = fn => (req, res) =>
  fn(req, res).catch(e =>
    res.status(400).json({
      error: e.sqlMessage || e.message
    })
  );

const clean = (t, body) =>
  Object.fromEntries(
    t.cols
      .filter(c => c in body)
      .map(c => [c, body[c] === '' ? null : body[c]])
  );

app.get('/api/dashboard', wrap(async (req, res) => {

  const q = async s => (await pool.query(s))[0];

  const [a] = await q(`
    SELECT
      (SELECT COUNT(*) FROM sponsors) sponsors,
      (SELECT COUNT(*) FROM sponsorship_deals
       WHERE deal_status='Active') activeDeals,
      COALESCE(SUM(amount_paid),0) received,
      COALESCE(SUM(amount_due),0) expected
    FROM payments
  `);

  a.overdue = await q(`
    SELECT
      y.payment_id,
      y.installment_no,
      y.amount_due,
      y.due_date,
      s.company_name
    FROM payments y
    JOIN sponsorship_deals d
      ON d.deal_id=y.deal_id
    JOIN sponsors s
      ON s.sponsor_id=d.sponsor_id
    WHERE y.payment_status='Overdue'
       OR (y.due_date<CURDATE()
       AND y.payment_status<>'Paid')
    ORDER BY y.due_date
  `);

  a.upcoming = await q(`
    SELECT
      l.deliverable_type,
      l.deadline,
      l.completion_status,
      s.company_name
    FROM deliverables l
    JOIN sponsorship_deals d
      ON d.deal_id=l.deal_id
    JOIN sponsors s
      ON s.sponsor_id=d.sponsor_id
    WHERE l.completion_status<>'Completed'
      AND l.deadline<=DATE_ADD(CURDATE(),INTERVAL 7 DAY)
    ORDER BY l.deadline
  `);

  res.json(a);
}));

app.get('/api/:n', wrap(async (req, res) => {

  const t = T[req.params.n];

  if (!t)
    return res.status(404).json({
      error: 'Unknown table'
    });

  res.json(
    (await pool.query(`${t.sel} ORDER BY 1`))[0]
  );
}));

app.post('/api/:n', wrap(async (req, res) => {

  const t = T[req.params.n];

  if (!t)
    return res.status(404).json({
      error: 'Unknown table'
    });

  const data = clean(t, req.body);

  for (const k in data) {
    if (data[k] === null)
      delete data[k];
  }

  const [[{ id }]] = await pool.query(`
    SELECT COALESCE(MAX(${t.pk}),0)+1 AS id
    FROM ${t.tbl}
  `);

  await pool.query(
    `INSERT INTO ${t.tbl} SET ?`,
    [{ [t.pk]: id, ...data }]
  );

  res.json({ id });
}));

app.put('/api/:n/:id', wrap(async (req, res) => {

  const t = T[req.params.n];

  if (!t)
    return res.status(404).json({
      error: 'Unknown table'
    });

  await pool.query(
    `UPDATE ${t.tbl} SET ? WHERE ${t.pk}=?`,
    [clean(t, req.body), req.params.id]
  );

  res.json({ ok: true });
}));

app.delete('/api/:n/:id', wrap(async (req, res) => {

  const t = T[req.params.n];

  if (!t)
    return res.status(404).json({
      error: 'Unknown table'
    });

  await pool.query(
    `DELETE FROM ${t.tbl} WHERE ${t.pk}=?`,
    [req.params.id]
  );

  res.json({ ok: true });
}));

app.listen(
  process.env.PORT || 3000,
  () => console.log(
    'Running on http://localhost:' +
    (process.env.PORT || 3000)
  )
);