"""
MediPulse Full REST API & Developer Admin Server
Uses Python's built-in http.server and sqlite3 (Zero external dependencies)
"""

import http.server
import socketserver
import urllib.parse
import json
import sqlite3
from pathlib import Path
import datetime

PORT = 8000
BASE_DIR = Path(__file__).resolve().parent
DB_PATH = BASE_DIR / "health_medicine.db"

def get_db_connection():
    con = sqlite3.connect(DB_PATH)
    con.row_factory = sqlite3.Row
    return con

def seed_database_if_needed():
    con = get_db_connection()
    cur = con.cursor()

    # 1. Users table & seed
    cur.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT, email TEXT, password TEXT, role TEXT,
            phone TEXT, age INTEGER, gender TEXT, blood_group TEXT,
            city TEXT, medical_notes TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
    if cur.execute("SELECT COUNT(*) FROM users").fetchone()[0] == 0:
        sample_users = [
            ("Dr. Dev Charan", "admin@medipulse.com", "admin123", "admin", "+1 (555) 019-2831", 34, "Male", "O+", "New York", "System Administrator"),
            ("Sarah Jenkins", "sarah.j@example.com", "pass123", "patient", "+1 (555) 234-5678", 28, "Female", "A+", "Boston", "Mild pollen allergy"),
            ("Robert Chen", "r.chen@example.com", "pass123", "patient", "+1 (555) 876-5432", 45, "Male", "B-", "San Francisco", "Hypertension history"),
            ("Elena Rostova", "elena.r@example.com", "pass123", "patient", "+1 (555) 345-6789", 31, "Female", "AB+", "Chicago", "Asthma under management"),
            ("Marcus Vance", "marcus.v@example.com", "pass123", "patient", "+1 (555) 901-2345", 52, "Male", "O-", "Seattle", "Routine cardiac checkup")
        ]
        cur.executemany("""
            INSERT INTO users (name, email, password, role, phone, age, gender, blood_group, city, medical_notes, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now', '-2 days'))
        """, sample_users)

    # 2. Appointments table & seed
    cur.execute("""
        CREATE TABLE IF NOT EXISTS appointments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            booking_id TEXT, user_id INTEGER, patient_name TEXT,
            patient_phone TEXT, patient_email TEXT, doctor_id INTEGER,
            doctor_name TEXT, specialty TEXT, hospital_clinic TEXT,
            appointment_date TEXT, time_slot TEXT, consultation_type TEXT,
            status TEXT, symptoms_summary TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
    if cur.execute("SELECT COUNT(*) FROM appointments").fetchone()[0] == 0:
        sample_apts = [
            ("APT-1001", 2, "Sarah Jenkins", "+1 (555) 234-5678", "sarah.j@example.com", 1, "Dr. Alice Smith", "Cardiology", "City Heart Center", "2026-10-10", "10:00 AM", "In-Person", "Confirmed", "Chest tightness & palpitations"),
            ("APT-1002", 3, "Robert Chen", "+1 (555) 876-5432", "r.chen@example.com", 2, "Dr. Bob Jones", "Dermatology", "Skin & Wellness Clinic", "2026-10-12", "02:30 PM", "Video Call", "Pending", "Skin rash & eczema flare-up"),
            ("APT-1003", 4, "Elena Rostova", "+1 (555) 345-6789", "elena.r@example.com", 3, "Dr. Carol White", "Neurology", "NeuroCare Institute", "2026-10-14", "11:15 AM", "In-Person", "Completed", "Chronic migraine evaluation")
        ]
        cur.executemany("""
            INSERT INTO appointments (booking_id, user_id, patient_name, patient_phone, patient_email, doctor_id, doctor_name, specialty, hospital_clinic, appointment_date, time_slot, consultation_type, status, symptoms_summary, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now', '-1 day'))
        """, sample_apts)

    # 3. Activity logs table & seed
    cur.execute("""
        CREATE TABLE IF NOT EXISTS activity_logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            event_type TEXT, user_name TEXT, user_email TEXT,
            details TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
    if cur.execute("SELECT COUNT(*) FROM activity_logs").fetchone()[0] == 0:
        sample_logs = [
            ("SYSTEM_BOOT", "Admin System", "admin@medipulse.com", "MediPulse Admin Console initialized cleanly."),
            ("USER_LOGIN", "Dr. Dev Charan", "admin@medipulse.com", "Admin logged in successfully from 127.0.0.1"),
            ("DOCTOR_UPDATED", "Dr. Dev Charan", "admin@medipulse.com", "Updated Dr. Alice Smith availability schedule."),
            ("APPOINTMENT_BOOKED", "Sarah Jenkins", "sarah.j@example.com", "Booked Cardiology appointment APT-1001")
        ]
        cur.executemany("""
            INSERT INTO activity_logs (event_type, user_name, user_email, details, created_at)
            VALUES (?, ?, ?, ?, datetime('now', '-3 hours'))
        """, sample_logs)

    # 4. Email logs table & seed
    cur.execute("""
        CREATE TABLE IF NOT EXISTS email_logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            recipient TEXT, subject TEXT, body TEXT, status TEXT,
            sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
    if cur.execute("SELECT COUNT(*) FROM email_logs").fetchone()[0] == 0:
        sample_emails = [
            ("sarah.j@example.com", "Appointment Confirmation #APT-1001", "Dear Sarah, your appointment with Dr. Alice Smith is confirmed for 2026-10-10 at 10:00 AM.", "SENT"),
            ("r.chen@example.com", "Appointment Reminder #APT-1002", "Dear Robert, reminder for your upcoming Dermatology video consultation.", "SENT"),
            ("dev@medipulse.com", "System Alert Test", "MediPulse Admin Email Alert System operational test.", "SENT")
        ]
        cur.executemany("""
            INSERT INTO email_logs (recipient, subject, body, status, sent_at)
            VALUES (?, ?, ?, ?, datetime('now', '-1 hour'))
        """, sample_emails)

    # 5. Admin Settings table & seed
    cur.execute("""
        CREATE TABLE IF NOT EXISTS admin_settings (
            key TEXT PRIMARY KEY,
            value TEXT
        )
    """)
    default_settings = {
        "email_alerts_enabled": "true",
        "developer_email": "admin@medipulse.com",
        "smtp_host": "smtp.medipulse.internal",
        "smtp_port": "587",
        "smtp_user": "admin@medipulse.com",
        "system_theme": "dark"
    }
    for k, v in default_settings.items():
        cur.execute("INSERT OR IGNORE INTO admin_settings (key, value) VALUES (?, ?)", (k, v))

    con.commit()
    con.close()

def log_activity(event_type, details, user_name="Admin System", user_email="admin@medipulse.com"):
    try:
        con = get_db_connection()
        con.execute(
            "INSERT INTO activity_logs (event_type, user_name, user_email, details) VALUES (?, ?, ?, ?)",
            (event_type, user_name, user_email, details)
        )
        con.commit()
        con.close()
    except Exception:
        pass

class MediPulseHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(BASE_DIR), **kwargs)

    def send_json(self, data, status=200):
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.end_headers()
        self.wfile.write(json.dumps(data, indent=2).encode("utf-8"))

    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.end_headers()

    def get_post_data(self):
        content_length = int(self.headers.get('Content-Length', 0))
        if content_length > 0:
            raw_body = self.rfile.read(content_length).decode('utf-8')
            try:
                return json.loads(raw_body)
            except Exception:
                return urllib.parse.parse_qs(raw_body)
        return {}

    def do_GET(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path
        params = urllib.parse.parse_qs(parsed.query)

        if path.startswith("/api/"):
            try:
                con = get_db_connection()
                cur = con.cursor()

                # 1. Stats
                if path == "/api/stats":
                    total_cond = cur.execute("SELECT COUNT(*) FROM conditions").fetchone()[0]
                    total_med = cur.execute("SELECT COUNT(*) FROM medicines").fetchone()[0]
                    total_doc = cur.execute("SELECT COUNT(*) FROM doctors").fetchone()[0]
                    total_apt = cur.execute("SELECT COUNT(*) FROM appointments").fetchone()[0]
                    total_usr = cur.execute("SELECT COUNT(*) FROM users").fetchone()[0]
                    con.close()
                    return self.send_json({
                        "status": "ok",
                        "total_conditions": total_cond,
                        "total_medicines": total_med,
                        "total_doctors": total_doc,
                        "total_appointments": total_apt,
                        "total_users": total_usr
                    })

                # 2. Symptom Checker Engine
                elif path == "/api/symptom-check":
                    symptom_list = params.get("symptoms", [""])[0].split(",")
                    symptom_set = {s.strip().lower() for s in symptom_list if s.strip()}
                    
                    rows = cur.execute("""
                        SELECT c.id, c.name, c.symptoms, c.diet, c.fitness,
                               GROUP_CONCAT(m.name, ', ') AS medicine_names
                        FROM conditions c
                        LEFT JOIN condition_medicines cm ON cm.condition_id = c.id
                        LEFT JOIN medicines m ON m.id = cm.medicine_id
                        GROUP BY c.id
                    """).fetchall()

                    results = []
                    for r in rows:
                        try:
                            symptoms = json.loads(r["symptoms"]) if r["symptoms"] else []
                        except Exception:
                            symptoms = [s.strip() for s in str(r["symptoms"]).split(',') if s.strip()]

                        matched = [s for s in symptoms if str(s).lower() in symptom_set]
                        if matched:
                            med_list = [m.strip() for m in r["medicine_names"].split(",")] if r["medicine_names"] else []
                            score = round((len(matched) / max(len(symptoms), len(symptom_set))) * 100)
                            results.append({
                                "condition_id": r["id"],
                                "condition": r["name"],
                                "symptoms": symptoms,
                                "diet": r["diet"],
                                "fitness": r["fitness"],
                                "medicine_names": med_list,
                                "matched_symptoms": matched,
                                "unmatched_symptoms": [s for s in symptoms if str(s).lower() not in symptom_set],
                                "match_count": len(matched),
                                "match_percentage": score
                            })

                    results.sort(key=lambda x: (x["match_count"], x["match_percentage"]), reverse=True)
                    con.close()
                    return self.send_json({"symptoms_queried": list(symptom_set), "matches_count": len(results), "results": results})

                # 3. Conditions list / search (Public API)
                elif path == "/api/conditions":
                    q = params.get("q", [""])[0].strip()
                    med_filter = params.get("med_filter", ["all"])[0].strip()

                    query = """
                        SELECT c.id, c.name AS condition, c.symptoms, c.diet, c.fitness,
                               GROUP_CONCAT(m.name, ', ') AS medicine_names
                        FROM conditions c
                        LEFT JOIN condition_medicines cm ON cm.condition_id = c.id
                        LEFT JOIN medicines m ON m.id = cm.medicine_id
                    """
                    conditions_clauses = []
                    args = []

                    if q:
                        conditions_clauses.append("(c.name LIKE ? OR c.symptoms LIKE ? OR c.diet LIKE ? OR m.name LIKE ?)")
                        like_val = f"%{q}%"
                        args.extend([like_val, like_val, like_val, like_val])

                    if conditions_clauses:
                        query += " WHERE " + " AND ".join(conditions_clauses)

                    query += " GROUP BY c.id ORDER BY c.id ASC"
                    rows = cur.execute(query, args).fetchall()

                    results = []
                    for r in rows:
                        med_list = [m.strip() for m in r["medicine_names"].split(",")] if r["medicine_names"] else []
                        if med_filter == "with-meds" and not med_list:
                            continue
                        if med_filter == "lifestyle-only" and med_list:
                            continue

                        try:
                            syms = json.loads(r["symptoms"]) if r["symptoms"] else []
                        except Exception:
                            syms = [s.strip() for s in str(r["symptoms"]).split(',') if s.strip()]

                        results.append({
                            "condition_id": r["id"],
                            "condition": r["condition"],
                            "symptoms": syms,
                            "diet": r["diet"],
                            "fitness": r["fitness"],
                            "medicine_names": med_list
                        })

                    con.close()
                    return self.send_json({"count": len(results), "conditions": results})

                # 4. Admin Conditions list
                elif path == "/api/admin/conditions":
                    rows = cur.execute("SELECT * FROM conditions ORDER BY id DESC").fetchall()
                    results = []
                    for r in rows:
                        d = dict(r)
                        try:
                            d["symptoms"] = json.loads(d["symptoms"]) if d["symptoms"] else []
                        except Exception:
                            d["symptoms"] = [s.strip() for s in str(d["symptoms"]).split(',') if s.strip()]
                        results.append(d)
                    con.close()
                    return self.send_json({"status": "ok", "conditions": results})

                # 5. Medicines list / search
                elif path == "/api/medicines":
                    q = params.get("q", [""])[0].strip()
                    category = params.get("category", ["all"])[0].strip()
                    form = params.get("form", ["all"])[0].strip()

                    query = "SELECT * FROM medicines"
                    clauses = []
                    args = []

                    if q:
                        clauses.append("(name LIKE ? OR active_ingredient LIKE ? OR category LIKE ? OR uses LIKE ?)")
                        like_val = f"%{q}%"
                        args.extend([like_val, like_val, like_val, like_val])
                    if category != "all":
                        clauses.append("category = ?")
                        args.append(category)
                    if form != "all":
                        clauses.append("form LIKE ?")
                        args.append(f"%{form}%")

                    if clauses:
                        query += " WHERE " + " AND ".join(clauses)

                    query += " ORDER BY id ASC"
                    rows = cur.execute(query, args).fetchall()
                    
                    results = [dict(r) for r in rows]
                    con.close()
                    return self.send_json({"count": len(results), "medicines": results})

                # 6. Doctors API
                elif path == "/api/doctors":
                    rows = cur.execute("SELECT * FROM doctors ORDER BY id ASC").fetchall()
                    docs = [dict(r) for r in rows]
                    con.close()
                    return self.send_json({"status": "ok", "doctors": docs})

                # 7. Appointments API
                elif path == "/api/appointments":
                    rows = cur.execute("SELECT * FROM appointments ORDER BY id DESC").fetchall()
                    apts = [dict(r) for r in rows]
                    con.close()
                    return self.send_json({"status": "ok", "appointments": apts})

                # 8. Users API
                elif path == "/api/auth/users":
                    rows = cur.execute("SELECT * FROM users ORDER BY id DESC").fetchall()
                    usrs = [dict(r) for r in rows]
                    con.close()
                    return self.send_json({"status": "ok", "users": usrs})

                # 9. Activity Logs API
                elif path == "/api/admin/logs":
                    rows = cur.execute("SELECT * FROM activity_logs ORDER BY id DESC LIMIT 100").fetchall()
                    logs = [dict(r) for r in rows]
                    con.close()
                    return self.send_json({"status": "ok", "logs": logs})

                # 10. Email Logs API
                elif path == "/api/admin/email_logs":
                    rows = cur.execute("SELECT * FROM email_logs ORDER BY id DESC LIMIT 100").fetchall()
                    logs = [dict(r) for r in rows]
                    con.close()
                    return self.send_json({"status": "ok", "logs": logs})

                # 11. Email / Admin Settings API
                elif path == "/api/admin/email_settings":
                    rows = cur.execute("SELECT * FROM admin_settings").fetchall()
                    settings = {r["key"]: r["value"] for r in rows}
                    con.close()
                    return self.send_json({"status": "ok", "settings": settings})

                # 12. Single Condition
                elif path.startswith("/api/conditions/"):
                    cond_id = int(path.split("/")[-1])
                    row = cur.execute("SELECT * FROM conditions WHERE id = ?", (cond_id,)).fetchone()
                    if not row:
                        con.close()
                        return self.send_json({"error": "Condition not found"}, 404)
                    
                    meds = cur.execute("""
                        SELECT m.* FROM medicines m
                        JOIN condition_medicines cm ON cm.medicine_id = m.id
                        WHERE cm.condition_id = ?
                    """, (cond_id,)).fetchall()

                    res = dict(row)
                    try:
                        res["symptoms"] = json.loads(res["symptoms"]) if res["symptoms"] else []
                    except Exception:
                        res["symptoms"] = [s.strip() for s in str(res["symptoms"]).split(',') if s.strip()]

                    res["medicines"] = [dict(m) for m in meds]
                    con.close()
                    return self.send_json(res)

                # 13. Single Medicine
                elif path.startswith("/api/medicines/"):
                    med_id = int(path.split("/")[-1])
                    row = cur.execute("SELECT * FROM medicines WHERE id = ?", (med_id,)).fetchone()
                    if not row:
                        con.close()
                        return self.send_json({"error": "Medicine not found"}, 404)
                    
                    conds = cur.execute("""
                        SELECT c.* FROM conditions c
                        JOIN condition_medicines cm ON cm.condition_id = c.id
                        WHERE cm.medicine_id = ?
                    """, (med_id,)).fetchall()

                    res = dict(row)
                    res["treated_conditions"] = []
                    for c in conds:
                        c_dict = dict(c)
                        try:
                            c_dict["symptoms"] = json.loads(c_dict["symptoms"]) if c_dict["symptoms"] else []
                        except Exception:
                            c_dict["symptoms"] = [s.strip() for s in str(c_dict["symptoms"]).split(',') if s.strip()]
                        res["treated_conditions"].append(c_dict)

                    con.close()
                    return self.send_json(res)

                else:
                    con.close()
                    return self.send_json({"error": "Unknown API endpoint"}, 404)

            except Exception as e:
                return self.send_json({"error": str(e)}, 500)

        # Static files fallback
        return super().do_GET()

    def do_POST(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path
        params = urllib.parse.parse_qs(parsed.query)
        data = self.get_post_data()

        if path.startswith("/api/"):
            try:
                con = get_db_connection()
                cur = con.cursor()

                # 1. Add Doctor
                if path == "/api/admin/add_doctor":
                    name = data.get("name", "Dr. New Doctor")
                    specialty = data.get("specialty", "General Physician")
                    qualification = data.get("qualification", "MD")
                    hospital_clinic = data.get("hospital_clinic", "City Hospital")
                    city = data.get("city", "New York")
                    exp = int(data.get("experience_years", 5))
                    fee = data.get("consultation_fee", "$100")
                    rating = float(data.get("rating", 4.9))
                    available_days = data.get("available_days", "Mon - Fri")
                    available_slots = data.get("available_slots", "09:00 AM - 05:00 PM")

                    cur.execute("""
                        INSERT INTO doctors (name, specialty, qualification, experience_years, hospital_clinic, city, consultation_fee, rating, available_days, available_slots)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """, (name, specialty, qualification, exp, hospital_clinic, city, fee, rating, available_days, available_slots))
                    con.commit()
                    con.close()
                    log_activity("ADD_DOCTOR", f"Added doctor {name} ({specialty})")
                    return self.send_json({"status": "ok", "message": "Doctor added successfully"})

                # 2. Edit Doctor
                elif path == "/api/admin/edit_doctor":
                    doc_id = int(data.get("id") or params.get("id", [0])[0])
                    name = data.get("name")
                    specialty = data.get("specialty")
                    qualification = data.get("qualification")
                    hospital_clinic = data.get("hospital_clinic")
                    city = data.get("city")
                    exp = data.get("experience_years")
                    fee = data.get("consultation_fee")
                    rating = data.get("rating")
                    available_days = data.get("available_days")
                    available_slots = data.get("available_slots")

                    cur.execute("""
                        UPDATE doctors
                        SET name = COALESCE(?, name),
                            specialty = COALESCE(?, specialty),
                            qualification = COALESCE(?, qualification),
                            hospital_clinic = COALESCE(?, hospital_clinic),
                            city = COALESCE(?, city),
                            experience_years = COALESCE(?, experience_years),
                            consultation_fee = COALESCE(?, consultation_fee),
                            rating = COALESCE(?, rating),
                            available_days = COALESCE(?, available_days),
                            available_slots = COALESCE(?, available_slots)
                        WHERE id = ?
                    """, (name, specialty, qualification, hospital_clinic, city, exp, fee, rating, available_days, available_slots, doc_id))
                    con.commit()
                    con.close()
                    log_activity("EDIT_DOCTOR", f"Updated doctor #{doc_id} ({name})")
                    return self.send_json({"status": "ok", "message": "Doctor updated successfully"})

                # 3. Delete Doctor
                elif path == "/api/admin/delete_doctor":
                    doc_id = int(data.get("id") or params.get("id", [0])[0])
                    cur.execute("DELETE FROM doctors WHERE id = ?", (doc_id,))
                    con.commit()
                    con.close()
                    log_activity("DELETE_DOCTOR", f"Deleted doctor #{doc_id}")
                    return self.send_json({"status": "ok", "message": "Doctor deleted successfully"})

                # 4. Clear Doctors
                elif path == "/api/admin/clear_doctors":
                    cur.execute("DELETE FROM doctors")
                    con.commit()
                    con.close()
                    log_activity("CLEAR_DOCTORS", "Cleared all doctors records")
                    return self.send_json({"status": "ok", "message": "All doctors cleared"})

                # 5. Update Appointment Status
                elif path == "/api/appointments/update_status":
                    apt_id = int(data.get("id") or params.get("id", [0])[0])
                    status = data.get("status", "Confirmed")
                    cur.execute("UPDATE appointments SET status = ? WHERE id = ?", (status, apt_id))
                    con.commit()
                    con.close()
                    log_activity("UPDATE_APPOINTMENT", f"Updated appointment #{apt_id} status to {status}")
                    return self.send_json({"status": "ok", "message": f"Appointment status updated to {status}"})

                # 6. Delete Appointment
                elif path == "/api/appointments/delete":
                    apt_id = int(data.get("id") or params.get("id", [0])[0])
                    cur.execute("DELETE FROM appointments WHERE id = ?", (apt_id,))
                    con.commit()
                    con.close()
                    log_activity("DELETE_APPOINTMENT", f"Deleted appointment #{apt_id}")
                    return self.send_json({"status": "ok", "message": "Appointment deleted successfully"})

                # 7. Clear All Appointments
                elif path == "/api/appointments/clear_all":
                    cur.execute("DELETE FROM appointments")
                    con.commit()
                    con.close()
                    log_activity("CLEAR_APPOINTMENTS", "Cleared all appointment records")
                    return self.send_json({"status": "ok", "message": "All appointments cleared"})

                # 8. Add Condition
                elif path == "/api/admin/add_condition":
                    cond_name = data.get("condition") or data.get("name") or "New Condition"
                    specialist = data.get("specialist", "General")
                    syms = data.get("symptoms", [])
                    if isinstance(syms, list):
                        syms_str = json.dumps(syms)
                    else:
                        syms_str = json.dumps([s.strip() for s in str(syms).split(',') if s.strip()])
                    
                    diet = data.get("diet", "")
                    fitness = data.get("fitness", "")
                    rec_tests = data.get("recommended_tests", "")
                    red_flags = data.get("emergency_red_flags", "")

                    cur.execute("""
                        INSERT INTO conditions (name, specialist, symptoms, diet, fitness, recommended_tests, emergency_red_flags)
                        VALUES (?, ?, ?, ?, ?, ?, ?)
                    """, (cond_name, specialist, syms_str, diet, fitness, rec_tests, red_flags))
                    con.commit()
                    con.close()
                    log_activity("ADD_CONDITION", f"Added condition '{cond_name}'")
                    return self.send_json({"status": "ok", "message": "Condition added successfully"})

                # 9. Edit Condition
                elif path == "/api/admin/edit_condition":
                    cond_id = int(data.get("id") or params.get("id", [0])[0])
                    cond_name = data.get("condition") or data.get("name")
                    specialist = data.get("specialist")
                    syms = data.get("symptoms")
                    syms_str = None
                    if syms is not None:
                        if isinstance(syms, list):
                            syms_str = json.dumps(syms)
                        else:
                            syms_str = json.dumps([s.strip() for s in str(syms).split(',') if s.strip()])

                    diet = data.get("diet")
                    fitness = data.get("fitness")
                    rec_tests = data.get("recommended_tests")
                    red_flags = data.get("emergency_red_flags")

                    cur.execute("""
                        UPDATE conditions
                        SET name = COALESCE(?, name),
                            specialist = COALESCE(?, specialist),
                            symptoms = COALESCE(?, symptoms),
                            diet = COALESCE(?, diet),
                            fitness = COALESCE(?, fitness),
                            recommended_tests = COALESCE(?, recommended_tests),
                            emergency_red_flags = COALESCE(?, emergency_red_flags)
                        WHERE id = ?
                    """, (cond_name, specialist, syms_str, diet, fitness, rec_tests, red_flags, cond_id))
                    con.commit()
                    con.close()
                    log_activity("EDIT_CONDITION", f"Updated condition #{cond_id}")
                    return self.send_json({"status": "ok", "message": "Condition updated successfully"})

                # 10. Delete Condition
                elif path == "/api/admin/delete_condition":
                    cond_id = int(data.get("id") or params.get("id", [0])[0])
                    cur.execute("DELETE FROM conditions WHERE id = ?", (cond_id,))
                    con.commit()
                    con.close()
                    log_activity("DELETE_CONDITION", f"Deleted condition #{cond_id}")
                    return self.send_json({"status": "ok", "message": "Condition deleted successfully"})

                # 11. Add Medicine
                elif path == "/api/admin/add_medicine":
                    name = data.get("name", "New Medicine")
                    active_ingredient = data.get("active_ingredient", "")
                    category = data.get("category", "General")
                    form = data.get("form", "Tablet")
                    example_strength = data.get("example_strength", "500mg")
                    uses = data.get("uses", "")
                    precautions = data.get("precautions", "")
                    common_side_effects = data.get("common_side_effects", "")

                    cur.execute("""
                        INSERT INTO medicines (name, active_ingredient, category, form, example_strength, uses, precautions, common_side_effects)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                    """, (name, active_ingredient, category, form, example_strength, uses, precautions, common_side_effects))
                    con.commit()
                    con.close()
                    log_activity("ADD_MEDICINE", f"Added medicine '{name}'")
                    return self.send_json({"status": "ok", "message": "Medicine added successfully"})

                # 12. Delete User
                elif path == "/api/admin/delete_user":
                    user_id = int(data.get("id") or params.get("id", [0])[0])
                    cur.execute("DELETE FROM users WHERE id = ?", (user_id,))
                    con.commit()
                    con.close()
                    log_activity("DELETE_USER", f"Deleted user #{user_id}")
                    return self.send_json({"status": "ok", "message": "User deleted successfully"})

                # 13. Delete Log
                elif path == "/api/admin/delete_log":
                    log_id = int(data.get("id") or params.get("id", [0])[0])
                    cur.execute("DELETE FROM activity_logs WHERE id = ?", (log_id,))
                    con.commit()
                    con.close()
                    return self.send_json({"status": "ok", "message": "Log deleted successfully"})

                # 14. Clear Activity Logs
                elif path == "/api/admin/clear_logs":
                    cur.execute("DELETE FROM activity_logs")
                    con.commit()
                    con.close()
                    return self.send_json({"status": "ok", "message": "Activity logs cleared"})

                # 15. Clear Email Logs
                elif path == "/api/admin/clear_email_logs":
                    cur.execute("DELETE FROM email_logs")
                    con.commit()
                    con.close()
                    return self.send_json({"status": "ok", "message": "Email logs cleared"})

                # 16. Email Settings update
                elif path == "/api/admin/email_settings":
                    for key, val in data.items():
                        cur.execute("INSERT OR REPLACE INTO admin_settings (key, value) VALUES (?, ?)", (str(key), str(val)))
                    con.commit()
                    con.close()
                    log_activity("UPDATE_SETTINGS", "Updated system settings")
                    return self.send_json({"status": "ok", "message": "Email settings saved successfully"})

                # 17. Send Test Email
                elif path == "/api/admin/send_test_email":
                    recipient = data.get("email", "dev@medipulse.com")
                    cur.execute("""
                        INSERT INTO email_logs (recipient, subject, body, status)
                        VALUES (?, ?, ?, ?)
                    """, (recipient, "MediPulse Developer Test Email", "This is a verified test email sent from the MediPulse Admin Console.", "SENT"))
                    con.commit()
                    con.close()
                    log_activity("TEST_EMAIL", f"Sent test email to {recipient}")
                    return self.send_json({"status": "ok", "message": f"Test email dispatched to {recipient}"})

                else:
                    con.close()
                    return self.send_json({"error": "Unknown POST endpoint"}, 404)

            except Exception as e:
                return self.send_json({"error": str(e)}, 500)

        return self.send_json({"error": "Invalid API route"}, 400)

def run():
    seed_database_if_needed()
    with socketserver.TCPServer(("", PORT), MediPulseHandler) as httpd:
        print(f"\n=======================================================")
        print(f"  MediPulse Backend REST API & Admin Server is Running!")
        print(f"  URL: http://localhost:{PORT}")
        print(f"  Admin: http://localhost:{PORT}/admin.html")
        print(f"=======================================================\n")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nServer stopped.")

if __name__ == "__main__":
    run()
