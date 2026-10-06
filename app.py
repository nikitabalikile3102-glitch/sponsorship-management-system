from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app)

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Greu02@31",
    database="sponsorship_management_system"
)


@app.route("/")
def home():
    return "Sponsorship Management System Backend is Running!"


# ==================== SPONSORS ====================

# GET all sponsors
@app.route("/sponsors", methods=["GET"])
def get_sponsors():
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT * FROM sponsors")
    data = cursor.fetchall()

    cursor.close()

    return jsonify(data)


# POST - Add sponsor
@app.route("/sponsors", methods=["POST"])
def add_sponsor():
    data = request.json

    company_name = data["company_name"]
    industry = data.get("industry")
    contact_name = data.get("contact_name")
    contact_email = data.get("contact_email")
    contact_phone = data.get("contact_phone")
    company_size = data.get("company_size")
    website = data.get("website")

    cursor = db.cursor()

    query = """
        INSERT INTO sponsors
        (company_name, industry, contact_name, contact_email,
         contact_phone, company_size, website)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """

    values = (
        company_name,
        industry,
        contact_name,
        contact_email,
        contact_phone,
        company_size,
        website
    )

    cursor.execute(query, values)
    db.commit()

    cursor.close()

    return jsonify({"message": "Sponsor added successfully"})


# GET sponsor by ID
@app.route("/sponsors/<int:sponsor_id>", methods=["GET"])
def get_sponsor(sponsor_id):
    cursor = db.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM sponsors WHERE sponsor_id = %s",
        (sponsor_id,)
    )

    sponsor = cursor.fetchone()

    cursor.close()

    if sponsor:
        return jsonify(sponsor)

    return jsonify({"message": "Sponsor not found"}), 404


# PUT - Update sponsor
@app.route("/sponsors/<int:sponsor_id>", methods=["PUT"])
def update_sponsor(sponsor_id):
    data = request.json

    company_name = data["company_name"]
    industry = data.get("industry")
    contact_name = data.get("contact_name")
    contact_email = data.get("contact_email")
    contact_phone = data.get("contact_phone")
    company_size = data.get("company_size")
    website = data.get("website")

    cursor = db.cursor()

    query = """
        UPDATE sponsors
        SET company_name = %s,
            industry = %s,
            contact_name = %s,
            contact_email = %s,
            contact_phone = %s,
            company_size = %s,
            website = %s
        WHERE sponsor_id = %s
    """

    values = (
        company_name,
        industry,
        contact_name,
        contact_email,
        contact_phone,
        company_size,
        website,
        sponsor_id
    )

    cursor.execute(query, values)
    db.commit()

    cursor.close()

    return jsonify({"message": "Sponsor updated successfully"})


# DELETE - Delete sponsor
@app.route("/sponsors/<int:sponsor_id>", methods=["DELETE"])
def delete_sponsor(sponsor_id):
    cursor = db.cursor()

    cursor.execute(
        "DELETE FROM sponsors WHERE sponsor_id = %s",
        (sponsor_id,)
    )

    db.commit()

    cursor.close()

    return jsonify({"message": "Sponsor deleted successfully"})


# ==================== EVENTS ====================

# GET all events
@app.route("/events", methods=["GET"])
def get_events():
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT * FROM events")
    data = cursor.fetchall()

    cursor.close()

    return jsonify(data)


# POST - Add event
@app.route("/events", methods=["POST"])
def add_event():
    data = request.json

    event_name = data["event_name"]
    start_date = data.get("start_date")
    end_date = data.get("end_date")
    venue = data.get("venue")
    total_budget = data.get("total_budget")
    event_type = data.get("event_type")
    expected_attendance = data.get("expected_attendance")
    event_status = data.get("event_status")

    cursor = db.cursor()

    query = """
        INSERT INTO events
        (event_name, start_date, end_date, venue, total_budget,
         event_type, expected_attendance, event_status)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """

    values = (
        event_name,
        start_date,
        end_date,
        venue,
        total_budget,
        event_type,
        expected_attendance,
        event_status
    )

    cursor.execute(query, values)
    db.commit()

    cursor.close()

    return jsonify({"message": "Event added successfully"})


# GET event by ID
@app.route("/events/<int:event_id>", methods=["GET"])
def get_event(event_id):
    cursor = db.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM events WHERE event_id = %s",
        (event_id,)
    )

    event = cursor.fetchone()

    cursor.close()

    if event:
        return jsonify(event)

    return jsonify({"message": "Event not found"}), 404


# PUT - Update event
@app.route("/events/<int:event_id>", methods=["PUT"])
def update_event(event_id):
    data = request.json

    event_name = data["event_name"]
    start_date = data.get("start_date")
    end_date = data.get("end_date")
    venue = data.get("venue")
    total_budget = data.get("total_budget")
    event_type = data.get("event_type")
    expected_attendance = data.get("expected_attendance")
    event_status = data.get("event_status")

    cursor = db.cursor()

    query = """
        UPDATE events
        SET event_name = %s,
            start_date = %s,
            end_date = %s,
            venue = %s,
            total_budget = %s,
            event_type = %s,
            expected_attendance = %s,
            event_status = %s
        WHERE event_id = %s
    """

    values = (
        event_name,
        start_date,
        end_date,
        venue,
        total_budget,
        event_type,
        expected_attendance,
        event_status,
        event_id
    )

    cursor.execute(query, values)
    db.commit()

    cursor.close()

    return jsonify({"message": "Event updated successfully"})


# DELETE - Delete event
@app.route("/events/<int:event_id>", methods=["DELETE"])
def delete_event(event_id):
    cursor = db.cursor()

    cursor.execute(
        "DELETE FROM events WHERE event_id = %s",
        (event_id,)
    )

    db.commit()

    cursor.close()

    return jsonify({"message": "Event deleted successfully"})


if __name__ == "__main__":
    app.run(debug=True)
