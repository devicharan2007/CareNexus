# -*- coding: utf-8 -*-
"""
CareNexus | Full-Stack Health Hub Server & Automated Developer Email Notifications
Ultra-Fast Multi-Threaded Python Web Server + SQLite DB + Windows Toast + SMTP Engine
"""

import sys
import os
import json
import sqlite3
import smtplib
import subprocess
import webbrowser
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from http.server import ThreadingHTTPServer, BaseHTTPRequestHandler
import urllib.parse
from datetime import datetime
import threading

PORT = 8000
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.path.join(BASE_DIR, "health_medicine.db")

# Initialize SQLite Database & Tables with Rich Profile Fields
def init_db():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        role TEXT NOT NULL DEFAULT 'Patient',
        phone TEXT DEFAULT '',
        age INTEGER DEFAULT 0,
        gender TEXT DEFAULT 'Not Specified',
        blood_group TEXT DEFAULT 'Unknown',
        city TEXT DEFAULT '',
        medical_notes TEXT DEFAULT '',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS activity_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        event_type TEXT NOT NULL,
        user_name TEXT NOT NULL,
        user_email TEXT NOT NULL,
        details TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS admin_settings (
        key TEXT PRIMARY KEY,
        value TEXT
    );
    """)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS email_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        recipient TEXT NOT NULL,
        subject TEXT NOT NULL,
        body TEXT NOT NULL,
        status TEXT NOT NULL,
        sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """)
    
    defaults = [
        ('developer_email', 'devicharan.cse@gmail.com'),
        ('email_alerts_enabled', '1'),
        ('alert_on_signup', '1'),
        ('alert_on_login', '1'),
        ('smtp_host', 'smtp.gmail.com'),
        ('smtp_port', '587'),
        ('smtp_user', 'devicharan.cse@gmail.com'),
        ('smtp_pass', '')
    ]
    for k, v in defaults:
        cursor.execute("INSERT OR IGNORE INTO admin_settings (key, value) VALUES (?, ?)", (k, v))

    conn.commit()
    conn.close()

init_db()

# Load HTML Files
HTML_PATH = os.path.join(BASE_DIR, "index.html")
ADMIN_HTML_PATH = os.path.join(BASE_DIR, "admin.html")

with open(HTML_PATH, "r", encoding="utf-8") as f:
    HTML_BYTES = f.read().encode('utf-8')

with open(ADMIN_HTML_PATH, "r", encoding="utf-8") as f:
    ADMIN_HTML_BYTES = f.read().encode('utf-8')

def get_setting(key, default=""):
    try:
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()
        cursor.execute("SELECT value FROM admin_settings WHERE key = ?", (key,))
        row = cursor.fetchone()
        conn.close()
        return row[0] if row else default
    except Exception:
        return default

def set_setting(key, value):
    try:
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()
        cursor.execute("INSERT OR REPLACE INTO admin_settings (key, value) VALUES (?, ?)", (key, str(value)))
        conn.commit()
        conn.close()
    except Exception as e:
        print(f"[ERROR] Failed to save setting {key}: {e}", flush=True)

def log_activity_to_db(event_type, name, email, details=""):
    try:
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()
        cursor.execute("INSERT INTO activity_logs (event_type, user_name, user_email, details) VALUES (?, ?, ?, ?)",
                       (event_type, name, email, details))
        conn.commit()
        conn.close()
    except Exception as e:
        print(f"[ERROR] Failed to log activity: {e}", flush=True)

def log_email_to_db(recipient, subject, body, status):
    try:
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()
        cursor.execute("INSERT INTO email_logs (recipient, subject, body, status) VALUES (?, ?, ?, ?)",
                       (recipient, subject, body, status))
        conn.commit()
        conn.close()
    except Exception as e:
        print(f"[ERROR] Failed to log email: {e}", flush=True)

# TRIGGER WINDOWS DESKTOP POPUP NOTIFICATION (POPS UP ON DEVELOPER'S SCREEN)
def trigger_windows_toast_notification(title, message):
    def _toast():
        try:
            ps_cmd = f"""
            [reflection.assembly]::loadwithpartialname('System.Windows.Forms') | Out-Null
            $notify = New-Object System.Windows.Forms.NotifyIcon
            $notify.Icon = [System.Drawing.SystemIcons]::Information
            $notify.Visible = $true
            $notify.ShowBalloonTip(10000, '{title}', '{message}', [System.Windows.Forms.ToolTipIcon]::Info)
            """
            subprocess.Popen(["powershell", "-Command", ps_cmd], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        except Exception:
            pass
    threading.Thread(target=_toast, daemon=True).start()

# ASYNCHRONOUS EMAIL DISPATCH ENGINE
def send_email_notification_async(subject, body):
    def _worker():
        dev_email = get_setting('developer_email', 'devicharan.cse@gmail.com')
        smtp_host = get_setting('smtp_host', 'smtp.gmail.com')
        smtp_port = int(get_setting('smtp_port', '587'))
        smtp_user = get_setting('smtp_user', dev_email)
        smtp_pass = get_setting('smtp_pass', '').strip()

        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        # Format ASCII-Safe Terminal Alert Notice
        safe_subject = subject.encode('ascii', 'ignore').decode('ascii')
        print("\n" + "*" * 65, flush=True)
        print("  [DEVELOPER EMAIL ALERT DISPATCHED]", flush=True)
        print("*" * 65, flush=True)
        print(f"  * Recipient: {dev_email}", flush=True)
        print(f"  * Subject:   {safe_subject}", flush=True)
        print(f"  * Time:      {timestamp}", flush=True)
        print("*" * 65 + "\n", flush=True)

        # Trigger Windows Desktop Screen Popup
        trigger_windows_toast_notification(safe_subject, f"Recipient: {dev_email}\nCheck Developer Admin Center for details!")

        # Attempt Real SMTP Delivery if credentials provided
        if smtp_pass:
            try:
                msg = MIMEMultipart()
                msg['From'] = smtp_user if smtp_user else dev_email
                msg['To'] = dev_email
                msg['Subject'] = subject
                msg.attach(MIMEText(body, 'plain'))

                server = smtplib.SMTP(smtp_host, smtp_port, timeout=12)
                server.starttls()
                server.login(smtp_user, smtp_pass)
                server.sendmail(smtp_user, [dev_email], msg.as_string())
                server.quit()

                log_email_to_db(dev_email, subject, body, "SENT (Delivered to Gmail)")
                print(f"[EMAIL ENGINE] Email successfully delivered to {dev_email} via SMTP!\n", flush=True)
                return
            except Exception as e:
                print(f"[EMAIL ENGINE] SMTP Delivery notice: {e} (Logged to DB)\n", flush=True)
                log_email_to_db(dev_email, subject, body, f"FAILED ({str(e)[:30]})")
                return

        # Default Logged Mode (Ready for SMTP)
        log_email_to_db(dev_email, subject, body, "LOGGED (Captured in DB)")

    threading.Thread(target=_worker, daemon=True).start()

class CareNexusServerHandler(BaseHTTPRequestHandler):
    protocol_version = "HTTP/1.1"

    def address_string(self):
        # Disable slow Windows reverse DNS lookups (instant response)
        return self.client_address[0]

    def do_GET(self):
        parsed = urllib.parse.urlparse(self.path)
        
        # 1. Main Client Portal
        if parsed.path in ('/', '/index.html'):
            try:
                with open(HTML_PATH, "rb") as f:
                    content = f.read()
            except Exception:
                content = HTML_BYTES
            self.send_html_response(content)
            return

        # 2. Developer Admin Center
        elif parsed.path in ('/admin', '/admin.html'):
            try:
                with open(ADMIN_HTML_PATH, "rb") as f:
                    content = f.read()
            except Exception:
                content = ADMIN_HTML_BYTES
            self.send_html_response(content)
            return

        # 3. API: Health check
        elif parsed.path == '/api/health':
            self.send_json_response(200, {"status": "online", "database": "SQLite connected", "users_count": self.get_user_count()})
            return

        # 4. API: List all users in database with rich profile
        elif parsed.path == '/api/auth/users':
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            cursor.execute("""
            SELECT id, name, email, role, phone, age, gender, blood_group, city, medical_notes, created_at 
            FROM users ORDER BY id DESC
            """)
            rows = cursor.fetchall()
            conn.close()
            users_list = [{
                "id": r[0], "name": r[1], "email": r[2], "role": r[3],
                "phone": r[4], "age": r[5], "gender": r[6], "blood_group": r[7],
                "city": r[8], "medical_notes": r[9], "created_at": r[10]
            } for r in rows]
            self.send_json_response(200, {"total": len(users_list), "users": users_list})
            return

        # 5. API: Activity logs
        elif parsed.path == '/api/admin/logs':
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            cursor.execute("SELECT id, event_type, user_name, user_email, details, created_at FROM activity_logs ORDER BY id DESC LIMIT 25")
            rows = cursor.fetchall()
            conn.close()
            logs_list = [{"id": r[0], "event_type": r[1], "user_name": r[2], "user_email": r[3], "details": r[4], "created_at": r[5]} for r in rows]
            self.send_json_response(200, {"total": len(logs_list), "logs": logs_list})
            return

        # 6. API: Email logs
        elif parsed.path == '/api/admin/email_logs':
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            cursor.execute("SELECT id, recipient, subject, body, status, sent_at FROM email_logs ORDER BY id DESC LIMIT 25")
            rows = cursor.fetchall()
            conn.close()
            logs_list = [{"id": r[0], "recipient": r[1], "subject": r[2], "status": r[4], "sent_at": r[5]} for r in rows]
            self.send_json_response(200, {"total": len(logs_list), "logs": logs_list})
            return

        # 7. API: Email settings
        elif parsed.path == '/api/admin/email_settings':
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            cursor.execute("SELECT key, value FROM admin_settings")
            rows = cursor.fetchall()
            conn.close()
            settings_dict = {r[0]: r[1] for r in rows}
            self.send_json_response(200, settings_dict)
            return

        # API: Delete single activity log (GET or POST)
        elif parsed.path.startswith('/api/admin/delete_log'):
            query_params = urllib.parse.parse_qs(parsed.query)
            log_id = query_params.get('id', [None])[0]
            if log_id:
                conn = sqlite3.connect(DB_PATH)
                cursor = conn.cursor()
                cursor.execute("DELETE FROM activity_logs WHERE id = ?", (log_id,))
                conn.commit()
                conn.close()
                print(f"[DEVELOPER ADMIN] Activity log #{log_id} deleted.", flush=True)
                self.send_json_response(200, {"success": True, "message": f"Log #{log_id} deleted"})
                return

        # API: Clear all activity logs (GET or POST)
        elif parsed.path == '/api/admin/clear_logs':
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            cursor.execute("DELETE FROM activity_logs")
            conn.commit()
            conn.close()
            print("[DEVELOPER ADMIN] All activity logs cleared.", flush=True)
            self.send_json_response(200, {"success": True, "message": "All activity logs cleared"})
            return

        # API: Get doctors directory
        elif parsed.path == '/api/doctors':
            query_params = urllib.parse.parse_qs(parsed.query)
            specialty_filter = query_params.get('specialty', [None])[0]
            city_filter = query_params.get('city', [None])[0]

            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            query = "SELECT id, name, specialty, qualification, experience_years, hospital_clinic, city, consultation_fee, rating, available_days, available_slots FROM doctors WHERE 1=1"
            params = []
            if specialty_filter:
                query += " AND specialty LIKE ?"
                params.append(f"%{specialty_filter}%")
            if city_filter:
                query += " AND city LIKE ?"
                params.append(f"%{city_filter}%")
            query += " ORDER BY rating DESC, experience_years DESC"
            
            rows = cursor.execute(query, params).fetchall()
            conn.close()

            doctors_list = []
            for r in rows:
                doctors_list.append({
                    "id": r[0],
                    "name": r[1],
                    "specialty": r[2],
                    "qualification": r[3] or "",
                    "experience_years": r[4] or 0,
                    "hospital_clinic": r[5] or "",
                    "city": r[6] or "",
                    "consultation_fee": r[7] or "Free",
                    "rating": r[8] or 4.8,
                    "available_days": r[9] or "Mon-Sat",
                    "available_slots": [s.strip() for s in (r[10] or '').split(',') if s.strip()]
                })
            self.send_json_response(200, {"total": len(doctors_list), "doctors": doctors_list})
            return

        # API: Delete doctor via GET / POST fallback
        elif parsed.path.startswith('/api/admin/delete_doctor'):
            query_params = urllib.parse.parse_qs(parsed.query)
            doc_id = query_params.get('id', [None])[0]
            if doc_id:
                conn = sqlite3.connect(DB_PATH, timeout=10)
                cursor = conn.cursor()
                cursor.execute("DELETE FROM doctors WHERE id = ?", (doc_id,))
                conn.commit()
                conn.close()
                log_activity_to_db("DOCTOR_DELETE", "Developer", "admin@carenexus.local", f"Deleted Doctor ID #{doc_id}")
                print(f"[DEVELOPER ADMIN] Doctor #{doc_id} deleted permanently.", flush=True)
                self.send_json_response(200, {"success": True, "message": f"Doctor #{doc_id} deleted permanently"})
                return

        # API: Clear all doctors via GET / POST fallback
        elif parsed.path.startswith('/api/admin/clear_doctors'):
            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            cursor.execute("DELETE FROM doctors")
            conn.commit()
            conn.close()
            log_activity_to_db("DOCTOR_CLEAR", "Developer", "admin@carenexus.local", "Cleared all doctors from directory")
            print("[DEVELOPER ADMIN] All doctors cleared from directory.", flush=True)
            self.send_json_response(200, {"success": True, "message": "All doctors cleared from directory"})
            return

        # API: Delete appointment via GET / POST fallback
        elif parsed.path.startswith('/api/appointments/delete'):
            query_params = urllib.parse.parse_qs(parsed.query)
            apt_id = query_params.get('id', [None])[0]
            if apt_id:
                conn = sqlite3.connect(DB_PATH, timeout=10)
                cursor = conn.cursor()
                cursor.execute("DELETE FROM appointments WHERE id = ? OR booking_id = ?", (apt_id, apt_id))
                conn.commit()
                conn.close()
                log_activity_to_db("APPOINTMENT_DELETE", "Developer", "admin@carenexus.local", f"Deleted Appointment #{apt_id}")
                print(f"[DEVELOPER ADMIN] Appointment #{apt_id} permanently deleted.", flush=True)
                self.send_json_response(200, {"success": True, "message": f"Appointment #{apt_id} deleted permanently"})
                return

        # API: Clear all appointments via GET / POST fallback
        elif parsed.path.startswith('/api/appointments/clear_all'):
            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            cursor.execute("DELETE FROM appointments")
            conn.commit()
            conn.close()
            log_activity_to_db("APPOINTMENT_CLEAR", "Developer", "admin@carenexus.local", "Cleared all appointment bookings from queue")
            print("[DEVELOPER ADMIN] All patient appointments cleared.", flush=True)
            self.send_json_response(200, {"success": True, "message": "All appointments cleared from queue"})
            return

        # API: Get all appointments (with optional email filter)
        elif parsed.path == '/api/appointments':
            query_params = urllib.parse.parse_qs(parsed.query)
            email_filter = query_params.get('email', [None])[0]

            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            if email_filter:
                rows = cursor.execute("SELECT id, booking_id, patient_name, patient_phone, patient_email, doctor_id, doctor_name, specialty, hospital_clinic, appointment_date, time_slot, consultation_type, status, symptoms_summary, created_at FROM appointments WHERE patient_email = ? ORDER BY id DESC", (email_filter,)).fetchall()
            else:
                rows = cursor.execute("SELECT id, booking_id, patient_name, patient_phone, patient_email, doctor_id, doctor_name, specialty, hospital_clinic, appointment_date, time_slot, consultation_type, status, symptoms_summary, created_at FROM appointments ORDER BY id DESC").fetchall()
            conn.close()

            apts_list = []
            for r in rows:
                apts_list.append({
                    "id": r[0],
                    "booking_id": r[1],
                    "patient_name": r[2],
                    "patient_phone": r[3],
                    "patient_email": r[4],
                    "doctor_id": r[5],
                    "doctor_name": r[6],
                    "specialty": r[7],
                    "hospital_clinic": r[8],
                    "appointment_date": r[9],
                    "time_slot": r[10],
                    "consultation_type": r[11],
                    "status": r[12],
                    "symptoms_summary": r[13],
                    "created_at": r[14]
                })
            self.send_json_response(200, {"total": len(apts_list), "appointments": apts_list})
            return

        # API: Get all medical conditions with mapped medicines for Frontend & Admin
        elif parsed.path in ('/api/conditions', '/api/admin/conditions'):
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            rows = cursor.execute("SELECT id, name, symptoms, specialist, diet, fitness, recommended_tests, emergency_red_flags FROM conditions ORDER BY id ASC").fetchall()
            
            # Map condition_id to medicine names
            cm_map = {}
            for cid, mname in cursor.execute("SELECT cm.condition_id, m.name FROM condition_medicines cm JOIN medicines m ON cm.medicine_id = m.id").fetchall():
                if cid not in cm_map:
                    cm_map[cid] = []
                cm_map[cid].append(mname)
            conn.close()

            conditions_list = []
            for r in rows:
                cid = r[0]
                raw_sym = r[2] or ''
                parsed_syms = []
                try:
                    if raw_sym.startswith('['):
                        parsed_syms = json.loads(raw_sym)
                    else:
                        parsed_syms = [s.strip().strip('"\'[]') for s in raw_sym.split(',') if s.strip()]
                except Exception:
                    parsed_syms = [s.strip().strip('"\'[]') for s in raw_sym.split(',') if s.strip()]

                med_names = cm_map.get(cid, [])
                conditions_list.append({
                    "id": cid,
                    "condition_id": cid,
                    "name": r[1],
                    "condition": r[1],
                    "symptoms": parsed_syms,
                    "specialist": r[3] or 'General Physician',
                    "diet": r[4] or 'Balanced nutritious meals, adequate hydration.',
                    "fitness": r[5] or 'Light to moderate physical activity as tolerated.',
                    "recommended_tests": r[6] or 'Routine clinical blood tests',
                    "tests": r[6] or 'Routine clinical blood tests',
                    "emergency_red_flags": r[7] or 'Severe acute chest pain, sudden shortness of breath',
                    "red_flags": r[7] or 'Severe acute chest pain, sudden shortness of breath',
                    "medicine_names": med_names,
                    "medicines": med_names,
                    "doctor_preference": "Comprehensive clinical evaluation and tailored medical management."
                })
            self.send_json_response(200, {"total": len(conditions_list), "conditions": conditions_list})
            return

        # API: Get all pharmaceutical medications for Frontend & Admin
        elif parsed.path in ('/api/medicines', '/api/admin/medicines'):
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            rows = cursor.execute("SELECT id, name, active_ingredient, category, uses, form, example_strength, precautions, common_side_effects FROM medicines ORDER BY id ASC").fetchall()
            conn.close()

            meds_list = []
            for r in rows:
                meds_list.append({
                    "id": r[0],
                    "medicine_id": r[0],
                    "name": r[1],
                    "active_ingredient": r[2] or '',
                    "category": r[3] or 'General',
                    "uses": r[4] or 'Clinical therapy',
                    "form": r[5] or 'Tablet',
                    "example_strength": r[6] or 'Standard',
                    "precautions": r[7] or 'Consult physician before use',
                    "common_side_effects": r[8] or 'Mild nausea, headache'
                })
            self.send_json_response(200, {"total": len(meds_list), "medicines": meds_list})
            return


        # Fallback 404
        self.send_error(404, "File Not Found")

    def do_POST(self):
        try:
            self._handle_post_internal()
        except Exception as e:
            import traceback
            print(f"[POST ERROR] {self.path}: {traceback.format_exc()}", flush=True)
            self.send_json_response(500, {"success": False, "message": str(e)})

    def _handle_post_internal(self):
        parsed = urllib.parse.urlparse(self.path)
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length).decode('utf-8') if content_length > 0 else ""
        
        try:
            payload = json.loads(post_data) if post_data else {}
        except Exception:
            payload = {}

        # API: Sign Up with Rich Health Profile
        if parsed.path == '/api/auth/signup':
            name = payload.get('name', '').strip()
            email = payload.get('email', '').strip().lower()
            password = payload.get('password', '')
            role = payload.get('role', 'Patient')
            phone = payload.get('phone', '').strip()
            city = payload.get('city', '').strip()
            age = payload.get('age', 0)
            gender = payload.get('gender', 'Not Specified')
            blood_group = payload.get('blood_group', 'Unknown')
            medical_notes = payload.get('medical_notes', '').strip()

            if not name or not email or not password:
                self.send_json_response(400, {"success": False, "message": "Name, email, and password are required"})
                return

            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            try:
                cursor.execute("""
                INSERT INTO users (name, email, password, role, phone, age, gender, blood_group, city, medical_notes) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """, (name, email, password, role, phone, age, gender, blood_group, city, medical_notes))
                conn.commit()
                user_id = cursor.lastrowid
                conn.close()

                # Log activity
                log_activity_to_db("SIGNUP", name, email, f"Role: {role}, Phone: {phone}, Blood: {blood_group}")

                # DEVELOPER LIVE TERMINAL ALERT
                timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                print("\n" + "=" * 65, flush=True)
                print("  [DEVELOPER ALERT] NEW USER REGISTRATION DETECTED!", flush=True)
                print("=" * 65, flush=True)
                print(f"  * User ID:      #{user_id}", flush=True)
                print(f"  * Name:         {name}", flush=True)
                print(f"  * Email:        {email}", flush=True)
                print(f"  * Phone:        {phone}", flush=True)
                print(f"  * Blood Group:  {blood_group}", flush=True)
                print(f"  * Age / Gender: {age} yrs / {gender}", flush=True)
                print(f"  * Location:     {city}", flush=True)
                print(f"  * Role:         {role}", flush=True)
                print(f"  * Health Notes: {medical_notes}", flush=True)
                print("=" * 65 + "\n", flush=True)

                # TRIGGER DEVELOPER EMAIL NOTIFICATION WITH FULL HEALTH PROFILE
                email_subject = f"[CareNexus Alert] New User Registration: {name}"
                email_body = f"""Hello Developer,

A new user has just registered on your CareNexus Health Platform!

=======================================================
               NEW USER MEDICAL PROFILE
=======================================================
* User ID:           #{user_id}
* Full Name:         {name}
* Email Address:     {email}
* Phone Number:      {phone if phone else 'Not provided'}
* Account Role:      {role}
* Age:               {age if age else 'Not provided'}
* Gender:            {gender}
* Blood Group:       {blood_group}
* City / Location:   {city if city else 'Not provided'}
* Health Conditions: {medical_notes if medical_notes else 'None recorded'}
* Registration Time: {timestamp}
=======================================================

Manage and view all registered users in your Developer Admin Center:
http://localhost:8000/admin

Best regards,
CareNexus System Engine
"""
                send_email_notification_async(email_subject, email_body)

                self.send_json_response(200, {
                    "success": True, 
                    "message": "Account created and saved in SQLite database successfully",
                    "user": {
                        "id": user_id, "name": name, "email": email, "role": role,
                        "phone": phone, "age": age, "gender": gender, "blood_group": blood_group, "city": city
                    }
                })
            except sqlite3.IntegrityError:
                conn.close()
                self.send_json_response(409, {"success": False, "message": "An account with this email already exists"})
            except Exception as e:
                conn.close()
                self.send_json_response(500, {"success": False, "message": f"Database error: {str(e)}"})
            return

        # API: Login
        elif parsed.path == '/api/auth/login':
            email = payload.get('email', '').strip().lower()
            password = payload.get('password', '')

            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            cursor.execute("""
            SELECT id, name, email, password, role, phone, age, gender, blood_group, city 
            FROM users WHERE LOWER(email) = ?
            """, (email,))
            user_row = cursor.fetchone()
            conn.close()

            if not user_row:
                self.send_json_response(404, {"success": False, "message": "No account found with this email. Please Sign Up!"})
                return

            user_id, db_name, db_email, db_password, db_role, phone, age, gender, blood_group, city = user_row
            if db_password == password:
                log_activity_to_db("LOGIN", db_name, db_email, "User logged in")
                timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                print(f"[DEVELOPER ALERT] [{timestamp}] User Logged In: {db_name} ({db_email})", flush=True)

                if get_setting('alert_on_login', '1') == '1':
                    email_subject = f"[CareNexus Alert] User Logged In: {db_name}"
                    email_body = f"User {db_name} ({db_email}) logged in to CareNexus at {timestamp}."
                    send_email_notification_async(email_subject, email_body)
                
                self.send_json_response(200, {
                    "success": True, 
                    "message": "Login successful",
                    "user": {
                        "id": user_id, "name": db_name, "email": db_email, "role": db_role,
                        "phone": phone, "age": age, "gender": gender, "blood_group": blood_group, "city": city
                    }
                })
            else:
                self.send_json_response(401, {"success": False, "message": "Incorrect password. Please try again."})
            return

        # API: Update Email Settings
        elif parsed.path == '/api/admin/email_settings':
            for k in ['developer_email', 'alert_on_signup', 'alert_on_login', 'smtp_host', 'smtp_port', 'smtp_user', 'smtp_pass', 'email_alerts_enabled']:
                if k in payload:
                    set_setting(k, payload[k])
            print(f"[DEVELOPER ADMIN] Updated Developer Email Settings: {payload}", flush=True)
            self.send_json_response(200, {"success": True, "message": "Email settings saved"})
            return

        # API: Send Test Email Alert
        elif parsed.path == '/api/admin/send_test_email':
            target_email = payload.get('email', get_setting('developer_email', 'devicharan.cse@gmail.com'))
            subject = "[CareNexus Test] Developer Email Alerts are Active!"
            body = f"""Hello Developer,

This is a test alert from your CareNexus Health Portal Server.

Your real-time automated email alert engine is online and functioning properly.
Whenever a new user registers with their name, phone number, blood group, age, and health details, you will receive an automatic alert.

Timestamp: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
Server: http://localhost:8000
"""
            send_email_notification_async(subject, body)
            self.send_json_response(200, {"success": True, "status": "Dispatched", "recipient": target_email})
            return

        # API: Delete user
        elif parsed.path.startswith('/api/admin/delete_user'):
            query_params = urllib.parse.parse_qs(parsed.query)
            user_id = query_params.get('id', [None])[0]
            if user_id:
                conn = sqlite3.connect(DB_PATH)
                cursor = conn.cursor()
                cursor.execute("DELETE FROM users WHERE id = ?", (user_id,))
                conn.commit()
                conn.close()
                print(f"[DEVELOPER ADMIN] User ID #{user_id} deleted from database.", flush=True)
                self.send_json_response(200, {"success": True, "message": f"User #{user_id} deleted"})
                return

                # API: Clear all email logs
        elif parsed.path == '/api/admin/clear_email_logs':
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            cursor.execute("DELETE FROM email_logs")
            conn.commit()
            conn.close()
            print("[DEVELOPER ADMIN] Cleared all email dispatch logs.", flush=True)
            self.send_json_response(200, {"success": True, "message": "Email logs cleared"})
            return

                # API: Delete a specific activity log entry by ID
        elif parsed.path.startswith('/api/admin/delete_log'):
            query_params = urllib.parse.parse_qs(parsed.query)
            log_id = query_params.get('id', [None])[0]
            if log_id:
                conn = sqlite3.connect(DB_PATH)
                cursor = conn.cursor()
                cursor.execute("DELETE FROM activity_logs WHERE id = ?", (log_id,))
                conn.commit()
                conn.close()
                print(f"[DEVELOPER ADMIN] Activity log #{log_id} deleted.", flush=True)
                self.send_json_response(200, {"success": True, "message": f"Log #{log_id} deleted"})
                return

        # API: Clear all activity logs
        elif parsed.path == '/api/admin/clear_logs':
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            cursor.execute("DELETE FROM activity_logs")
            conn.commit()
            conn.close()
            print("[DEVELOPER ADMIN] All activity logs cleared.", flush=True)
            self.send_json_response(200, {"success": True, "message": "All activity logs cleared"})
            return

                # API: Clear all doctors from directory (Admin / Developer)
        elif parsed.path == '/api/admin/clear_doctors':
            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            cursor.execute("DELETE FROM doctors")
            conn.commit()
            conn.close()
            log_activity_to_db("DOCTOR_CLEAR", "Developer", "admin@carenexus.local", "Cleared all doctors from directory")
            print("[DEVELOPER ADMIN] All doctors cleared from directory.", flush=True)
            self.send_json_response(200, {"success": True, "message": "All doctors cleared from directory"})
            return

        # API: Add a new doctor (Admin / Developer)
        elif parsed.path == '/api/admin/add_doctor':
            name = payload.get('name', '').strip()
            specialty = payload.get('specialty', '').strip()
            qualification = payload.get('qualification', 'MBBS, MD').strip()
            experience_years = int(payload.get('experience_years', 5))
            hospital_clinic = payload.get('hospital_clinic', '').strip()
            city = payload.get('city', '').strip()
            consultation_fee = payload.get('consultation_fee', 'Rs. 500').strip()
            rating = float(payload.get('rating', 4.9))
            available_days = payload.get('available_days', 'Mon-Sat').strip()
            available_slots = payload.get('available_slots', '09:30 AM, 11:00 AM, 04:30 PM, 06:00 PM').strip()

            if not name or not specialty or not hospital_clinic:
                self.send_json_response(400, {"success": False, "message": "Doctor Name, Specialty, and Hospital are required"})
                return

            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            cursor.execute("""
            INSERT INTO doctors (name, specialty, qualification, experience_years, hospital_clinic, city, consultation_fee, rating, available_days, available_slots)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (name, specialty, qualification, experience_years, hospital_clinic, city, consultation_fee, rating, available_days, available_slots))
            new_id = cursor.lastrowid
            conn.commit()
            conn.close()

            log_activity_to_db("DOCTOR_ADD", "Developer", "admin@carenexus.local", f"Added Doctor: {name} ({specialty})")
            print(f"[DEVELOPER ADMIN] Added new doctor #{new_id}: {name} ({specialty})", flush=True)
            self.send_json_response(200, {"success": True, "message": f"Doctor {name} added successfully!", "id": new_id})
            return

        # API: Edit an existing doctor (Admin / Developer)
        elif parsed.path == '/api/admin/edit_doctor':
            doc_id = payload.get('id')
            name = payload.get('name', '').strip()
            specialty = payload.get('specialty', '').strip()
            qualification = payload.get('qualification', '').strip()
            experience_years = int(payload.get('experience_years', 5))
            hospital_clinic = payload.get('hospital_clinic', '').strip()
            city = payload.get('city', '').strip()
            consultation_fee = payload.get('consultation_fee', 'Rs. 500').strip()
            rating = float(payload.get('rating', 4.9))
            available_days = payload.get('available_days', 'Mon-Sat').strip()
            available_slots = payload.get('available_slots', '09:30 AM, 11:00 AM, 04:30 PM, 06:00 PM').strip()

            if not doc_id or not name or not specialty:
                self.send_json_response(400, {"success": False, "message": "Doctor ID, Name, and Specialty are required"})
                return

            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            cursor.execute("""
            UPDATE doctors 
            SET name = ?, specialty = ?, qualification = ?, experience_years = ?, hospital_clinic = ?, city = ?, consultation_fee = ?, rating = ?, available_days = ?, available_slots = ?
            WHERE id = ?
            """, (name, specialty, qualification, experience_years, hospital_clinic, city, consultation_fee, rating, available_days, available_slots, doc_id))
            conn.commit()
            conn.close()

            log_activity_to_db("DOCTOR_EDIT", "Developer", "admin@carenexus.local", f"Updated Doctor #{doc_id}: {name}")
            print(f"[DEVELOPER ADMIN] Updated doctor #{doc_id}: {name}", flush=True)
            self.send_json_response(200, {"success": True, "message": f"Doctor {name} updated successfully!"})
            return

        # API: Delete a doctor via POST
        elif parsed.path.startswith('/api/admin/delete_doctor'):
            query_params = urllib.parse.parse_qs(parsed.query)
            doc_id = query_params.get('id', [None])[0] or payload.get('id')
            if doc_id:
                conn = sqlite3.connect(DB_PATH, timeout=10)
                cursor = conn.cursor()
                cursor.execute("DELETE FROM doctors WHERE id = ?", (doc_id,))
                conn.commit()
                conn.close()
                log_activity_to_db("DOCTOR_DELETE", "Developer", "admin@carenexus.local", f"Deleted Doctor ID #{doc_id}")
                print(f"[DEVELOPER ADMIN] Doctor #{doc_id} deleted permanently.", flush=True)
                self.send_json_response(200, {"success": True, "message": f"Doctor #{doc_id} deleted permanently"})
                return

        # API: Book a new doctor appointment
        elif parsed.path == '/api/appointments/book':
            patient_name = payload.get('patient_name', '').strip()
            patient_phone = payload.get('patient_phone', '').strip()
            patient_email = payload.get('patient_email', '').strip().lower()
            doctor_id = payload.get('doctor_id')
            doctor_name = payload.get('doctor_name', '').strip()
            specialty = payload.get('specialty', '').strip()
            hospital_clinic = payload.get('hospital_clinic', '').strip()
            appointment_date = payload.get('appointment_date', '').strip()
            time_slot = payload.get('time_slot', '').strip()
            consultation_type = payload.get('consultation_type', 'In-Person').strip()
            symptoms_summary = payload.get('symptoms_summary', '').strip()

            if not patient_name or not patient_phone or not doctor_name or not appointment_date or not time_slot:
                self.send_json_response(400, {"success": False, "message": "All appointment details are required"})
                return

            import random
            booking_id = f"CN-2026-{random.randint(1000, 9999)}"

            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            cursor.execute("""
            INSERT INTO appointments (booking_id, patient_name, patient_phone, patient_email, doctor_id, doctor_name, specialty, hospital_clinic, appointment_date, time_slot, consultation_type, status, symptoms_summary)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'CONFIRMED', ?)
            """, (booking_id, patient_name, patient_phone, patient_email, doctor_id, doctor_name, specialty, hospital_clinic, appointment_date, time_slot, consultation_type, symptoms_summary))
            new_id = cursor.lastrowid
            conn.commit()
            conn.close()

            # Log to activity stream
            log_activity_to_db("APPOINTMENT_BOOKING", patient_name, patient_email, f"Booked with {doctor_name} ({specialty}) on {appointment_date} at {time_slot} [{booking_id}]")
            
            # Send developer notification
            notify_text = f"NEW DOCTOR APPOINTMENT BOOKING\\n\\nBooking ID: {booking_id}\\nPatient: {patient_name} ({patient_phone})\\nDoctor: {doctor_name} ({specialty})\\nHospital: {hospital_clinic}\\nDate & Slot: {appointment_date} at {time_slot} ({consultation_type})\\nSymptoms: {symptoms_summary}"
            trigger_windows_toast_notification(f"CareNexus: New Booking ({booking_id})", f"{patient_name} booked with {doctor_name} on {appointment_date}")
            send_email_notification_async(f"CareNexus Booking Alert: {patient_name} with {doctor_name} [{booking_id}]", notify_text)

            print(f"[APPOINTMENT] New Booking Confirmed: {booking_id} for {patient_name} with {doctor_name}", flush=True)
            self.send_json_response(200, {
                "success": True, 
                "message": f"Appointment booked successfully with {doctor_name}!",
                "booking_id": booking_id,
                "id": new_id
            })
            return

        # API: Permanently delete an appointment from SQLite (Admin / Developer)
        elif parsed.path.startswith('/api/appointments/delete'):
            query_params = urllib.parse.parse_qs(parsed.query)
            apt_id = query_params.get('id', [None])[0] or payload.get('id')
            if apt_id:
                conn = sqlite3.connect(DB_PATH, timeout=10)
                cursor = conn.cursor()
                cursor.execute("DELETE FROM appointments WHERE id = ? OR booking_id = ?", (apt_id, apt_id))
                conn.commit()
                conn.close()
                log_activity_to_db("APPOINTMENT_DELETE", "Developer", "admin@carenexus.local", f"Deleted Appointment #{apt_id}")
                print(f"[DEVELOPER ADMIN] Appointment #{apt_id} permanently deleted.", flush=True)
                self.send_json_response(200, {"success": True, "message": f"Appointment #{apt_id} deleted permanently"})
                return

        # API: Clear all appointments from queue (Admin / Developer)
        elif parsed.path == '/api/appointments/clear_all':
            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            cursor.execute("DELETE FROM appointments")
            conn.commit()
            conn.close()
            log_activity_to_db("APPOINTMENT_CLEAR", "Developer", "admin@carenexus.local", "Cleared all appointment bookings from queue")
            print("[DEVELOPER ADMIN] All patient appointments cleared.", flush=True)
            self.send_json_response(200, {"success": True, "message": "All appointments cleared from queue"})
            return

        # API: Update appointment status (Admin / Developer)
        elif parsed.path == '/api/appointments/update_status':
            apt_id = payload.get('id')
            new_status = payload.get('status', 'CONFIRMED').upper()

            if not apt_id:
                self.send_json_response(400, {"success": False, "message": "Appointment ID is required"})
                return

            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            cursor.execute("UPDATE appointments SET status = ? WHERE id = ? OR booking_id = ?", (new_status, apt_id, apt_id))
            conn.commit()
            conn.close()

            log_activity_to_db("APPOINTMENT_UPDATE", "Admin", "admin@carenexus.local", f"Updated Appointment #{apt_id} status to {new_status}")
            print(f"[APPOINTMENT] Status of Appointment #{apt_id} updated to {new_status}", flush=True)
            self.send_json_response(200, {"success": True, "message": f"Appointment status updated to {new_status}"})
            return

        # API: Cancel appointment
        elif parsed.path.startswith('/api/appointments/cancel'):
            query_params = urllib.parse.parse_qs(parsed.query)
            apt_id = query_params.get('id', [None])[0]
            if apt_id:
                conn = sqlite3.connect(DB_PATH, timeout=10)
                cursor = conn.cursor()
                cursor.execute("UPDATE appointments SET status = 'CANCELLED' WHERE id = ? OR booking_id = ?", (apt_id, apt_id))
                conn.commit()
                conn.close()
                log_activity_to_db("APPOINTMENT_CANCEL", "Patient", "", f"Cancelled Appointment #{apt_id}")
                self.send_json_response(200, {"success": True, "message": f"Appointment #{apt_id} cancelled"})
                return

        # API: Add new medical condition
        elif parsed.path == '/api/admin/add_condition':
            name = payload.get('condition', '').strip()
            symptoms = payload.get('symptoms', [])
            diet = payload.get('diet', '').strip()
            fitness = payload.get('fitness', '').strip()
            specialist = payload.get('specialist', 'General Physician').strip()
            preference = payload.get('doctor_preference', '').strip()
            tests = payload.get('recommended_tests', '').strip()
            redflags = payload.get('emergency_red_flags', '').strip()
            medicine_names = payload.get('medicine_names', [])

            if not name:
                self.send_json_response(400, {"success": False, "message": "Condition name is required"})
                return

            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            symptoms_str = ", ".join(symptoms) if isinstance(symptoms, list) else str(symptoms)
            cursor.execute("""
            INSERT INTO conditions (name, symptoms, diet, fitness, specialist, doctor_preference, recommended_tests, emergency_red_flags)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """, (name, symptoms_str, diet, fitness, specialist, preference, tests, redflags))
            cond_id = cursor.lastrowid
            conn.commit()
            conn.close()

            # Add activity log after committing
            log_activity_to_db("DATASET_UPDATE", "Developer", "admin@carenexus.local", f"Added Condition: {name} (ID #{cond_id})")

            print(f"[DEVELOPER ADMIN] New Condition Added: {name} (ID #{cond_id})", flush=True)
            self.send_json_response(200, {"success": True, "message": f"Condition '{name}' added successfully (ID #{cond_id})", "id": cond_id})
            return

        # API: Add new medicine / pharmaceutical compound
        elif parsed.path == '/api/admin/add_medicine':
            name = payload.get('name', '').strip()
            active_ingredient = payload.get('active_ingredient', '').strip()
            category = payload.get('category', 'General Medication').strip()
            uses = payload.get('uses', '').strip()
            form = payload.get('form', 'Tablet').strip()
            example_strength = payload.get('example_strength', '').strip()
            precautions = payload.get('precautions', '').strip()
            common_side_effects = payload.get('common_side_effects', '').strip()

            if not name or not active_ingredient:
                self.send_json_response(400, {"success": False, "message": "Medicine name and active ingredient are required"})
                return

            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            cursor.execute("""
            INSERT INTO medicines (name, active_ingredient, category, uses, form, example_strength, precautions, common_side_effects)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """, (name, active_ingredient, category, uses, form, example_strength, precautions, common_side_effects))
            med_id = cursor.lastrowid
            conn.commit()
            conn.close()

            # Add activity log after committing
            log_activity_to_db("DATASET_UPDATE", "Developer", "admin@carenexus.local", f"Added Medicine: {name} (ID #{med_id})")

            print(f"[DEVELOPER ADMIN] New Medicine Added: {name} (ID #{med_id})", flush=True)
            self.send_json_response(200, {"success": True, "message": f"Medicine '{name}' added successfully (ID #{med_id})", "id": med_id})
            return

                # API: Edit / Update existing medical condition
        elif parsed.path == '/api/admin/edit_condition':
            cond_id = payload.get('id')
            name = payload.get('condition', '').strip()
            symptoms = payload.get('symptoms', [])
            diet = payload.get('diet', '').strip()
            fitness = payload.get('fitness', '').strip()
            specialist = payload.get('specialist', 'General Physician').strip()
            preference = payload.get('doctor_preference', '').strip()
            tests = payload.get('recommended_tests', '').strip()
            redflags = payload.get('emergency_red_flags', '').strip()

            if not cond_id or not name:
                self.send_json_response(400, {"success": False, "message": "Condition ID and name are required"})
                return

            conn = sqlite3.connect(DB_PATH, timeout=10)
            cursor = conn.cursor()
            symptoms_str = ", ".join(symptoms) if isinstance(symptoms, list) else str(symptoms)
            cursor.execute("""
            UPDATE conditions 
            SET name = ?, symptoms = ?, diet = ?, fitness = ?, specialist = ?, doctor_preference = ?, recommended_tests = ?, emergency_red_flags = ?
            WHERE id = ? OR condition_id = ?
            """, (name, symptoms_str, diet, fitness, specialist, preference, tests, redflags, cond_id, cond_id))
            conn.commit()
            conn.close()

            log_activity_to_db("DATASET_UPDATE", "Developer", "admin@carenexus.local", f"Updated Condition #{cond_id}: {name}")
            print(f"[DEVELOPER ADMIN] Condition #{cond_id} ({name}) updated successfully.", flush=True)
            self.send_json_response(200, {"success": True, "message": f"Condition '{name}' updated successfully!"})
            return

        # API: Delete condition from database
        elif parsed.path.startswith('/api/admin/delete_condition'):
            query_params = urllib.parse.parse_qs(parsed.query)
            cond_id = query_params.get('id', [None])[0]
            if cond_id:
                conn = sqlite3.connect(DB_PATH, timeout=10)
                cursor = conn.cursor()
                cursor.execute("DELETE FROM conditions WHERE id = ? OR condition_id = ?", (cond_id, cond_id))
                conn.commit()
                conn.close()
                log_activity_to_db("DATASET_UPDATE", "Developer", "admin@carenexus.local", f"Deleted Condition #{cond_id}")
                print(f"[DEVELOPER ADMIN] Condition #{cond_id} deleted.", flush=True)
                self.send_json_response(200, {"success": True, "message": f"Condition #{cond_id} deleted"})
                return

        self.send_error(404, "Endpoint Not Found")

    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, DELETE')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type, Origin, Accept, Authorization')
        self.send_header('Content-Length', '0')
        self.send_header('Connection', 'close')
        self.end_headers()

    def send_html_response(self, html_bytes):
        self.send_response(200)
        self.send_header('Content-Type', 'text/html; charset=utf-8')
        self.send_header('Content-Length', str(len(html_bytes)))
        self.send_header('Connection', 'close')
        self.end_headers()
        self.wfile.write(html_bytes)
        self.wfile.flush()

    def send_json_response(self, status_code, data):
        response_bytes = json.dumps(data).encode('utf-8')
        self.send_response(status_code)
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.send_header('Content-Length', str(len(response_bytes)))
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.send_header('Connection', 'close')
        self.end_headers()
        self.wfile.write(response_bytes)
        self.wfile.flush()

    def get_user_count(self):
        try:
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            cursor.execute("SELECT COUNT(*) FROM users")
            count = cursor.fetchone()[0]
            conn.close()
            return count
        except Exception:
            return 0

    def log_message(self, format, *args):
        pass

def run_server():
    server_address = ('', PORT)
    httpd = ThreadingHTTPServer(server_address, CareNexusServerHandler)
    
    url = f"http://localhost:{PORT}"
    admin_url = f"http://localhost:{PORT}/admin"
    print("=" * 65, flush=True)
    print("  CARENEXUS | CLINICAL INTELLIGENCE & APPOINTMENT ENGINE & EMAIL ALERTS (RUNNING)", flush=True)
    print("=" * 65, flush=True)
    print(f"  * Main Web Portal:        {url}", flush=True)
    print(f"  * Developer Admin Center: {admin_url}", flush=True)
    print(f"  * Mobile Wi-Fi Access:    http://192.168.0.169:{PORT}", flush=True)
    print(f"  * SQLite Backend DB:      {DB_PATH}", flush=True)
    print(f"  * Developer Recipient:    devicharan.cse@gmail.com", flush=True)
    print(f"  * Windows Desktop Popups: ENABLED", flush=True)
    print("=" * 65, flush=True)
    print("  Press Ctrl+C in this window to stop the server.\n", flush=True)
    
    try:
        threading.Thread(target=lambda: webbrowser.open(url), daemon=True).start()
    except Exception:
        pass
        
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n[CareNexus] Server stopped cleanly.", flush=True)

if __name__ == '__main__':
    run_server()
