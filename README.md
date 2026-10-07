# 🏥 CareNexus | AI-Driven Clinical Intelligence & Doctor Appointment Platform

**CareNexus** is an integrated full-stack healthcare web engineering platform developed with high-performance Python, an ACID-compliant SQLite relational database, responsive Tailwind CSS architecture, and asynchronous event notification engines.

---

## 🌟 Core System Modules

### 1. 📅 Doctor Consultation & Telehealth Booking System
- **Specialist Directory**: 14+ verified clinical department heads with qualifications, hospital affiliations, ratings, and consultation fees.
- **Interactive 3-Step Booking**: Visual date picker, dynamic time slot allocation, in-person clinic or video consultation mode selection.
- **Automated Scheduling**: Generates unique booking identifiers (`CN-2026-XXXX`), sends instant email alerts, and logs to administrative streams.
- **Patient Booking History**: Real-time appointment status tracking (`CONFIRMED`, `COMPLETED`, `CANCELLED`).

### 2. 📚 Clinical Encyclopedia & Symptoms Matrix (182 Conditions)
- Comprehensive condition profiles covering characteristic symptoms, diets, fitness guidelines, specialist consultation preferences, diagnostic tests, and emergency red-flag warnings.
- **Dual-Select Cross-Link Explorer**: Simultaneously inspect and cross-compare any medicine and condition for treatment compatibility.
- **Voice Command Search**: Browser-native Speech-to-Text with automated punctuation filtering.

### 3. 💊 Pharmacotherapy & Drug Formulary (152 Medicines)
- Active chemical ingredients, drug categories, dosage forms, example strengths, safety precautions, and side effects.

### 4. ✨ Multi-Symptom Analyzer & Ranking Engine
- Dynamic overlap scoring algorithm to compute diagnosis probability percentages based on active symptom tag baskets.

### 5. 🛡️ Developer Admin Center (`/admin`)
- Live patient appointment queue with 1-click status toggles (`[Complete]`, `[Cancel]`).
- Medical dataset manager: Add, edit, and delete conditions and medicines directly from the UI.
- Real-time audit logs, master notification switch, and Gmail SMTP integration.

---

## 🚀 Quick Start Guide

### Running the Application
1. Open a terminal in this project directory:
   ```bash
   py app.py
   # or
   python app.py
   ```
2. Open your browser:
   - **Patient Web Portal**: [http://localhost:8000](http://localhost:8000)
   - **Developer Admin Center**: [http://localhost:8000/admin](http://localhost:8000/admin)
   - **Mobile Wi-Fi Link**: `http://192.168.0.169:8000`

---

## 📂 Project Directory Structure

```
health_portal/
├── index.html              # CareNexus main client portal (Encyclopedia, Booking, Checker, Voice)
├── admin.html              # Developer Admin Center & appointments scheduling queue
├── app.py                  # Multi-threaded Python server, REST APIs & email engine
├── health_medicine.db      # SQLite database (Doctors, appointments, users, conditions, medicines)
├── database_schema.sql     # Full SQL schema & seed data dump
└── README.md               # B.Tech Engineering project documentation
```
