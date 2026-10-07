BEGIN TRANSACTION;
CREATE TABLE activity_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_type TEXT NOT NULL,
    user_name TEXT NOT NULL,
    user_email TEXT NOT NULL,
    details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE admin_settings (
    key TEXT PRIMARY KEY,
    value TEXT
);
INSERT INTO "admin_settings" VALUES('developer_email','devicharan.cse@gmail.com');
INSERT INTO "admin_settings" VALUES('alert_on_signup','1');
INSERT INTO "admin_settings" VALUES('alert_on_login','1');
INSERT INTO "admin_settings" VALUES('smtp_host','smtp.gmail.com');
INSERT INTO "admin_settings" VALUES('smtp_port','587');
INSERT INTO "admin_settings" VALUES('smtp_user','devicharan.cse@gmail.com');
INSERT INTO "admin_settings" VALUES('smtp_pass','charan1234devim');
INSERT INTO "admin_settings" VALUES('email_alerts_enabled','1');
CREATE TABLE appointments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id TEXT UNIQUE,
    user_id INTEGER,
    patient_name TEXT NOT NULL,
    patient_phone TEXT NOT NULL,
    patient_email TEXT NOT NULL,
    doctor_id INTEGER,
    doctor_name TEXT NOT NULL,
    specialty TEXT NOT NULL,
    hospital_clinic TEXT,
    appointment_date TEXT NOT NULL,
    time_slot TEXT NOT NULL,
    consultation_type TEXT DEFAULT 'In-Person',
    status TEXT DEFAULT 'CONFIRMED',
    symptoms_summary TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(doctor_id) REFERENCES doctors(id)
);
CREATE TABLE condition_medicines (
    condition_id INTEGER NOT NULL,
    medicine_id INTEGER NOT NULL,
    PRIMARY KEY (condition_id, medicine_id),
    FOREIGN KEY (condition_id) REFERENCES conditions(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE
);
INSERT INTO "condition_medicines" VALUES(1,99);
INSERT INTO "condition_medicines" VALUES(1,26);
INSERT INTO "condition_medicines" VALUES(2,99);
INSERT INTO "condition_medicines" VALUES(2,64);
INSERT INTO "condition_medicines" VALUES(3,26);
INSERT INTO "condition_medicines" VALUES(3,78);
INSERT INTO "condition_medicines" VALUES(4,99);
INSERT INTO "condition_medicines" VALUES(4,64);
INSERT INTO "condition_medicines" VALUES(5,99);
INSERT INTO "condition_medicines" VALUES(6,99);
INSERT INTO "condition_medicines" VALUES(7,37);
INSERT INTO "condition_medicines" VALUES(7,58);
INSERT INTO "condition_medicines" VALUES(8,94);
INSERT INTO "condition_medicines" VALUES(9,94);
INSERT INTO "condition_medicines" VALUES(9,48);
INSERT INTO "condition_medicines" VALUES(10,71);
INSERT INTO "condition_medicines" VALUES(11,96);
INSERT INTO "condition_medicines" VALUES(11,77);
INSERT INTO "condition_medicines" VALUES(12,95);
INSERT INTO "condition_medicines" VALUES(13,96);
INSERT INTO "condition_medicines" VALUES(13,95);
INSERT INTO "condition_medicines" VALUES(14,42);
INSERT INTO "condition_medicines" VALUES(15,94);
INSERT INTO "condition_medicines" VALUES(16,94);
INSERT INTO "condition_medicines" VALUES(18,116);
INSERT INTO "condition_medicines" VALUES(19,71);
INSERT INTO "condition_medicines" VALUES(19,61);
INSERT INTO "condition_medicines" VALUES(20,17);
INSERT INTO "condition_medicines" VALUES(21,61);
INSERT INTO "condition_medicines" VALUES(21,26);
INSERT INTO "condition_medicines" VALUES(22,61);
INSERT INTO "condition_medicines" VALUES(23,32);
INSERT INTO "condition_medicines" VALUES(24,32);
INSERT INTO "condition_medicines" VALUES(24,123);
INSERT INTO "condition_medicines" VALUES(25,100);
INSERT INTO "condition_medicines" VALUES(26,100);
INSERT INTO "condition_medicines" VALUES(28,11);
INSERT INTO "condition_medicines" VALUES(29,126);
INSERT INTO "condition_medicines" VALUES(29,72);
INSERT INTO "condition_medicines" VALUES(30,111);
INSERT INTO "condition_medicines" VALUES(30,19);
INSERT INTO "condition_medicines" VALUES(31,58);
INSERT INTO "condition_medicines" VALUES(35,99);
INSERT INTO "condition_medicines" VALUES(36,99);
INSERT INTO "condition_medicines" VALUES(37,91);
INSERT INTO "condition_medicines" VALUES(39,83);
INSERT INTO "condition_medicines" VALUES(39,46);
INSERT INTO "condition_medicines" VALUES(40,7);
INSERT INTO "condition_medicines" VALUES(40,79);
INSERT INTO "condition_medicines" VALUES(41,13);
INSERT INTO "condition_medicines" VALUES(41,109);
INSERT INTO "condition_medicines" VALUES(42,55);
INSERT INTO "condition_medicines" VALUES(42,49);
INSERT INTO "condition_medicines" VALUES(43,12);
INSERT INTO "condition_medicines" VALUES(43,13);
INSERT INTO "condition_medicines" VALUES(44,9);
INSERT INTO "condition_medicines" VALUES(44,87);
INSERT INTO "condition_medicines" VALUES(45,49);
INSERT INTO "condition_medicines" VALUES(46,49);
INSERT INTO "condition_medicines" VALUES(47,129);
INSERT INTO "condition_medicines" VALUES(48,130);
INSERT INTO "condition_medicines" VALUES(49,75);
INSERT INTO "condition_medicines" VALUES(50,84);
INSERT INTO "condition_medicines" VALUES(51,33);
INSERT INTO "condition_medicines" VALUES(51,5);
INSERT INTO "condition_medicines" VALUES(52,99);
INSERT INTO "condition_medicines" VALUES(52,38);
INSERT INTO "condition_medicines" VALUES(53,90);
INSERT INTO "condition_medicines" VALUES(54,99);
INSERT INTO "condition_medicines" VALUES(54,64);
INSERT INTO "condition_medicines" VALUES(55,99);
INSERT INTO "condition_medicines" VALUES(55,64);
INSERT INTO "condition_medicines" VALUES(56,99);
INSERT INTO "condition_medicines" VALUES(56,64);
INSERT INTO "condition_medicines" VALUES(57,99);
INSERT INTO "condition_medicines" VALUES(57,64);
INSERT INTO "condition_medicines" VALUES(58,20);
INSERT INTO "condition_medicines" VALUES(58,130);
INSERT INTO "condition_medicines" VALUES(59,113);
INSERT INTO "condition_medicines" VALUES(59,53);
INSERT INTO "condition_medicines" VALUES(60,113);
INSERT INTO "condition_medicines" VALUES(60,47);
INSERT INTO "condition_medicines" VALUES(61,80);
INSERT INTO "condition_medicines" VALUES(62,73);
INSERT INTO "condition_medicines" VALUES(62,22);
INSERT INTO "condition_medicines" VALUES(63,56);
INSERT INTO "condition_medicines" VALUES(63,104);
INSERT INTO "condition_medicines" VALUES(64,122);
INSERT INTO "condition_medicines" VALUES(64,50);
INSERT INTO "condition_medicines" VALUES(65,32);
INSERT INTO "condition_medicines" VALUES(66,32);
INSERT INTO "condition_medicines" VALUES(67,10);
INSERT INTO "condition_medicines" VALUES(68,107);
INSERT INTO "condition_medicines" VALUES(68,67);
INSERT INTO "condition_medicines" VALUES(69,3);
INSERT INTO "condition_medicines" VALUES(78,96);
INSERT INTO "condition_medicines" VALUES(79,96);
INSERT INTO "condition_medicines" VALUES(80,99);
INSERT INTO "condition_medicines" VALUES(80,64);
INSERT INTO "condition_medicines" VALUES(82,70);
INSERT INTO "condition_medicines" VALUES(83,61);
INSERT INTO "condition_medicines" VALUES(84,1);
INSERT INTO "condition_medicines" VALUES(85,1);
INSERT INTO "condition_medicines" VALUES(86,26);
INSERT INTO "condition_medicines" VALUES(86,78);
INSERT INTO "condition_medicines" VALUES(89,42);
INSERT INTO "condition_medicines" VALUES(93,96);
INSERT INTO "condition_medicines" VALUES(94,96);
INSERT INTO "condition_medicines" VALUES(95,96);
INSERT INTO "condition_medicines" VALUES(95,77);
INSERT INTO "condition_medicines" VALUES(96,80);
INSERT INTO "condition_medicines" VALUES(99,96);
INSERT INTO "condition_medicines" VALUES(100,99);
INSERT INTO "condition_medicines" VALUES(103,99);
INSERT INTO "condition_medicines" VALUES(104,26);
INSERT INTO "condition_medicines" VALUES(106,83);
INSERT INTO "condition_medicines" VALUES(106,13);
INSERT INTO "condition_medicines" VALUES(106,76);
INSERT INTO "condition_medicines" VALUES(106,46);
INSERT INTO "condition_medicines" VALUES(107,49);
INSERT INTO "condition_medicines" VALUES(107,83);
INSERT INTO "condition_medicines" VALUES(108,83);
INSERT INTO "condition_medicines" VALUES(108,49);
INSERT INTO "condition_medicines" VALUES(108,50);
INSERT INTO "condition_medicines" VALUES(109,62);
INSERT INTO "condition_medicines" VALUES(109,102);
INSERT INTO "condition_medicines" VALUES(109,85);
INSERT INTO "condition_medicines" VALUES(109,64);
INSERT INTO "condition_medicines" VALUES(110,45);
INSERT INTO "condition_medicines" VALUES(110,104);
INSERT INTO "condition_medicines" VALUES(110,56);
INSERT INTO "condition_medicines" VALUES(110,99);
INSERT INTO "condition_medicines" VALUES(111,45);
INSERT INTO "condition_medicines" VALUES(111,56);
INSERT INTO "condition_medicines" VALUES(112,7);
INSERT INTO "condition_medicines" VALUES(112,79);
INSERT INTO "condition_medicines" VALUES(113,64);
INSERT INTO "condition_medicines" VALUES(113,90);
INSERT INTO "condition_medicines" VALUES(113,56);
INSERT INTO "condition_medicines" VALUES(114,56);
INSERT INTO "condition_medicines" VALUES(114,104);
INSERT INTO "condition_medicines" VALUES(115,102);
INSERT INTO "condition_medicines" VALUES(115,1);
INSERT INTO "condition_medicines" VALUES(115,11);
INSERT INTO "condition_medicines" VALUES(116,74);
INSERT INTO "condition_medicines" VALUES(116,16);
INSERT INTO "condition_medicines" VALUES(117,43);
INSERT INTO "condition_medicines" VALUES(118,16);
INSERT INTO "condition_medicines" VALUES(118,102);
INSERT INTO "condition_medicines" VALUES(118,56);
INSERT INTO "condition_medicines" VALUES(119,129);
INSERT INTO "condition_medicines" VALUES(119,49);
INSERT INTO "condition_medicines" VALUES(119,44);
INSERT INTO "condition_medicines" VALUES(120,82);
INSERT INTO "condition_medicines" VALUES(120,102);
INSERT INTO "condition_medicines" VALUES(120,15);
INSERT INTO "condition_medicines" VALUES(120,28);
INSERT INTO "condition_medicines" VALUES(121,82);
INSERT INTO "condition_medicines" VALUES(121,102);
INSERT INTO "condition_medicines" VALUES(122,9);
INSERT INTO "condition_medicines" VALUES(122,131);
INSERT INTO "condition_medicines" VALUES(123,9);
INSERT INTO "condition_medicines" VALUES(123,131);
INSERT INTO "condition_medicines" VALUES(124,87);
INSERT INTO "condition_medicines" VALUES(124,49);
INSERT INTO "condition_medicines" VALUES(125,56);
INSERT INTO "condition_medicines" VALUES(125,104);
INSERT INTO "condition_medicines" VALUES(125,16);
INSERT INTO "condition_medicines" VALUES(126,106);
INSERT INTO "condition_medicines" VALUES(126,30);
INSERT INTO "condition_medicines" VALUES(127,47);
INSERT INTO "condition_medicines" VALUES(127,45);
INSERT INTO "condition_medicines" VALUES(128,47);
INSERT INTO "condition_medicines" VALUES(128,45);
INSERT INTO "condition_medicines" VALUES(128,30);
INSERT INTO "condition_medicines" VALUES(129,44);
INSERT INTO "condition_medicines" VALUES(129,8);
INSERT INTO "condition_medicines" VALUES(129,15);
INSERT INTO "condition_medicines" VALUES(130,99);
INSERT INTO "condition_medicines" VALUES(131,15);
INSERT INTO "condition_medicines" VALUES(131,28);
INSERT INTO "condition_medicines" VALUES(131,99);
INSERT INTO "condition_medicines" VALUES(132,1);
INSERT INTO "condition_medicines" VALUES(132,56);
INSERT INTO "condition_medicines" VALUES(132,104);
INSERT INTO "condition_medicines" VALUES(132,99);
INSERT INTO "condition_medicines" VALUES(133,2);
INSERT INTO "condition_medicines" VALUES(133,65);
INSERT INTO "condition_medicines" VALUES(133,90);
INSERT INTO "condition_medicines" VALUES(133,85);
INSERT INTO "condition_medicines" VALUES(134,11);
INSERT INTO "condition_medicines" VALUES(134,62);
INSERT INTO "condition_medicines" VALUES(134,103);
INSERT INTO "condition_medicines" VALUES(135,99);
INSERT INTO "condition_medicines" VALUES(135,56);
INSERT INTO "condition_medicines" VALUES(136,18);
INSERT INTO "condition_medicines" VALUES(136,60);
INSERT INTO "condition_medicines" VALUES(136,42);
INSERT INTO "condition_medicines" VALUES(137,98);
INSERT INTO "condition_medicines" VALUES(137,99);
INSERT INTO "condition_medicines" VALUES(138,55);
INSERT INTO "condition_medicines" VALUES(138,49);
INSERT INTO "condition_medicines" VALUES(138,128);
INSERT INTO "condition_medicines" VALUES(139,98);
INSERT INTO "condition_medicines" VALUES(139,94);
INSERT INTO "condition_medicines" VALUES(139,48);
INSERT INTO "condition_medicines" VALUES(140,76);
INSERT INTO "condition_medicines" VALUES(140,79);
INSERT INTO "condition_medicines" VALUES(140,7);
INSERT INTO "condition_medicines" VALUES(141,24);
INSERT INTO "condition_medicines" VALUES(141,36);
INSERT INTO "condition_medicines" VALUES(141,99);
INSERT INTO "condition_medicines" VALUES(142,86);
INSERT INTO "condition_medicines" VALUES(143,90);
INSERT INTO "condition_medicines" VALUES(143,64);
INSERT INTO "condition_medicines" VALUES(143,99);
INSERT INTO "condition_medicines" VALUES(144,115);
INSERT INTO "condition_medicines" VALUES(145,72);
INSERT INTO "condition_medicines" VALUES(146,11);
INSERT INTO "condition_medicines" VALUES(147,44);
INSERT INTO "condition_medicines" VALUES(147,88);
INSERT INTO "condition_medicines" VALUES(148,8);
INSERT INTO "condition_medicines" VALUES(148,28);
INSERT INTO "condition_medicines" VALUES(148,15);
INSERT INTO "condition_medicines" VALUES(148,99);
INSERT INTO "condition_medicines" VALUES(149,99);
INSERT INTO "condition_medicines" VALUES(150,125);
INSERT INTO "condition_medicines" VALUES(150,81);
INSERT INTO "condition_medicines" VALUES(151,47);
INSERT INTO "condition_medicines" VALUES(151,45);
INSERT INTO "condition_medicines" VALUES(151,30);
INSERT INTO "condition_medicines" VALUES(152,99);
INSERT INTO "condition_medicines" VALUES(152,43);
INSERT INTO "condition_medicines" VALUES(152,81);
INSERT INTO "condition_medicines" VALUES(153,12);
INSERT INTO "condition_medicines" VALUES(153,31);
INSERT INTO "condition_medicines" VALUES(153,13);
INSERT INTO "condition_medicines" VALUES(153,43);
INSERT INTO "condition_medicines" VALUES(153,81);
INSERT INTO "condition_medicines" VALUES(154,43);
INSERT INTO "condition_medicines" VALUES(154,81);
INSERT INTO "condition_medicines" VALUES(154,74);
INSERT INTO "condition_medicines" VALUES(155,59);
INSERT INTO "condition_medicines" VALUES(155,106);
INSERT INTO "condition_medicines" VALUES(155,99);
INSERT INTO "condition_medicines" VALUES(156,105);
INSERT INTO "condition_medicines" VALUES(156,103);
INSERT INTO "condition_medicines" VALUES(156,14);
INSERT INTO "condition_medicines" VALUES(157,59);
INSERT INTO "condition_medicines" VALUES(157,30);
INSERT INTO "condition_medicines" VALUES(157,86);
INSERT INTO "condition_medicines" VALUES(158,61);
INSERT INTO "condition_medicines" VALUES(158,52);
INSERT INTO "condition_medicines" VALUES(159,84);
INSERT INTO "condition_medicines" VALUES(159,87);
INSERT INTO "condition_medicines" VALUES(159,102);
INSERT INTO "condition_medicines" VALUES(159,11);
INSERT INTO "condition_medicines" VALUES(160,101);
INSERT INTO "condition_medicines" VALUES(160,103);
INSERT INTO "condition_medicines" VALUES(160,15);
INSERT INTO "condition_medicines" VALUES(161,27);
INSERT INTO "condition_medicines" VALUES(161,13);
INSERT INTO "condition_medicines" VALUES(161,12);
INSERT INTO "condition_medicines" VALUES(161,31);
INSERT INTO "condition_medicines" VALUES(162,63);
INSERT INTO "condition_medicines" VALUES(162,99);
INSERT INTO "condition_medicines" VALUES(162,64);
INSERT INTO "condition_medicines" VALUES(162,8);
INSERT INTO "condition_medicines" VALUES(163,98);
INSERT INTO "condition_medicines" VALUES(163,94);
INSERT INTO "condition_medicines" VALUES(163,93);
INSERT INTO "condition_medicines" VALUES(164,103);
INSERT INTO "condition_medicines" VALUES(164,11);
INSERT INTO "condition_medicines" VALUES(164,99);
INSERT INTO "condition_medicines" VALUES(165,99);
INSERT INTO "condition_medicines" VALUES(165,64);
INSERT INTO "condition_medicines" VALUES(166,12);
INSERT INTO "condition_medicines" VALUES(166,31);
INSERT INTO "condition_medicines" VALUES(166,13);
INSERT INTO "condition_medicines" VALUES(166,87);
INSERT INTO "condition_medicines" VALUES(166,92);
INSERT INTO "condition_medicines" VALUES(166,68);
INSERT INTO "condition_medicines" VALUES(167,87);
INSERT INTO "condition_medicines" VALUES(167,23);
INSERT INTO "condition_medicines" VALUES(167,41);
INSERT INTO "condition_medicines" VALUES(168,110);
INSERT INTO "condition_medicines" VALUES(168,46);
INSERT INTO "condition_medicines" VALUES(168,23);
INSERT INTO "condition_medicines" VALUES(168,49);
INSERT INTO "condition_medicines" VALUES(168,55);
INSERT INTO "condition_medicines" VALUES(169,33);
INSERT INTO "condition_medicines" VALUES(169,64);
INSERT INTO "condition_medicines" VALUES(169,90);
INSERT INTO "condition_medicines" VALUES(169,103);
INSERT INTO "condition_medicines" VALUES(170,24);
INSERT INTO "condition_medicines" VALUES(170,8);
INSERT INTO "condition_medicines" VALUES(170,99);
INSERT INTO "condition_medicines" VALUES(171,87);
INSERT INTO "condition_medicines" VALUES(171,76);
INSERT INTO "condition_medicines" VALUES(171,79);
INSERT INTO "condition_medicines" VALUES(172,103);
INSERT INTO "condition_medicines" VALUES(172,55);
INSERT INTO "condition_medicines" VALUES(172,49);
INSERT INTO "condition_medicines" VALUES(172,76);
INSERT INTO "condition_medicines" VALUES(172,13);
INSERT INTO "condition_medicines" VALUES(172,121);
INSERT INTO "condition_medicines" VALUES(173,55);
INSERT INTO "condition_medicines" VALUES(173,117);
INSERT INTO "condition_medicines" VALUES(173,76);
INSERT INTO "condition_medicines" VALUES(173,103);
INSERT INTO "condition_medicines" VALUES(174,46);
INSERT INTO "condition_medicines" VALUES(174,79);
INSERT INTO "condition_medicines" VALUES(174,76);
INSERT INTO "condition_medicines" VALUES(174,112);
INSERT INTO "condition_medicines" VALUES(174,13);
INSERT INTO "condition_medicines" VALUES(175,117);
INSERT INTO "condition_medicines" VALUES(175,55);
INSERT INTO "condition_medicines" VALUES(175,52);
INSERT INTO "condition_medicines" VALUES(176,4);
INSERT INTO "condition_medicines" VALUES(176,21);
INSERT INTO "condition_medicines" VALUES(176,99);
INSERT INTO "condition_medicines" VALUES(176,25);
INSERT INTO "condition_medicines" VALUES(177,24);
INSERT INTO "condition_medicines" VALUES(177,28);
INSERT INTO "condition_medicines" VALUES(177,44);
INSERT INTO "condition_medicines" VALUES(177,99);
INSERT INTO "condition_medicines" VALUES(178,4);
INSERT INTO "condition_medicines" VALUES(178,25);
INSERT INTO "condition_medicines" VALUES(178,99);
INSERT INTO "condition_medicines" VALUES(179,21);
INSERT INTO "condition_medicines" VALUES(179,99);
INSERT INTO "condition_medicines" VALUES(180,103);
INSERT INTO "condition_medicines" VALUES(180,85);
INSERT INTO "condition_medicines" VALUES(180,99);
INSERT INTO "condition_medicines" VALUES(180,21);
INSERT INTO "condition_medicines" VALUES(181,25);
INSERT INTO "condition_medicines" VALUES(181,56);
INSERT INTO "condition_medicines" VALUES(181,104);
INSERT INTO "condition_medicines" VALUES(181,99);
INSERT INTO "condition_medicines" VALUES(182,24);
INSERT INTO "condition_medicines" VALUES(182,99);
INSERT INTO "condition_medicines" VALUES(182,64);
CREATE TABLE conditions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    symptoms TEXT,
    specialist TEXT,
    diet TEXT,
    fitness TEXT,
    recommended_tests TEXT,
    emergency_red_flags TEXT
);
INSERT INTO "conditions" VALUES(1,'Common Cold','["runny nose", "sneezing", "sore throat", "cough"]','General Physician','Fluids; balanced meals; fruits and vegetables','Rest; gentle activity if comfortable','CBC test if fever lasts > 3 days','High fever > 103°F, severe shortness of breath');
INSERT INTO "conditions" VALUES(2,'Migraine','["headache", "nausea", "light sensitivity"]','Neurologist','Regular meals; hydration; identify triggers','Gentle activity when well; rest during attacks','MRI / CT brain (if atypical)','Sudden explosive headache, weakness on one side');
INSERT INTO "conditions" VALUES(3,'Allergic Rhinitis','["sneezing", "itchy nose", "runny nose", "congestion"]','General Physician','Balanced diet; hydration; identify triggers','Regular moderate activity','Routine blood work and physical exam','Severe persistent pain or unexplained worsening symptoms');
INSERT INTO "conditions" VALUES(4,'Tension Headache','["pressure-like headache", "neck tension"]','General Physician / Neurologist','Regular meals; hydration','Walking; stretching; posture breaks','Physical & neurological exam','Sudden severe onset, accompanied by fever or stiff neck');
INSERT INTO "conditions" VALUES(5,'Sore Throat','["throat pain", "irritation", "painful swallowing"]','General Physician / ENT','Fluids; soft foods','Rest; light activity if comfortable','Throat swab culture','Difficulty swallowing saliva, breathing difficulty');
INSERT INTO "conditions" VALUES(6,'Fever','["raised temperature", "chills", "sweating", "tiredness"]','General Physician','Fluids; balanced easy-to-eat foods','Rest; avoid strenuous exercise while feverish','CBC, Dengue/Malaria/Typhoid tests','Fever > 103°F, stiff neck, confusion, petechial rash');
INSERT INTO "conditions" VALUES(7,'Cough','["coughing", "throat irritation", "mucus"]','General Physician / Pulmonologist','Fluids; balanced meals','Rest; gentle activity if comfortable','Chest X-ray (if cough > 3 weeks)','Coughing blood, unexplained weight loss');
INSERT INTO "conditions" VALUES(8,'Indigestion','["upper abdominal discomfort", "fullness", "burning"]','Gastroenterologist','Smaller balanced meals; avoid personal triggers','Light walking; avoid vigorous exercise after meals','Upper endoscopy (if persistent)','Difficulty swallowing, unexplained weight loss');
INSERT INTO "conditions" VALUES(9,'Acid Reflux','["heartburn", "sour taste", "regurgitation"]','Gastroenterologist','Smaller meals; avoid triggers; do not lie down after meals','Walking; avoid vigorous activity after meals','Endoscopy, esophageal pH study','Food getting stuck, vomiting blood');
INSERT INTO "conditions" VALUES(10,'Constipation','["infrequent stools", "hard stools", "straining"]','Gastroenterologist','Fiber-rich foods; fruits; vegetables; fluids','Regular walking and activity','Abdominal X-ray, Colonoscopy (if red flags)','Severe abdominal distension, rectal bleeding');
INSERT INTO "conditions" VALUES(11,'Diarrhea','["loose stools", "cramps", "urgency"]','General Physician','Fluids; oral rehydration solution; light foods','Rest; avoid strenuous activity until hydrated','Stool culture, electrolyte panel','Signs of severe dehydration, blood in stool, high fever');
INSERT INTO "conditions" VALUES(12,'Nausea','["feeling sick", "reduced appetite"]','General Physician','Small meals; fluids; bland foods if tolerated','Rest; gentle activity','Basic metabolic panel','Inability to keep liquids down > 24 hours');
INSERT INTO "conditions" VALUES(13,'Vomiting','["vomiting", "nausea", "dehydration risk"]','General Physician','Small frequent sips; oral rehydration','Rest; avoid strenuous activity until hydrated','Serum electrolytes','Vomiting blood, extreme lethargy, severe abdominal pain');
INSERT INTO "conditions" VALUES(14,'Motion Sickness','["nausea", "dizziness", "sweating"]','General Physician','Light meal; fluids','Fresh air; gentle movement','Clinical history review','Persistent vomiting with dehydration');
INSERT INTO "conditions" VALUES(15,'Gastritis','["upper abdominal burning", "nausea", "fullness"]','Gastroenterologist','Smaller balanced meals; avoid known irritants','Light activity','H. Pylori test, Endoscopy','Black tarry stools, vomiting blood');
INSERT INTO "conditions" VALUES(16,'Peptic Ulcer Disease','["upper abdominal pain", "burning", "nausea"]','Gastroenterologist','Balanced meals; avoid NSAID self-medication','Gentle activity','Endoscopy, H. Pylori breath test','Sudden severe knife-like stomach pain');
INSERT INTO "conditions" VALUES(17,'Irritable Bowel Syndrome','["abdominal pain", "bloating", "diarrhea", "constipation"]','Gastroenterologist','Regular meals; individualized fiber and trigger management','Regular moderate activity','Stool tests, Celiac panel','Unexplained weight loss, blood in stool');
INSERT INTO "conditions" VALUES(18,'Gas/Bloating','["abdominal fullness", "belching", "gas"]','Gastroenterologist','Eat slowly; identify trigger foods','Walking and regular activity','Abdominal ultrasound','Severe unrelenting pain, persistent vomiting');
INSERT INTO "conditions" VALUES(19,'Hemorrhoids','["rectal discomfort", "itching", "swelling"]','Proctologist / General Surgeon','High-fiber foods; fluids','Walking; avoid straining','Anoscopy, Proctoscopy','Large volume rectal bleeding, severe rectal pain');
INSERT INTO "conditions" VALUES(20,'Acne','["pimples", "blackheads", "whiteheads"]','Dermatologist','Balanced diet; avoid unnecessary restrictive diets','Regular activity; clean skin after sweating','Skin examination','Severe cystic acne with scarring');
INSERT INTO "conditions" VALUES(21,'Eczema','["itchy", "dry", "inflamed skin"]','Dermatologist','Fluids; balanced meals; fruits and vegetables','Regular activity; moisturize','Allergy patch test','Skin weeping, yellow crusting (infection)');
INSERT INTO "conditions" VALUES(22,'Contact Dermatitis','["redness", "itching", "irritation"]','Dermatologist','Regular meals; hydration; identify triggers','Avoid aggravating exposure','Patch testing','Rash spreading near eyes, blistering with infection');
INSERT INTO "conditions" VALUES(23,'Fungal Skin Infection','["itchy", "scaly", "ring-shaped rash"]','Dermatologist','Balanced diet; hydration; identify triggers','Keep affected area clean and dry','Skin scraping KOH test','Spreading rapidly or not responding to topicals');
INSERT INTO "conditions" VALUES(24,'Athlete''s Foot','["itching", "peeling", "cracked skin between toes"]','Dermatologist / Podiatrist','Regular meals; hydration','Keep feet dry; change socks','Fungal culture','Red streaks, swelling, diabetic patient');
INSERT INTO "conditions" VALUES(25,'Scabies','["intense itching", "rash", "worse at night"]','Dermatologist','Fluids; soft foods','Avoid close skin contact until treated','Skin scraping','Secondary bacterial skin infection, open sores');
INSERT INTO "conditions" VALUES(26,'Head Lice','["scalp itching", "lice", "nits"]','Dermatologist / Pediatrician','Fluids; balanced easy-to-eat foods','Avoid sharing combs and hats','Visual scalp exam','Scalp infection from scratching');
INSERT INTO "conditions" VALUES(27,'Conjunctivitis','["red eye", "discharge", "watering"]','Ophthalmologist','Fluids; balanced meals','Avoid swimming if infectious','Slit lamp eye exam','Severe eye pain, vision reduction, sensitivity to light');
INSERT INTO "conditions" VALUES(28,'Dry Eye','["burning", "gritty feeling", "eye fatigue"]','Ophthalmologist','Smaller balanced meals; avoid personal triggers','Screen breaks; blinking','Schirmer''s tear test','Corneal abrasions, severe eye redness and pain');
INSERT INTO "conditions" VALUES(29,'Glaucoma','["often no early symptoms", "vision loss later"]','Ophthalmologist','Smaller meals; avoid triggers; do not lie down after meals','Regular moderate activity; eye-care plan','Tonometry, Visual field test','Sudden severe eye pain with rainbow halos');
INSERT INTO "conditions" VALUES(30,'Asthma','["wheezing", "cough", "chest tightness", "breathlessness"]','Pulmonologist','Fiber-rich foods; fruits; vegetables; fluids','Clinician-approved activity; warm up','Spirometry, Chest X-ray','Blue lips, inhaler ineffective, severe wheezing');
INSERT INTO "conditions" VALUES(31,'Bronchitis','["cough", "mucus", "chest discomfort", "fatigue"]','Pulmonologist','Fluids; oral rehydration solution; light foods','Rest; gradual return to activity','Chest X-ray, Sputum test','Coughing up blood, high persistent fever');
INSERT INTO "conditions" VALUES(32,'COPD','["persistent cough", "mucus", "breathlessness"]','Pulmonologist','Small meals; fluids; bland foods if tolerated','Clinician-guided exercise and breathing work','Spirometry, arterial blood gas','Severe breathlessness, confusion, cyanosis');
INSERT INTO "conditions" VALUES(33,'Sinusitis','["facial pressure", "congestion", "nasal discharge"]','ENT Specialist','Small frequent sips; oral rehydration','Gentle activity as tolerated','Nasal endoscopy, sinus CT','Severe facial swelling, vision changes');
INSERT INTO "conditions" VALUES(34,'Pneumonia','["cough", "fever", "breathlessness", "fatigue"]','Pulmonologist / Physician','Light meal; fluids','Rest; gradual activity under medical guidance','Chest X-ray, Sputum culture, Blood culture','Rapid breathing, chest pain when breathing, confusion');
INSERT INTO "conditions" VALUES(35,'Influenza','["fever", "cough", "body aches", "fatigue"]','General Physician','Smaller balanced meals; avoid known irritants','Rest; avoid strenuous exercise while feverish','Rapid flu test','Difficulty breathing, chest pain, persistent dizziness');
INSERT INTO "conditions" VALUES(36,'COVID-19','["fever", "cough", "sore throat", "fatigue"]','General Physician / Pulmonologist','Balanced meals; avoid NSAID self-medication','Rest; gradual return to activity','RT-PCR test, Chest CT','Oxygen level < 94%, persistent chest pressure');
INSERT INTO "conditions" VALUES(37,'Urinary Tract Infection','["burning urination", "frequency", "urgency"]','Urologist / Physician','Regular meals; individualized fiber and trigger management','Rest; gentle activity','Urinalysis, Urine Culture','Fever with back/flank pain (kidney infection)');
INSERT INTO "conditions" VALUES(38,'Kidney Stone','["flank pain", "nausea", "possible blood in urine"]','Urologist','Eat slowly; identify trigger foods','Regular aerobic and resistance activity','CT KUB, Renal Ultrasound','Unbearable flank pain, blood in urine, fever');
INSERT INTO "conditions" VALUES(39,'Type 2 Diabetes','["high glucose", "thirst", "frequent urination"]','Endocrinologist','High-fiber foods; fluids','Regular moderate aerobic and resistance exercise','HbA1c, Fasting Blood Sugar, Kidney panel','Blood glucose > 300 mg/dL, confusion, fruity breath');
INSERT INTO "conditions" VALUES(40,'High Blood Pressure','["often no symptoms", "sometimes headache or dizziness"]','Cardiologist','Balanced diet; avoid unnecessary restrictive diets','Regular aerobic and resistance activity','ECG, Lipid profile, Kidney function','BP > 180/120, chest pain, vision disturbance');
INSERT INTO "conditions" VALUES(41,'High Cholesterol','["usually no symptoms"]','Cardiologist','Fluids; balanced meals; fruits and vegetables','Clinician-supervised activity','Lipid panel, Liver function','Chest pain on exertion, breathlessness');
INSERT INTO "conditions" VALUES(42,'Heart Failure','["breathlessness", "fatigue", "leg swelling"]','Cardiologist','Regular meals; hydration; identify triggers','Clinician-approved activity/cardiac rehabilitation','Echocardiogram, BNP test, ECG','Rapid weight gain, severe leg swelling, night breathlessness');
INSERT INTO "conditions" VALUES(43,'Coronary Artery Disease','["chest discomfort", "breathlessness", "fatigue"]','Cardiologist','Balanced diet; hydration; identify triggers','Regular activity guided by clinician','Angiography, Stress test, ECG','Crushing chest pain radiating to arm/jaw');
INSERT INTO "conditions" VALUES(44,'Atrial Fibrillation','["irregular heartbeat", "palpitations", "breathlessness"]','Cardiologist','Regular meals; hydration','Gentle activity according to energy','Holter monitor, Echocardiogram','Heart palpitations with fainting or breathlessness');
INSERT INTO "conditions" VALUES(45,'Anemia','["fatigue", "weakness", "pale skin", "breathlessness"]','Hematologist / Physician','Fluids; soft foods','Gentle-to-moderate activity','Complete Blood Count (CBC), Ferritin','Extreme dizziness, fainting, rapid heart rate');
INSERT INTO "conditions" VALUES(46,'Iron Deficiency','["fatigue", "weakness", "poor concentration"]','General Physician','Fluids; balanced easy-to-eat foods','Activity as tolerated','Serum Ferritin, Iron profile','Severe exhaustion, shortness of breath on mild exertion');
INSERT INTO "conditions" VALUES(47,'Vitamin B12 Deficiency','["fatigue", "weakness", "numbness", "anemia"]','General Physician','Fluids; balanced meals','Weight-bearing and resistance exercise','Serum B12 level, Homocysteine','Tingling in hands/feet, memory issues');
INSERT INTO "conditions" VALUES(48,'Vitamin D Deficiency','["bone/muscle symptoms or none"]','General Physician','Smaller balanced meals; avoid personal triggers','Regular moderate activity','25-hydroxy Vitamin D blood test','Chronic bone/muscle aches, frequent fractures');
INSERT INTO "conditions" VALUES(49,'Hypothyroidism','["fatigue", "cold intolerance", "constipation", "dry skin"]','Endocrinologist','Smaller meals; avoid triggers; do not lie down after meals','Avoid excessive exertion until controlled','TSH, Free T4, Thyroid ultrasound','Extreme lethargy, severe cold intolerance, slow pulse');
INSERT INTO "conditions" VALUES(50,'Hyperthyroidism','["fast heartbeat", "heat intolerance", "tremor"]','Endocrinologist','Fiber-rich foods; fruits; vegetables; fluids','Gentle movement during flare','TSH, Free T3/T4, Thyroid scan','Resting heart rate > 120 bpm, high fever, agitation');
INSERT INTO "conditions" VALUES(51,'Gout','["sudden painful swollen joint"]','Rheumatologist','Fluids; oral rehydration solution; light foods','Low-impact aerobic and strength exercise','Serum Uric Acid, Joint fluid analysis','Severe unbearable joint redness and swelling');
INSERT INTO "conditions" VALUES(52,'Osteoarthritis','["joint pain", "stiffness", "reduced mobility"]','Orthopedic Specialist / Rheumatologist','Small meals; fluids; bland foods if tolerated','Low-impact aerobic and strength work','Joint X-ray, MRI','Inability to bear weight, locking joint');
INSERT INTO "conditions" VALUES(53,'Rheumatoid Arthritis','["joint pain", "swelling", "morning stiffness"]','Rheumatoid Arthritis Specialist','Small frequent sips; oral rehydration','Walking; mobility; strengthening','RF factor, Anti-CCP, ESR, CRP','Rapid joint destruction, eye inflammation');
INSERT INTO "conditions" VALUES(54,'Back Pain','["back pain", "stiffness"]','Orthopedic / Spine Specialist','Light meal; fluids','Gentle mobility; posture breaks','Spine X-ray, Lumbar MRI','Numbness in groin, loss of bowel/bladder control');
INSERT INTO "conditions" VALUES(55,'Neck Pain','["neck pain", "stiffness", "reduced movement"]','Orthopedic Specialist','Smaller balanced meals; avoid known irritants','Protect initially; gradual rehabilitation','Cervical Spine X-ray / MRI','Pain radiating down arm with weakness/numbness');
INSERT INTO "conditions" VALUES(56,'Sprain','["pain", "swelling", "reduced movement after injury"]','Orthopedic Specialist','Balanced meals; avoid NSAID self-medication','Relative rest; gradual mobility','X-ray to rule out fracture','Inability to take 4 steps, visible bone deformity');
INSERT INTO "conditions" VALUES(57,'Muscle Strain','["localized muscle pain", "stiffness"]','Physiotherapist / Orthopedic','Regular meals; individualized fiber and trigger management','Weight-bearing and resistance exercise safely','Clinical exam / Ultrasound','Large palpable gap in muscle, severe bruising');
INSERT INTO "conditions" VALUES(58,'Osteoporosis','["fragile bones", "fractures may occur"]','Endocrinologist / Orthopedic','Eat slowly; identify trigger foods','Regular gentle-to-moderate activity; support','DEXA Bone Density Scan','Sudden severe back pain from minor bump');
INSERT INTO "conditions" VALUES(59,'Depression','["persistent low mood", "loss of interest", "sleep/appetite changes"]','Psychiatrist / Psychologist','High-fiber foods; fluids','Aerobic activity; relaxation','PHQ-9 clinical assessment','Suicidal thoughts, complete inability to care for self');
INSERT INTO "conditions" VALUES(60,'Generalized Anxiety','["excessive worry", "restlessness", "tension"]','Psychiatrist / Psychologist','Balanced diet; avoid unnecessary restrictive diets','Daytime activity; consistent sleep routine','GAD-7 assessment','Chest tightness, hyperventilation, panic attacks');
INSERT INTO "conditions" VALUES(61,'Insomnia','["difficulty falling/staying asleep", "daytime tiredness"]','Sleep Specialist / Neurologist','Fluids; balanced meals; fruits and vegetables','Individualized exercise safety plan','Sleep log, Polysomnography','Falling asleep while driving, chronic memory lapses');
INSERT INTO "conditions" VALUES(62,'Epilepsy','["recurrent seizures"]','Neurologist','Regular meals; hydration; identify triggers','Gentle aerobic and strengthening activity','EEG, MRI Brain','Seizure lasting > 5 mins, consecutive seizures');
INSERT INTO "conditions" VALUES(63,'Neuropathic Pain','["burning", "tingling", "shooting pain"]','Neurologist / Pain Specialist','Balanced diet; hydration; identify triggers','Regular physical activity','EMG / Nerve conduction study','Sudden loss of sensation or muscle weakness');
INSERT INTO "conditions" VALUES(64,'Benign Prostatic Enlargement','["weak stream", "hesitancy", "frequent urination"]','Urologist','Regular meals; hydration','Activity if comfortable; avoid irritation','PSA blood test, Prostate ultrasound','Complete inability to pass urine (Emergency)');
INSERT INTO "conditions" VALUES(65,'Vaginal Candidiasis','["itching", "irritation", "abnormal discharge"]','Gynecologist','Fluids; soft foods','Normal activity','Vaginal swab examination','Persistent symptoms, recurrence > 4 times yearly');
INSERT INTO "conditions" VALUES(66,'Oral Thrush','["white patches", "mouth soreness"]','Dentist / General Physician','Fluids; balanced easy-to-eat foods','Rest; avoid strenuous activity','Oral swab / Visual exam','Difficulty swallowing, spreading down throat');
INSERT INTO "conditions" VALUES(67,'Malaria','["fever", "chills", "sweating", "headache", "body aches"]','Infectious Disease Specialist','Fluids; balanced meals','Rest; gradual activity under medical guidance','Malaria Rapid Test, Blood Smear','Extreme chills, jaundice, confusion');
INSERT INTO "conditions" VALUES(68,'Tuberculosis','["persistent cough", "fever", "night sweats"]','Pulmonologist / ID Specialist','Smaller balanced meals; avoid personal triggers','Normal activity; strict hand hygiene','Sputum AFB, GeneXpert, Chest X-ray','Coughing up blood, night sweats, severe weight loss');
INSERT INTO "conditions" VALUES(69,'Pinworm Infection','["night-time anal itching"]','Pediatrician / General Physician','Smaller meals; avoid triggers; do not lie down after meals','Moderate activity as tolerated','Tape test','Secondary bacterial skin infection');
INSERT INTO "conditions" VALUES(70,'Hepatitis B','["fatigue", "nausea", "abdominal symptoms", "possible jaundice"]','Hepatologist / Gastroenterologist','Fiber-rich foods; fruits; vegetables; fluids','Regular aerobic and resistance activity','HBsAg, Viral load, Liver function','Jaundice (yellow eyes/skin), dark urine, pale stools');
INSERT INTO "conditions" VALUES(71,'Fatty Liver Disease','["often silent", "fatigue may occur"]','Gastroenterologist / Hepatologist','Fluids; oral rehydration solution; light foods','Individualized low-to-moderate activity','FibroScan, Liver function, Lipid panel','Upper right abdominal discomfort, chronic fatigue');
INSERT INTO "conditions" VALUES(72,'Chronic Kidney Disease','["fatigue", "swelling", "often silent early"]','Nephrologist','Small meals; fluids; bland foods if tolerated','Pelvic-floor exercises; regular activity','Serum Creatinine, eGFR, Urine Protein','Severe swelling in legs/face, extreme breathlessness');
INSERT INTO "conditions" VALUES(73,'Urinary Incontinence','["urine leakage", "urgency"]','Urologist / Gynecologist','Small frequent sips; oral rehydration','Gentle-to-moderate activity if comfortable','Urodynamic study, Ultrasound','Fever, sudden total urinary retention');
INSERT INTO "conditions" VALUES(74,'Ovarian Cysts','["pelvic discomfort", "irregular periods"]','Gynecologist','Light meal; fluids','Gentle walking; stretching','Pelvic Ultrasound','Sudden sharp lower abdominal pain with vomiting');
INSERT INTO "conditions" VALUES(75,'Menstrual Cramps','["lower abdominal cramps", "back pain", "nausea"]','Gynecologist','Smaller balanced meals; avoid known irritants','Regular aerobic activity; stretching','Pelvic ultrasound (if severe)','Severe pain not relieved by medications');
INSERT INTO "conditions" VALUES(76,'Premenstrual Syndrome','["mood changes", "bloating", "breast tenderness"]','Gynecologist','Balanced meals; avoid NSAID self-medication','Avoid trigger exposure','Hormonal symptom diary','Severe depression or anxiety before period');
INSERT INTO "conditions" VALUES(77,'Allergic Skin Reaction','["itching", "redness", "raised rash"]','Dermatologist / Allergist','Regular meals; individualized fiber and trigger management','Rest; avoid strenuous exercise until rehydrated','Allergy testing','Swelling of lips/tongue, difficulty breathing');
INSERT INTO "conditions" VALUES(78,'Dehydration','["thirst", "dry mouth", "reduced urine", "dizziness"]','General Physician','Eat slowly; identify trigger foods','Stop exercise; cool down; rest','Serum electrolytes','No urination for 8 hours, extreme dizziness');
INSERT INTO "conditions" VALUES(79,'Heat Exhaustion','["heavy sweating", "weakness", "dizziness", "headache"]','Emergency Physician','High-fiber foods; fluids','Dental assessment; normal activity if comfortable','Electrolyte check','Confusion, loss of consciousness (Heat Stroke)');
INSERT INTO "conditions" VALUES(80,'Toothache','["dental pain", "sensitivity", "possible swelling"]','Dentist','Balanced diet; avoid unnecessary restrictive diets','Normal activity','Dental X-ray','Facial swelling, fever, difficulty opening mouth');
INSERT INTO "conditions" VALUES(81,'Mouth Ulcer','["painful mouth ulcer"]','Dentist / General Physician','Fluids; balanced meals; fruits and vegetables','Normal activity; scalp hygiene','Oral examination','Ulcer lasting longer than 3 weeks without healing');
INSERT INTO "conditions" VALUES(82,'Dandruff','["scalp flaking", "itching"]','Dermatologist','Regular meals; hydration; identify triggers','Regular activity; stress management','Scalp exam','Severe redness, scaling spreading to face');
INSERT INTO "conditions" VALUES(83,'Psoriasis','["thick scaly inflamed skin"]','Dermatologist','Balanced diet; hydration; identify triggers','Normal activity; avoid close contact during active lesions','Skin biopsy (rarely needed)','Joint pain accompanying skin plaques');
INSERT INTO "conditions" VALUES(84,'Cold Sore','["painful blistering around lips"]','General Physician / Dermatologist','Regular meals; hydration','Rest; avoid strenuous activity if fatigued','Clinical exam','Lesion spreading to eyes, immune compromised');
INSERT INTO "conditions" VALUES(85,'Herpes Zoster','["painful localized blistering rash"]','Dermatologist / Neurologist','Fluids; soft foods','Normal exercise; reduce allergen exposure','PCR viral swab','Rash near eye/nose, unbearable nerve pain');
INSERT INTO "conditions" VALUES(86,'Seasonal Allergies','["sneezing", "itchy eyes", "runny nose"]','General Physician','Fluids; balanced easy-to-eat foods','Gentle activity','Routine blood work and physical exam','Severe persistent pain or unexplained worsening symptoms');
INSERT INTO "conditions" VALUES(87,'Nasal Congestion','["blocked nose", "difficult nasal breathing"]','General Physician','Fluids; balanced meals','Normal activity; never insert objects into ear','Routine blood work and physical exam','Severe persistent pain or unexplained worsening symptoms');
INSERT INTO "conditions" VALUES(88,'Earwax Buildup','["blocked ear", "reduced hearing", "discomfort"]','ENT Specialist','Smaller balanced meals; avoid personal triggers','Avoid risky activity during episodes','Otoscopy exam','Sudden total hearing loss, ear drainage');
INSERT INTO "conditions" VALUES(89,'Vertigo','["spinning sensation", "imbalance", "nausea"]','ENT Specialist / Neurologist','Smaller meals; avoid triggers; do not lie down after meals','Regular activity; stress management','Dix-Hallpike test, Audiometry, MRI','Sudden hearing loss, double vision, difficulty walking');
INSERT INTO "conditions" VALUES(90,'Tinnitus','["ringing/buzzing in ears"]','ENT Specialist / Audiologist','Fiber-rich foods; fruits; vegetables; fluids','Regular activity; medical assessment','Pure tone audiometry','Pulsing heartbeat sound in ear, one-sided tinnitus');
INSERT INTO "conditions" VALUES(91,'Sleep Apnea','["loud snoring", "breathing pauses", "daytime sleepiness"]','Sleep Specialist / Pulmonologist','Fluids; oral rehydration solution; light foods','Progressive aerobic and resistance activity','Overnight Sleep Study (Polysomnography)','Waking up gasping for air, severe morning headaches');
INSERT INTO "conditions" VALUES(92,'Obesity','["excess body weight", "metabolic complications possible"]','Endocrinologist / Dietitian','Small meals; fluids; bland foods if tolerated','Rest; avoid strenuous activity until recovered','Lipid panel, HbA1c, Thyroid panel','Sleep apnea, joint pain, chest pain on exertion');
INSERT INTO "conditions" VALUES(93,'Food Poisoning','["nausea", "vomiting", "diarrhea", "cramps"]','General Physician','Small frequent sips; oral rehydration','Rest; gradual return','Stool examination','High fever, bloody diarrhea, extreme dehydration');
INSERT INTO "conditions" VALUES(94,'Gastroenteritis','["vomiting", "diarrhea", "cramps", "sometimes fever"]','General Physician','Light meal; fluids','Rest; avoid strenuous activity while dehydrated','Stool panel','Persistent inability to retain fluids, sunken eyes');
INSERT INTO "conditions" VALUES(95,'Traveler''s Diarrhea','["acute diarrhea during/after travel"]','General Physician','Smaller balanced meals; avoid known irritants','Daylight exposure; light activity','Stool culture','Fever > 102°F, severe cramps with bloody stools');
INSERT INTO "conditions" VALUES(96,'Jet Lag','["sleep disruption", "daytime fatigue"]','General Physician','Balanced meals; avoid NSAID self-medication','Gentle stretching; regular conditioning','Clinical review','Severe disorientation, prolonged insomnia');
INSERT INTO "conditions" VALUES(97,'Muscle Cramps','["sudden painful muscle tightening"]','General Physician','Regular meals; individualized fiber and trigger management','Gentle movement; gradual training','Routine blood work and physical exam','Severe persistent pain or unexplained worsening symptoms');
INSERT INTO "conditions" VALUES(98,'Exercise Soreness','["muscle tenderness after unfamiliar exercise"]','Sports Physiotherapist','Eat slowly; identify trigger foods','Stop intense exercise; cool down; rehydrate','Physical exam','Dark cola-colored urine (Rhabdomyolysis)');
INSERT INTO "conditions" VALUES(99,'Exercise Dehydration','["thirst", "fatigue", "headache", "reduced performance"]','Sports Medicine Physician','High-fiber foods; fluids','Walking; stretching; relaxation','Hydration assessment','Rapid pulse, headache, dizziness');
INSERT INTO "conditions" VALUES(100,'Stress-Related Headache','["headache with stress/muscle tension"]','General Physician','Balanced diet; avoid unnecessary restrictive diets','Normal activity; moisturize','Physical evaluation','Sudden vision blurring, neck stiffness with fever');
INSERT INTO "conditions" VALUES(101,'Dry Skin','["flaking", "tightness", "itching"]','Dermatologist','Fluids; balanced meals; fruits and vegetables','Normal activity','Skin assessment','Deep painful cracks, signs of infection');
INSERT INTO "conditions" VALUES(102,'Chapped Lips','["dry/cracked lips", "irritation"]','Dermatologist','Regular meals; hydration; identify triggers','Avoid further sun; rest if unwell','Clinical inspection','Non-healing ulcers lasting > 2 weeks');
INSERT INTO "conditions" VALUES(103,'Sunburn','["red", "painful skin after sun exposure"]','Dermatologist','Balanced diet; hydration; identify triggers','Avoid scratching; normal activity','Skin evaluation','Extensive blistering, fever, chills, dizziness');
INSERT INTO "conditions" VALUES(104,'Minor Insect Bite','["localized itching", "redness", "swelling"]','General Physician','Regular meals; hydration','Gentle activity; avoid repeated impact','Clinical exam','Rapid swelling, hives, difficulty swallowing');
INSERT INTO "conditions" VALUES(105,'Minor Bruise','["localized discoloration", "tenderness"]','General Physician','Fluids; soft foods','Screen breaks; blinking; posture adjustment','Coagulation panel (if frequent)','Bruising with no trauma, large painful swelling');
INSERT INTO "conditions" VALUES(106,'Metabolic Syndrome','["abdominal obesity", "high blood pressure", "fatigue", "elevated blood sugar", "acanthosis nigricans"]','Endocrinologist / Cardiologist','Mediterranean diet, high soluble fiber, low glycemic index foods, eliminate sugary beverages','150-300 mins moderate aerobic exercise weekly with resistance training','Fasting Lipid Profile, Fasting Glucose, HbA1c, Liver Function Panel','Chest pain, shortness of breath, severe sudden headache');
INSERT INTO "conditions" VALUES(107,'Cushing''s Syndrome','["moon face", "buffalo hump", "purple abdominal striae", "weight gain", "skin thinning", "muscle weakness"]','Endocrinologist','Low sodium, low refined carb, high calcium and potassium rich diet','Low-impact walking, gentle resistance training to combat muscle wasting','24-hour Urinary Free Cortisol, Overnight Dexamethasone Suppression Test, Pituitary MRI','Severe acute confusion, persistent vomiting, hypotension (Adrenal Crisis)');
INSERT INTO "conditions" VALUES(108,'Polycystic Ovary Syndrome (PCOS)','["irregular menstrual periods", "excess facial hair (hirsutism)", "acne", "weight gain", "thinning scalp hair", "pelvic pain"]','Gynecologist / Endocrinologist','Anti-inflammatory low GI foods, lean protein, spearmint tea, inositol supplementation','Regular strength training and daily 30-min brisk walking for insulin sensitivity','Pelvic Ultrasound, Serum LH/FSH ratio, Total/Free Testosterone, Fasting Insulin','Sudden severe pelvic pain with fever or fainting (Ovarian torsion / cyst rupture)');
INSERT INTO "conditions" VALUES(109,'Systemic Lupus Erythematosus (SLE)','["butterfly facial rash", "joint pain", "fatigue", "fever", "photosensitivity", "mouth ulcers", "chest pain on breathing"]','Rheumatologist','Balanced anti-inflammatory Mediterranean diet, Vitamin D and Calcium rich','Gentle aquatic exercises, walking, yoga; avoid exhaustion and direct sun exposure','ANA (Antinuclear Antibodies), Anti-dsDNA, Complement C3/C4, Urinalysis for protein','Shortness of breath, chest pain, high fever, dark urine with facial swelling');
INSERT INTO "conditions" VALUES(110,'Fibromyalgia','["widespread muscle pain", "chronic fatigue", "sleep disturbance", "cognitive fog (fibro fog)", "tender trigger points", "headaches"]','Rheumatologist / Pain Specialist','Whole-food plant-rich diet, magnesium-rich foods (spinach, nuts), avoid artificial additives','Graded low-impact aerobic exercise, swimming, tai chi, gentle stretching','Rule out thyroid dysfunction, Vitamin D/B12 deficiency, ESR/CRP inflammatory markers','Sudden localized severe weakness, loss of bowel/bladder control');
INSERT INTO "conditions" VALUES(111,'Chronic Fatigue Syndrome (ME/CFS)','["extreme unrefreshing fatigue", "post-exertional malaise", "brain fog", "orthostatic intolerance", "muscle aches", "swollen lymph nodes"]','Neurologist / Immunologist','Frequent small nutrient-dense meals, optimal hydration with electrolytes','Pacing within energy envelope; avoid overexertion crashes','Complete blood count, Thyroid panel, Cortisol, Epstein-Barr viral titers','Chest pain, fainting upon standing with palpitations');
INSERT INTO "conditions" VALUES(112,'Raynaud''s Phenomenon','["white and blue fingers in cold", "numbness", "painful tingling on rewarming", "cold hands and feet"]','Rheumatologist / Vascular Specialist','Warm broths, ginger, avoid caffeine, maintain core warmth','Indoor workouts, gentle arm windmills to encourage distal blood flow','Nailfold capillaroscopy, ANA titer, ESR/CRP, Rheumatoid Factor','Skin ulcers or black discoloration on fingertips (Tissue gangrene)');
INSERT INTO "conditions" VALUES(113,'Carpal Tunnel Syndrome','["wrist pain", "numbness in thumb and index finger", "tingling sensation", "weak hand grip", "night pain waking from sleep"]','Orthopedic Surgeon / Neurologist','Anti-inflammatory foods, B6 rich legumes and seeds, reduce sodium','Wrist extension/flexion nerve gliding exercises, ergonomic keyboard setup','Electromyography (EMG) and Nerve Conduction Velocity (NCV) test','Complete numbness and visible muscle wasting at base of thumb (thenar atrophy)');
INSERT INTO "conditions" VALUES(114,'Restless Legs Syndrome (RLS)','["irresistible urge to move legs", "crawling leg sensation", "worse at rest or evening", "sleep disruption", "involuntary leg jerks"]','Sleep Specialist / Neurologist','Iron-rich dark leafy greens, avoid caffeine and evening alcohol','Evening light walking, leg stretches, warm Epsom salt baths before bed','Serum Ferritin, Iron Binding Capacity (TIBC), Renal Function, Polysomnography','Progressive numbness spreading to arms or loss of coordination');
INSERT INTO "conditions" VALUES(115,'Bell''s Palsy','["one-sided facial drooping", "inability to close eye", "loss of taste on tongue", "drooling", "ear pain", "sound sensitivity"]','Neurologist / ENT Specialist','Soft easy-to-chew foods, warm soothing liquids','Gentle facial muscle physical therapy exercises in front of a mirror','Clinical neurological exam, rule out stroke (arm drift, speech slur), MRI brain if atypical','Arm or leg weakness on same side, slurred speech, confusion (Stroke signs)');
INSERT INTO "conditions" VALUES(116,'Parkinson''s Disease','["resting tremor", "muscle stiffness (rigidity)", "slow movements (bradykinesia)", "shuffling gait", "loss of balance", "soft voice"]','Neurologist (Movement Disorders)','High fiber, plenty of hydration, separate protein intake from Levodopa dose timing','Targeted balance training, gait physical therapy, boxing exercises, daily walking','Clinical neurological assessment, DaTscan (dopamine transporter imaging)','Frequent falls with head injury, sudden swallowing paralysis (aspiration risk)');
INSERT INTO "conditions" VALUES(117,'Alzheimer''s Disease & Dementia','["short-term memory loss", "confusion with time/place", "difficulty solving problems", "mood changes", "getting lost in familiar routes"]','Neurologist / Geriatrician','MIND diet (Mediterranean-DASH diet intervention for neurodegenerative delay), blueberries, walnuts','Structured daily walks, social engagement, cognitive memory games','Mini-Mental State Exam (MMSE), MoCA cognitive test, Brain MRI/PET scan','Sudden acute delirium, wandering outside alone, severe agitation');
INSERT INTO "conditions" VALUES(118,'Multiple Sclerosis (MS)','["vision blurring (optic neuritis)", "numbness or tingling", "muscle spasticity", "fatigue", "balance issues", "electric shock sensation on neck flexion"]','Neurologist (MS Specialist)','Anti-inflammatory, rich in Vitamin D3, omega-3 fatty acids, low saturated fat','Aquatic physical therapy, stationary cycling, avoid overheating (Uhthoff phenomenon)','MRI Brain & Spinal Cord with contrast, Lumbar Puncture (Oligoclonal bands)','Sudden total loss of vision, acute inability to walk, severe urinary retention');
INSERT INTO "conditions" VALUES(119,'Celiac Disease','["chronic diarrhea", "bloating", "weight loss", "anemia", "fatigue", "itchy skin blisters (dermatitis herpetiformis)", "abdominal pain"]','Gastroenterologist','Strict 100% Gluten-Free Diet (Zero wheat, rye, barley, cross-contaminated oats)','Regular moderate fitness to restore bone density and muscle mass','Tissue Transglutaminase IgA (tTG-IgA), Total Serum IgA, Upper Endoscopy with Duodenal Biopsy','Severe malnutrition, electrolyte collapse, intractable vomiting');
INSERT INTO "conditions" VALUES(120,'Crohn''s Disease','["cramping abdominal pain", "persistent diarrhea", "blood in stool", "fever", "unexplained weight loss", "perianal fistulas", "fatigue"]','Gastroenterologist','Low-residue diet during flares, high-calorie nutrient smoothies, avoid dairy and spicy triggers','Light walking and yoga during remissions; rest during active flares','Fecal Calprotectin, Colonoscopy with ileoscopy, CT/MR Enterography, CRP','High fever, rigid abdomen with severe pain (Intestinal perforation / obstruction)');
INSERT INTO "conditions" VALUES(121,'Ulcerative Colitis','["bloody diarrhea", "frequent urgency to defecate (tenesmus)", "lower abdominal cramps", "fatigue", "fever", "weight loss"]','Gastroenterologist','Bland low-fiber foods during flares, lean chicken, eggs, rice, adequate hydration','Low-stress restorative exercises, pelvic floor awareness','Flexible Sigmoidoscopy / Colonoscopy, Stool pathogen panel, Fecal Calprotectin','Massive rectal bleeding, severe abdominal distension with high fever (Toxic Megacolon)');
INSERT INTO "conditions" VALUES(122,'Deep Vein Thrombosis (DVT)','["unilateral leg swelling", "calf pain and tenderness", "warmth in leg", "red or discolored skin on leg"]','Vascular Specialist / Hematologist','High hydration, Vitamin K consistent intake (if on Warfarin)','Avoid prolonged sitting; frequent ankle pumps during long travel; graduated compression socks','Venous Duplex Ultrasound of lower extremity, D-Dimer blood test','Sudden shortness of breath, chest pain, coughing blood (Pulmonary Embolism)');
INSERT INTO "conditions" VALUES(123,'Pulmonary Embolism (PE)','["sudden shortness of breath", "sharp chest pain on breathing", "coughing up blood (hemoptysis)", "rapid heart rate", "dizziness"]','Pulmonologist / Emergency Physician','Hospital recovery diet, fluid management','Bedrest under hospital monitoring until stable, followed by pulmonary rehab','CT Pulmonary Angiogram (CTPA), Arterial Blood Gas (ABG), Troponin, BNP','EMERGENCY: Immediate hospital ER required. Blue lips, fainting, shock.');
INSERT INTO "conditions" VALUES(124,'Postural Orthostatic Tachycardia Syndrome (POTS)','["rapid heart rate on standing", "lightheadedness", "fainting (syncope)", "brain fog", "shakiness", "chest flutter", "fatigue"]','Cardiologist / Autonomic Neurologist','High salt intake (3-5g extra sodium daily), 2.5-3 liters fluids daily','Recumbent exercise (rowing, recumbent bike, swimming) transitioning to upright','Tilt Table Test, 24-hour Holter Monitor, Echocardiogram, Serum catecholamines','Prolonged loss of consciousness with head trauma, severe chest pain');
INSERT INTO "conditions" VALUES(125,'Trigeminal Neuralgia','["electric shock-like facial pain", "sharp stabbing jaw pain", "triggered by brushing teeth or breeze", "intense fleeting pain spasms"]','Neurologist / Neurosurgeon','Soft, lukewarm foods; chew on unaffected side of mouth','Low impact walking, stress reduction techniques','MRI Brain with 3D CISS/FIESTA sequences for trigeminal nerve root compression','Complete inability to drink liquids or eat due to pain, severe dehydration');
INSERT INTO "conditions" VALUES(126,'Bipolar Disorder','["episodes of elevated euphoric mood (mania)", "racing thoughts", "decreased need for sleep", "severe depressive lows", "impulsivity"]','Psychiatrist','Regular balanced meals, avoid caffeine, zero recreational drugs/alcohol','Consistent morning exercise routine to stabilize circadian rhythms','Comprehensive psychiatric clinical interview, rule out thyroid/metabolic triggers','Suicidal ideation, dangerous manic recklessness, psychosis/hallucinations');
INSERT INTO "conditions" VALUES(127,'Obsessive-Compulsive Disorder (OCD)','["intrusive unwanted thoughts (obsessions)", "repetitive behaviors (compulsions)", "fear of contamination", "excessive checking/counting"]','Psychiatrist / Clinical Psychologist','Nutrient dense diet, complex carbohydrates, minimize stimulants','Regular aerobic exercise (running, cycling) to reduce anxiety and stress hormones','Y-BOCS (Yale-Brown Obsessive Compulsive Scale) clinical assessment','Severe functional paralysis, self-harm compulsions, profound depression');
INSERT INTO "conditions" VALUES(128,'Post-Traumatic Stress Disorder (PTSD)','["intrusive flashbacks", "nightmares of trauma", "severe anxiety", "hypervigilance", "avoidance of trauma triggers", "emotional numbness"]','Psychiatrist / Trauma Psychologist','Omega-3 rich foods, magnesium, limit caffeine and evening stimulants','Mind-body practices, yoga, rhythmic walking, grounding outdoor activities','PCL-5 (PTSD Checklist), comprehensive psychological trauma evaluation','Acute panic panic state with self-harm risk, severe dissociation');
INSERT INTO "conditions" VALUES(129,'Lyme Disease','["bullseye skin rash (erythema migrans)", "fever", "fatigue", "chills", "joint aches", "stiff neck", "facial nerve weakness"]','Infectious Disease Specialist / Physician','Anti-inflammatory nutrient dense diet, adequate hydration','Light mobility and walking as tolerated during recovery','Two-tiered testing: ELISA followed by Western Blot for Borrelia burgdorferi','Heart palpitations, fainting (Lyme carditis), severe stiff neck with confusion (Meningitis)');
INSERT INTO "conditions" VALUES(130,'Dengue Fever','["high sudden fever", "severe behind-the-eye pain (retro-orbital)", "bone and joint aches (breakbone)", "skin rash", "nausea", "mild bleeding gums"]','General Physician / Infectious Disease Specialist','Aggressive oral rehydration, papaya leaf extract, coconut water, fresh fruit juices','Strict bed rest during febrile and critical phase; avoid strenuous physical activity','Dengue NS1 Antigen, Dengue IgM/IgG, Complete Blood Count (Platelet count, Hematocrit)','Severe abdominal pain, persistent vomiting, mucosal bleeding, extreme lethargy (Dengue Shock)');
INSERT INTO "conditions" VALUES(131,'Typhoid Fever','["step-ladder progressive fever", "stomach pain", "rose spots rash on chest", "constipation or pea-soup diarrhea", "headache", "extreme weakness"]','Infectious Disease Specialist / Physician','High calorie bland soft diet, boiled water only, peeled fruits, oral electrolyte solutions','Complete physical rest until fever subsides and infection clears','Blood Culture for Salmonella Typhi, Widal test, Typhidot IgM','Sudden severe sharp abdominal pain with rigidity (Intestinal Perforation Emergency)');
INSERT INTO "conditions" VALUES(132,'Shingles & Postherpetic Neuralgia','["painful blistering rash on one side of torso", "burning nerve pain", "skin hypersensitivity (allodynia)", "headache", "fatigue"]','Dermatologist / Neurologist','Lysine rich foods, Vitamin B complex, antioxidant-rich berries','Wear loose cotton clothing; gentle walks as pain permits','Clinical lesion inspection, PCR viral swab for Varicella Zoster Virus','Blisters appearing near the eye or tip of nose (Hutchinson''s sign - sight threatening)');
INSERT INTO "conditions" VALUES(133,'Ankylosing Spondylitis','["chronic inflammatory lower back pain", "morning stiffness lasting > 30 mins", "buttock pain alternating sides", "loss of spinal mobility", "eye redness and pain (uveitis)"]','Rheumatologist','Anti-inflammatory diet rich in omega-3 fatty acids, turmeric, Mediterranean fresh foods','Daily spinal extension exercises, swimming, posture training, deep breathing chest expansion','HLA-B27 genetic marker, MRI of Sacroiliac (SI) joints, Pelvic X-ray, ESR/CRP','Sudden severe eye pain with blurred vision (Acute Anterior Uveitis), spinal fracture after minor trauma');
INSERT INTO "conditions" VALUES(134,'Sjögren''s Syndrome','["severe persistent dry eyes (xerophthalmia)", "dry mouth (xerostomia)", "difficulty swallowing dry foods", "joint aches", "swollen salivary glands", "chronic fatigue"]','Rheumatologist / Ophthalmologist','Moist soft foods with gravies/sauces, sugar-free citrus gums for saliva, abundant water','Gentle regular exercise to combat fatigue; strict oral hygiene routine','Schirmer''s Eye Tear Test, Anti-SSA (Ro) and Anti-SSB (La) antibodies, Salivary gland biopsy','Rapid painless enlargement of salivary lymph glands (Lymphoma screening needed)');
INSERT INTO "conditions" VALUES(135,'Guillain-Barré Syndrome (GBS)','["ascending symmetrical muscle weakness", "numbness starting in feet and moving upward", "loss of deep tendon reflexes", "difficulty climbing stairs", "unsteady gait"]','Neurologist / Critical Care Specialist','High calorie nutritional support, enteral nutrition if swallowing impaired','Inpatient intensive neurological rehabilitation, passive range-of-motion therapy','Lumbar Puncture (Albuminocytologic dissociation in CSF), Nerve Conduction Studies (NCS)','EMERGENCY: Difficulty breathing, swallowing paralysis, severe cardiac arrhythmias');
INSERT INTO "conditions" VALUES(136,'Ménière''s Disease','["episodic spinning vertigo", "fluctuating low-frequency hearing loss", "roaring tinnitus (ear ringing)", "aural fullness / ear pressure"]','ENT Specialist (Neurotologist)','Strict low-sodium diet (< 1500 mg daily), avoid caffeine, chocolate, and alcohol','Vestibular rehabilitation exercises, fall prevention strategies','Pure Tone Audiometry (fluctuating sensorineural hearing loss), VNG (Videonystagmography), MRI IAC','Drop attacks (Tumarkin crisis - sudden violent falls without warning)');
INSERT INTO "conditions" VALUES(137,'Acute Pancreatitis','["severe upper abdominal pain radiating to back", "nausea and violent vomiting", "abdominal tenderness and bloating", "rapid pulse", "fever"]','Gastroenterologist / General Surgeon','NPO (Nothing by mouth) during acute phase, transitioning to low-fat bland soft diet','Strict bed rest during hospital recovery; absolute zero alcohol consumption','Serum Lipase (> 3x upper limit), Serum Amylase, Abdominal Contrast CT / Ultrasound','EMERGENCY: Cold clammy skin, blue bruising around navel (Cullen sign), shallow rapid breathing (Shock)');
INSERT INTO "conditions" VALUES(138,'Cirrhosis of the Liver','["yellow skin and eyes (jaundice)", "abdominal fluid swelling (ascites)", "spider angiomas on skin", "easy bruising", "confusion and sleep reversal (hepatic encephalopathy)", "swollen legs"]','Hepatologist / Gastroenterologist','High protein (1.2-1.5g/kg), low sodium (< 2g/day), absolute alcohol prohibition','Light walking as energy permits; avoid strenuous lifting (reduces variceal rupture risk)','Liver Function Panel (Bilirubin, Albumin, INR), FibroScan, Abdominal Ultrasound, Alpha-Fetoprotein (AFP)','Vomiting bright red blood (Variceal Hemorrhage), severe confusion/coma (Hepatic Encephalopathy)');
INSERT INTO "conditions" VALUES(139,'Barrett''s Esophagus','["longstanding chronic heartburn", "acid regurgitation", "chest burning", "sour taste in mouth", "difficulty swallowing (dysphagia)"]','Gastroenterologist','Avoid acidic triggers, coffee, tomatoes, citrus; elevate head of bed by 6 inches','Maintain healthy BMI; avoid post-meal recumbency for 3 hours','Upper Gastrointestinal Endoscopy (EGD) with Seattle protocol biopsies','Food sticking in chest (progressive dysphagia), unexplained weight loss, vomiting blood');
INSERT INTO "conditions" VALUES(140,'Polycystic Kidney Disease (PKD)','["dull back or flank pain", "blood in urine (hematuria)", "high blood pressure", "frequent urinary tract infections", "enlarged abdomen"]','Nephrologist','Low sodium diet, moderate protein intake, high fluid hydration (> 3 liters/day)','Low-impact exercise (walking, swimming); avoid contact sports (risk of cyst rupture)','Renal Ultrasound / MRI, Serum Creatinine, eGFR, Urinalysis for protein/blood','Sudden severe explosive flank pain with gross hematuria, high fever with shaking chills');
INSERT INTO "conditions" VALUES(141,'Bacterial Meningitis','["sudden high fever", "severe intractable headache", "stiff neck (nuchal rigidity)", "photophobia (light sensitivity)", "confusion", "petechial purple skin rash"]','Infectious Disease Specialist / Neurologist','Hospital ICU intravenous nutrition and fluid therapy','Strict hospital bed rest in darkened quiet room under isolation precautions','Lumbar Puncture CSF analysis (high opening pressure, neutrophils, low glucose), Blood Cultures','MEDICAL EMERGENCY: Call 112/911 immediately. Rapid deterioration, seizures, non-blanching purple rash.');
INSERT INTO "conditions" VALUES(142,'Attention Deficit Hyperactivity Disorder (ADHD)','["inattention to details", "difficulty sustaining focus", "frequent disorganization and forgetfulness", "restlessness", "impulsive decision making", "interrupting conversations"]','Psychiatrist / Behavioral Neurologist','High protein breakfast, balanced complex carbohydrates, omega-3 fatty acids','High intensity aerobic exercise, martial arts, structured team sports to channel focus','Comprehensive clinical ADHD rating scale (DIVA-5 / ASRS-v1.1), psychoeducational assessment','Severe impulsive self-harm risk, severe co-occurring clinical depression');
INSERT INTO "conditions" VALUES(143,'Endometriosis','["severe chronic pelvic pain", "extremely painful menstrual cramps (dysmenorrhea)", "pain during intercourse (dyspareunia)", "heavy menstrual bleeding", "infertility", "pain with bowel movements during periods"]','Gynecologist (Endometriosis / Minimally Invasive Surgery)','Anti-inflammatory diet, high fiber, eliminate trans fats, increase cruciferous vegetables','Gentle pelvic floor physical therapy, yoga, low impact swimming','Transvaginal / Pelvic Ultrasound, Pelvic MRI with endometriosis protocol, Laparoscopy (gold standard)','Sudden severe knife-like pelvic pain with vomiting (Ovarian endometrioma rupture)');
INSERT INTO "conditions" VALUES(144,'Erectile Dysfunction (ED)','["trouble getting an erection", "trouble maintaining an erection", "reduced sexual desire", "anxiety related to sexual performance"]','Urologist / Andrologist','Heart-healthy Mediterranean diet, high intake of leafy greens, nuts, berries, pomegranate','160 mins moderate aerobic exercise weekly to improve cardiovascular endothelial function','Morning Total & Free Testosterone, Fasting Lipid Panel, HbA1c, Penile Doppler Ultrasound','Erection lasting longer than 4 hours (Priapism - immediate emergency room care needed)');
INSERT INTO "conditions" VALUES(145,'Open-Angle Glaucoma','["slow painless loss of peripheral side vision (tunnel vision)", "elevated intraocular pressure", "difficulty seeing in dim light"]','Ophthalmologist (Glaucoma Specialist)','Antioxidant-rich dark leafy greens (kale, spinach), omega-3 fatty acids, avoid excessive caffeine','Moderate aerobic walking; avoid inverted head positions (yoga headstands increase eye pressure)','Applanation Tonometry (IOP measurement), Humphrey Visual Field Test, Optical Coherence Tomography (OCT) Optic Nerve','Sudden severe eye ache, rainbow colored halos around lights, vomiting (Acute Angle Closure Glaucoma Emergency)');
INSERT INTO "conditions" VALUES(146,'Age-Related Macular Degeneration (AMD)','["blurred central vision", "straight lines appearing wavy or distorted (metamorphopsia)", "dark blurry spot in center of vision", "need for brighter light when reading"]','Ophthalmologist (Retina Specialist)','AREDS 2 formula (Lutein, Zeaxanthin, Vitamin C, Vitamin E, Zinc, Copper), dark leafy greens, salmon','Daily brisk walking, strict smoking cessation (smoking doubles AMD progression risk)','Optical Coherence Tomography (OCT Retina), Fluorescein Angiography, Dilated Fundus Exam','Sudden rapid distortion or black spot appearing in central vision within days (Wet AMD bleed)');
INSERT INTO "conditions" VALUES(147,'Rosacea','["persistent facial redness on cheeks and nose", "visible spider veins (telangiectasias)", "acne-like pus bumps on face", "facial burning and stinging", "eye irritation"]','Dermatologist','Avoid hot beverages, spicy foods, alcohol (especially red wine), histamine triggers','Exercise in cool air-conditioned environments; avoid facial overheating and hot saunas','Clinical dermatologic evaluation, rule out lupus butterfly rash and seborrheic dermatitis','Severe eye redness, gritty feeling, light sensitivity (Ocular Rosacea corneal risk)');
INSERT INTO "conditions" VALUES(148,'Cellulitis (Bacterial Skin Infection)','["spreading red hot swollen skin area", "skin pain and tenderness", "skin with orange peel texture (peau d''orange)", "fever and chills", "blisters in severe cases"]','General Physician / Dermatologist','High protein healing diet, abundant fluids','Strict elevation of the affected limb above heart level; rest until infection subsides','Complete Blood Count (Leukocytosis), Blood cultures if systemic toxicity, wound culture','Rapidly spreading dusky purple skin, severe pain out of proportion, high fever (Necrotizing Fasciitis Emergency)');
INSERT INTO "conditions" VALUES(149,'Transient Global Amnesia (TGA)','["sudden temporary loss of short-term memory", "repetitive questioning (''What happened?", "Where are we?'')", "preserved personal identity", "no focal neurological deficits", "confusion lasting 4-12 hours"]','Neurologist / Emergency Physician','Calm supportive hydration, easily digestible meals once nausea subsides','Immediate restful cessation of strenuous exertion, avoid emotional/physical shock triggers','Diffusion-Weighted Brain MRI (DWI shows small punctate hippocampal lesions at 24-48h), EEG, Carotid Doppler','Arm/leg weakness, slurred speech, facial droop, headache with vomiting (Signs of Acute Stroke)');
INSERT INTO "conditions" VALUES(150,'Wernicke-Korsakoff Syndrome','["severe anterograde and retrograde amnesia", "confabulation (inventing fabricated memories)", "unsteady staggering gait (ataxia)", "abnormal eye movements (nystagmus / ophthalmoplegia)", "profound confusion", "apathy"]','Neurologist / Addiction Medicine Specialist','Immediate high-dose nutritional therapy, thiamine-rich foods (fortified grains, legumes, pork, seeds)','Physical therapy for balance and gait re-education under constant supervision','Serum Thiamine/Transketolase assay, Brain MRI (mammillary body and periaqueductal gray hyperintensity), Liver function','Coma, severe hypothermia, profound hypotension, complete loss of consciousness');
INSERT INTO "conditions" VALUES(151,'Dissociative & Psychogenic Amnesia','["sudden inability to recall important personal information / identity", "amnesia following severe trauma or psychological stress", "unexplained wandering away from home (dissociative fugue)", "emotional detachment", "anxiety"]','Psychiatrist / Trauma Psychotherapist','Regular balanced comforting meals, adequate hydration, avoid alcohol and recreational stimulants','Mind-body somatic grounding exercises, rhythmic walking, restorative yoga','Comprehensive psychiatric evaluation, Dissociative Experiences Scale (DES-II), Brain MRI to rule out organic brain pathology','High acute suicide or self-harm risk, severe panic state, wandering in dangerous conditions');
INSERT INTO "conditions" VALUES(152,'Retrograde & Anterograde Amnesia (Post-Traumatic)','["inability to recall events prior to head injury (retrograde)", "inability to create new memories post-trauma (anterograde)", "dizziness", "headache", "irritability", "delayed recall impairment"]','Neurologist / Neuropsychologist','Neuroprotective Mediterranean diet, omega-3 fatty acids, choline-rich eggs, antioxidant berries','Gradual cognitive and physical pacing; avoid contact sports or screen overload during recovery','High-resolution Brain CT / MRI, Comprehensive Neuropsychological Cognitive Battery (WMS-IV)','Worsening headache, repeated vomiting, unequal pupil sizes, fluid draining from nose/ears (Skull fracture)');
INSERT INTO "conditions" VALUES(153,'Vascular Dementia','["stepwise decline in memory and thinking", "difficulty planning and organizing (executive dysfunction)", "slowness of thought", "unsteady walking gait", "frequent urinary urgency", "sudden mood swings / emotional lability"]','Neurologist / Vascular Geriatrician','Strict DASH / Mediterranean diet, low sodium (< 1500mg/day), rich in olive oil, fish, vegetables','Daily 30-min supervised walking, balance physical therapy to reduce stroke recurrence and falls','Brain MRI (demonstrating subcortical white matter ischemic changes and lacunar infarcts), Carotid Doppler, ECG for AFib','Sudden new weakness in arm/leg, slurred speech, sudden loss of balance (Recurrent Acute Stroke)');
INSERT INTO "conditions" VALUES(154,'Lewy Body Dementia','["vivid visual hallucinations", "fluctuating alertness and attention", "Parkinsonian stiffness and slow movement", "REM sleep behavior disorder (acting out dreams)", "frequent unexplained falls", "severe sensitivity to antipsychotics"]','Neurologist (Cognitive & Movement Disorders)','High fiber, small frequent nutritious meals, adequate hydration to manage orthostatic hypotension','Physical therapy for gait stability, Tai Chi for balance, daytime bright light therapy','DaTscan (Dopamine Transporter SPECT), Overnight Polysomnography (REM sleep disorder), MoCA Cognitive Exam','Severe acute delirium, high fever with severe muscle rigidity after neuroleptic medication');
INSERT INTO "conditions" VALUES(155,'Delirium (Acute Confusional State)','["sudden acute onset of confusion", "fluctuating attention throughout the day", "hallucinations or delusions", "disorganized speech", "sleep-wake cycle reversal", "restlessness or hypoactive lethargy"]','Geriatrician / Acute Care Physician','Frequent small sips of water with electrolytes, easily spoon-fed broths and purees','Early mobilization out of bed during daytime; well-lit room with clocks and family presence','Urinalysis with culture, Chest X-ray, Electrolytes, Serum Creatinine, Arterial Blood Gas, Medication review','Severe agitation with self-harm, unresponsiveness, respiratory failure, high septic fever');
INSERT INTO "conditions" VALUES(156,'Myasthenia Gravis','["drooping eyelids (ptosis)", "double vision (diplopia)", "fluctuating muscle weakness worsening with use", "difficulty chewing and swallowing", "nasal slurred speech", "shortness of breath on lying flat"]','Neurologist (Neuromuscular Specialist)','Soft easy-to-chew meals, take Pyridostigmine 30-45 minutes before meals to optimize swallowing power','Exercise during peak medication effect; rest frequently; avoid heat and exhaustion','Anti-AChR (Acetylcholine Receptor) antibodies, Anti-MuSK antibodies, Repetitive Nerve Stimulation (RNS), Chest CT for Thymoma','EMERGENCY: Rapidly worsening breathlessness, inability to swallow saliva (Myasthenic Crisis)');
INSERT INTO "conditions" VALUES(157,'Tourette Syndrome','["involuntary motor tics (eye blinking", "shoulder shrugging", "head jerking)", "vocal tics (throat clearing", "grunting", "barking)", "premonitory urge prior to tic", "co-occurring OCD or ADHD", "worse with stress or excitement"]','Neurologist / Child Psychiatrist','Balanced whole-food diet, minimize caffeine and energy drinks which exacerbate tics','Sports and physical activities that require focused coordination (martial arts, swimming)','Clinical neurological and psychiatric diagnostic evaluation (YGTSS - Yale Global Tic Severity Scale)','Self-injurious violent motor tics (e.g. violent head whipping causing cervical spine injury)');
INSERT INTO "conditions" VALUES(158,'Addison''s Disease (Primary Adrenal Insufficiency)','["bronze hyperpigmentation of skin and gums", "chronic progressive fatigue", "salt craving", "low blood pressure (hypotension)", "unexplained weight loss", "dizziness on standing", "nausea and abdominal pain"]','Endocrinologist','High sodium diet with liberal table salt, regular structured meals, extra hydration','Moderate gentle exercise; mandatory extra hydrocortisone stress dosing before strenuous events','Morning Serum Cortisol, Plasma ACTH (markedly elevated), ACTH Stimulation (Synacthen) Test, Adrenal Antibodies','EMERGENCY: Sudden severe vomiting, diarrhea, acute collapse, severe hypotension (Adrenal Crisis)');
INSERT INTO "conditions" VALUES(159,'Graves'' Disease (Autoimmune Hyperthyroidism)','["bulging eyes (exophthalmos / Graves'' ophthalmopathy)", "palpitations and rapid pulse", "heat intolerance", "trembling hands", "weight loss despite high appetite", "enlarged thyroid goiter in neck", "frequent loose stools"]','Endocrinologist / Ophthalmologist','Calcium and Vitamin D rich diet, avoid high-iodine supplements (kelp, seaweeds)','Low intensity walking and stretching until heart rate is chemically controlled with beta-blockers','TSH Receptor Antibodies (TRAb / TSI), TSH, Free T3/T4, Radioactive Iodine Uptake Scan','High fever, heart rate > 140 bpm, agitation, delirium, vomiting (Thyroid Storm Emergency)');
INSERT INTO "conditions" VALUES(160,'Idiopathic Pulmonary Fibrosis (IPF)','["progressive worsening shortness of breath on exertion", "persistent dry hacking cough", "dry ''velcro'' crackles in lung bases on stethoscope", "clubbing of fingernails and toenails", "fatigue and unexplained weight loss"]','Pulmonologist (Interstitial Lung Disease Specialist)','High calorie nutrient-dense small meals to prevent weight loss from high work of breathing','Structured pulmonary rehabilitation, supplemental oxygen during exercise, breathing retraining','High-Resolution Chest CT (HRCT showing subpleural honeycombing / UIP pattern), Spirometry (FVC, DLCO)','Sudden acute drop in oxygen saturation (< 88%), acute respiratory distress (Acute Exacerbation of IPF)');
INSERT INTO "conditions" VALUES(161,'Peripheral Artery Disease (PAD)','["cramping calf or thigh pain while walking (intermittent claudication)", "pain relieved within 5-10 minutes of resting", "cold pale feet", "weak or absent pedal pulses in feet", "slow healing leg ulcers", "shiny hairless skin on lower legs"]','Vascular Surgeon / Cardiologist','Heart-healthy Mediterranean diet, low saturated fat, high soluble fiber, strict smoking cessation','Structured supervised treadmill walking program (walk to near-maximal pain, rest, repeat for 30 mins)','Ankle-Brachial Index (ABI < 0.9 diagnostic), Arterial Duplex Ultrasound of lower limbs, CT Angiography','Sudden cold, pale, pulseless, painful leg (Acute Limb Ischemia Emergency - 6-hour salvage window)');
INSERT INTO "conditions" VALUES(162,'Sickle Cell Disease & Vaso-Occlusive Crisis','["excruciating bone and joint pain crises", "painful swelling of hands and feet (dactylitis)", "chronic hemolytic anemia and fatigue", "yellow eyes (jaundice)", "frequent bacterial infections", "chest pain with fever (acute chest)"]','Hematologist (Hemoglobinopathy Specialist)','High fluid hydration (3-4 liters daily), folic acid supplementation, avoid dehydration and extreme cold','Moderate non-strenuous exercise with frequent hydration breaks; avoid high altitudes and hypoxia','Hemoglobin Electrophoresis / HPLC, Complete Blood Count, Reticulocyte Count, Transcranial Doppler (stroke screen)','EMERGENCY: Fever > 101.3°F, sudden chest pain with breathlessness (Acute Chest Syndrome), sudden weakness (Stroke)');
INSERT INTO "conditions" VALUES(163,'Zollinger-Ellison Syndrome (Gastrinoma)','["severe recurrent peptic ulcers refractory to treatment", "severe burning abdominal pain", "chronic watery diarrhea and steatorrhea", "heartburn and acid regurgitation", "weight loss"]','Gastroenterologist / Surgical Oncologist','Small bland low-fat meals, avoid coffee, alcohol, citrus, and NSAIDs','Low impact walking, stress reduction','Fasting Serum Gastrin (> 1000 pg/mL), Secretin Stimulation Test, Ga-68 DOTATATE PET/CT, Endoscopic Ultrasound','Sudden rigid board-like abdomen with severe pain (Ulcer Perforation), vomiting blood');
INSERT INTO "conditions" VALUES(164,'Stevens-Johnson Syndrome (SJS / TEN)','["painful peeling skin blisters and sheet detachment", "widespread purplish targetoid rash", "severe blistering ulcers of lips", "mouth", "and eyes", "high fever", "sore throat and burning eyes prior to rash"]','Dermatologist / Critical Care Burn Specialist','Specialized burn-unit enteral nutrition and fluid resuscitation','Strict hospital burn ICU bed rest with sterile non-adherent dressings','Skin biopsy (full-thickness epidermal necrosis), SCORTEN severity score, Electrolytes, Blood cultures','MEDICAL EMERGENCY: Call emergency ambulance immediately. Extensive skin sloughing, eye corneal damage.');
INSERT INTO "conditions" VALUES(165,'Infectious Mononucleosis (EBV / Glandular Fever)','["severe sore throat with white tonsillar exudate", "high fever", "swollen lymph nodes in neck (posterior cervical)", "profound fatigue lasting weeks", "enlarged tender spleen (splenomegaly)", "headache"]','General Physician / Infectious Disease Specialist','Soft soothing cool fluids, honey, broths, avoid hard crunchy foods','Strict avoidance of all contact sports and heavy lifting for at least 4 weeks to prevent splenic rupture','Heterophile Antibody Test (Monospot), EBV Viral Capsid Antigen (VCA) IgM/IgG, Complete Blood Count (Atypical lymphocytes)','Sudden severe sharp pain in left upper abdomen / shoulder tip (Splenic Rupture Emergency), difficulty breathing');
INSERT INTO "conditions" VALUES(166,'Acute Coronary Syndrome (STEMI & NSTEMI Heart Attack)','["crushing substernal chest pain radiating to left arm or jaw", "shortness of breath", "cold clammy diaphoresis (sweating)", "nausea and vomiting", "dizziness and feeling of impending doom"]','Interventional Cardiologist / Emergency Physician','Hospital cardiac ICU diet, transition to strict heart-healthy Mediterranean DASH diet','Immediate hospital bed rest; subsequent Phase II supervised cardiac rehabilitation','12-Lead ECG (ST elevation or depression), High-Sensitivity Cardiac Troponin (hs-cTnI/T), Coronary Angiography','LIFE THREATENING: Crushing chest pain lasting > 5 mins, loss of consciousness, cardiac arrest');
INSERT INTO "conditions" VALUES(167,'Hypertrophic Cardiomyopathy (HCM)','["shortness of breath on exertion", "chest pain during exercise", "fainting or dizziness after physical activity", "heart palpitations", "heart murmur heard on physical exam"]','Cardiologist (HCM Specialist / Electrophysiologist)','Strict adequate hydration, moderate sodium, avoid alcohol and dehydration','Avoid competitive sports, heavy isometric weightlifting, and burst sprints (sudden cardiac death risk)','Echocardiogram (asymmetric septal hypertrophy > 15mm), Cardiac MRI with Late Gadolinium Enhancement, Genetic testing','Unexplained fainting during exercise, sustained rapid palpitations, sudden chest tightness');
INSERT INTO "conditions" VALUES(168,'Dilated Cardiomyopathy (DCM)','["severe progressive shortness of breath", "swelling in legs", "ankles", "and feet (peripheral edema)", "extreme fatigue and weakness", "inability to lie flat without coughing (orthopnea)", "rapid or irregular pulse"]','Heart Failure Cardiologist','Strict low sodium diet (< 2000 mg/day), fluid restriction (1.5-2.0 liters/day), complete alcohol cessation','Supervised cardiac rehabilitation, daily low-impact walking within symptom tolerance','Echocardiogram (dilated left ventricle with LVEF < 40%), Serum BNP / NT-proBNP, Cardiac MRI','Weight gain > 3 lbs in 24 hours, waking up gasping for air (PND), blue lips (Cyanosis)');
INSERT INTO "conditions" VALUES(169,'Acute Pericarditis','["sharp stabbing pleuritic chest pain", "pain relieved by sitting up and leaning forward", "pain worsens on lying flat or deep inspiration", "low-grade fever", "pericardial friction rub on stethoscope"]','Cardiologist','Nutritious balanced anti-inflammatory diet, adequate rest fluids','Strict restriction of strenuous physical exercise until inflammatory markers normalize (prevents recurrence)','12-Lead ECG (widespread concave ST elevations & PR depressions), Echocardiogram (pericardial effusion), High-sensitivity CRP','Rapidly dropping blood pressure, severe breathlessness, distended neck veins (Cardiac Tamponade Emergency)');
INSERT INTO "conditions" VALUES(170,'Infective Endocarditis','["persistent unexplained high fever and chills", "new or changing heart murmur", "splinter hemorrhages under fingernails", "painful red nodules on finger pads (Osler nodes)", "painless red spots on palms/soles (Janeway lesions)", "night sweats"]','Cardiologist / Infectious Disease Specialist','High calorie high protein diet for systemic recovery, oral hygiene support','Strict hospital bed rest during intravenous antibiotic therapy','Transesophageal Echocardiogram (TEE - detecting valve vegetations/abscess), Serial Blood Cultures, ESR/CRP','Sudden onset of stroke symptoms (embolic stroke), acute severe shortness of breath (acute valve rupture)');
INSERT INTO "conditions" VALUES(171,'Aortic Aneurysm & Thoracic Dissection','["sudden excruciating tearing or ripping chest and back pain", "pain radiating between shoulder blades", "pulse difference between right and left arms", "hoarseness of voice", "dizziness or syncope"]','Cardiothoracic Surgeon / Vascular Surgeon','Low sodium heart diet once surgically stabilized','Strict avoidance of heavy weightlifting, straining (Valsalva), or high-intensity bursts','CT Angiography of Chest/Abdomen/Pelvis, Transesophageal Echocardiogram (TEE), D-Dimer','LIFE THREATENING: Tearing back pain with collapse, loss of pulses in legs, hypotension');
INSERT INTO "conditions" VALUES(172,'Nephrotic Syndrome','["severe generalized swelling (anasarca) and puffy eyes/face", "frothy or foamy urine (heavy proteinuria)", "rapid unexplained weight gain from fluid retention", "loss of appetite", "extreme fatigue", "high blood cholesterol"]','Nephrologist','Low sodium diet (< 2000 mg/day), moderate protein intake (0.8-1.0 g/kg), low saturated fat diet','Light walking to promote venous return and prevent thromboembolism; avoid complete bedrest','24-Hour Urine Protein (> 3.5 g/day) or Spot Urine Protein/Creatinine Ratio, Serum Albumin (< 3.0 g/dL), Renal Biopsy, Lipid Panel','Severe sudden leg pain/swelling (DVT), sudden shortness of breath (PE - nephrotic patients are in hypercoagulable state)');
INSERT INTO "conditions" VALUES(173,'Acute Kidney Injury (AKI) & Glomerulonephritis','["sudden decrease in urine output (oliguria)", "cola-colored or smoky dark urine (hematuria)", "swelling in legs and face", "confusion and drowsiness (uremia)", "nausea and metallic taste", "high blood pressure"]','Nephrologist / Critical Care Physician','Strict potassium and phosphorus restriction, fluid allowance calculated as urine output + 500 mL','Hospital bed rest during acute phase; gentle walking once renal function recovers','Serum Creatinine & BUN daily trend, Serum Potassium, Urinalysis with microscopic examination (dysmorphic RBCs, RBC casts), Renal Ultrasound','Serum Potassium > 6.0 mEq/L (Cardiac arrest risk on ECG), severe breathlessness (Pulmonary edema), complete lack of urine (Anuria)');
INSERT INTO "conditions" VALUES(174,'Diabetic Nephropathy (Diabetic Kidney Disease)','["microalbumin in urine", "worsening blood pressure control", "swelling of feet and ankles", "increased frequency of urination at night", "fatigue", "nausea and loss of appetite"]','Nephrologist / Endocrinologist','Controlled protein intake (0.8 g/kg/day), low sodium, strict low-glycemic carbohydrate control','Regular 150-min weekly moderate exercise, daily foot inspection','Spot Urine Albumin-to-Creatinine Ratio (uACR), Estimated Glomerular Filtration Rate (eGFR), HbA1c, Serum Potassium','Nausea, vomiting, severe lethargy with fruity breath (DKA), rapid worsening of leg and facial swelling');
INSERT INTO "conditions" VALUES(175,'Renal Tubular Acidosis & Hyperkalemia Syndrome','["muscle weakness and cramps", "cardiac palpitations / irregular heart beats", "chronic fatigue", "nausea", "bone pain and softening (osteomalacia)"]','Nephrologist','Low potassium foods (avoid bananas, oranges, potatoes), high alkaline water, sodium bicarbonate therapy','Light walking and mobility; avoid strenuous anaerobic workouts that trigger muscle breakdown','Serum Electrolytes (Sodium, Potassium, Chloride, Bicarbonate), Arterial/Venous Blood Gas, Urine pH, Urine Anion Gap','Severe muscle paralysis, peaked T waves on ECG, fainting with slow irregular pulse');
INSERT INTO "conditions" VALUES(176,'Paget''s Disease of Bone','["deep aching bone pain (especially pelvis", "skull", "spine", "femur)", "enlarged skull size (hat size increases)", "bowing of the leg bones", "warmth over affected bone areas", "hearing loss from cranial bone overgrowth", "joint stiffness"]','Endocrinologist / Orthopedic Surgeon / Rheumatologist','Calcium-rich foods (dairy, fortified milks), adequate Vitamin D3, balanced protein','Low-impact weight-bearing exercise (walking), gentle physical therapy to maintain joint range of motion','Serum Total Alkaline Phosphatase (markedly elevated), Skeletal Bone Scan (Tc-99m), Targeted Bone X-rays','Sudden severe localized bone pain with inability to walk (Pathologic fracture), sudden hearing loss');
INSERT INTO "conditions" VALUES(177,'Osteomyelitis (Infectious Bone Infection)','["intense localized bone pain and tenderness", "swelling", "warmth", "and redness over the bone", "high fever and chills", "drainage of pus through skin sinus tract", "inability to bear weight on the affected limb", "malaise"]','Orthopedic Surgeon / Infectious Disease Specialist','High calorie, high protein wound-healing diet with Vitamin C and Zinc','Immobilization of the affected bone with splints; non-weight bearing until bone structure consolidates','MRI of affected bone (gold standard for marrow edema/abscess), Bone Biopsy with bacterial culture, ESR, CRP, Blood cultures','Spreading redness with septic shock, complete loss of sensation in foot/toes, high spiking fevers');
INSERT INTO "conditions" VALUES(178,'Avascular Necrosis of Bone (Osteonecrosis of Femoral Head)','["deep groin or hip pain worsening on weight bearing", "pain radiating down thigh to knee", "limping and reduced hip internal rotation", "clicking or popping sensation in hip joint", "severe pain at rest in advanced stages"]','Orthopedic Surgeon (Joint Reconstruction)','Anti-inflammatory nutrient dense diet, Vitamin D and Calcium supplementation, strict alcohol cessation','Strict protected non-weight bearing with crutches in early stages; swimming and upper body training','MRI Hip (double-line sign diagnostic in early pre-collapse stage), Pelvic X-rays (frog-leg lateral view)','Sudden acute severe hip pain with complete inability to stand (Sudden subchondral bone collapse)');
INSERT INTO "conditions" VALUES(179,'Osteomalacia & Adult Rickets','["diffuse generalized dull aching bone pain", "proximal muscle weakness (difficulty rising from a chair or climbing stairs)", "waddling gait", "bone tenderness upon pressure over shins", "sternum", "and pelvis", "frequent low-trauma stress fractures"]','Endocrinologist / Rheumatologist','High-dose Vitamin D3 rich foods (fatty fish, egg yolks), Calcium rich fortified foods, safe sun exposure','Gentle resistance training, daily outdoor walking in sunlight, balance therapy to prevent falls','25-Hydroxy Vitamin D (< 20 ng/mL), Serum Calcium, Serum Phosphate (low), Alkaline Phosphatase (elevated), DEXA scan','Numbness around lips and hands, painful muscle spasms/tetany (Severe acute hypocalcemia)');
INSERT INTO "conditions" VALUES(180,'Polymyalgia Rheumatica (PMR) & Giant Cell Arteritis','["severe bilateral shoulder and neck morning stiffness", "bilateral hip girdle aching", "stiffness lasting > 45 minutes upon waking", "temporal headache and scalp tenderness", "jaw pain while chewing (jaw claudication)", "vision blurring or sudden vision loss"]','Rheumatologist / Ophthalmologist','Anti-inflammatory Mediterranean diet, calcium and Vitamin D supplementation to protect bones against steroid bone loss','Gentle range of motion stretching, walking; avoid heavy resistance during acute inflammatory phase','Erythrocyte Sedimentation Rate (ESR > 50 mm/hr), C-Reactive Protein (CRP), Temporal Artery Biopsy / Ultrasound','EMERGENCY: Sudden loss of vision in one eye, double vision, severe new one-sided headache (Giant Cell Arteritis - Blindness risk)');
INSERT INTO "conditions" VALUES(181,'Lumbar Spinal Stenosis & Spondylolisthesis','["lower back pain radiating down both legs (neurogenic claudication)", "numbness", "heaviness", "and weakness in legs when walking", "pain relieved by bending forward or sitting down (''shopping cart sign'')", "tight hamstring muscles", "difficulty walking long distances"]','Spine Surgeon (Orthopedic / Neurosurgeon)','Anti-inflammatory diet, weight management to reduce compressive axial spine load','Flexion-based lumbar stabilization exercises (stationary biking, abdominal core strengthening, pelvic tilts)','MRI Lumbar Spine (cross-sectional canal area < 100 mm²), Standing Flexion-Extension Lumbar X-rays','Loss of bowel or bladder control, numbness in groin and buttocks (Cauda Equina Syndrome Emergency)');
INSERT INTO "conditions" VALUES(182,'Septic Arthritis (Acute Bacterial Joint Infection)','["sudden acute severe pain in a single joint (most commonly knee or hip)", "joint hot to touch", "swollen", "and red", "inability to move or bear any weight on the joint", "high fever with shivering chills", "joint effusion"]','Orthopedic Surgeon / Rheumatologist','High protein recovery diet, adequate hydration','Complete joint resting splint during acute infection, followed by early passive mobilization after sterilization','Synovial Fluid Analysis (WBC > 50,000/µL with > 90% neutrophils, crystals, culture), Blood cultures, Joint X-ray','SURGICAL EMERGENCY: Rapid cartilage destruction occurs within 24-48 hours if joint is not washed out');
CREATE TABLE doctors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    specialty TEXT NOT NULL,
    qualification TEXT,
    experience_years INTEGER,
    hospital_clinic TEXT,
    city TEXT,
    consultation_fee TEXT,
    rating REAL,
    available_days TEXT,
    available_slots TEXT
);
INSERT INTO "doctors" VALUES(15,'Dr. Rajesh Varma','Cardiologist','MBBS, MD, DM (Cardiology)',15,'Care Heart Institute','Hyderabad','Rs. 700',4.9,'Mon, Wed, Fri, Sat','09:30 AM, 11:00 AM, 04:30 PM, 06:00 PM');
INSERT INTO "doctors" VALUES(16,'Dr. Ananya Reddy','Neurologist','MBBS, MD (Medicine), DM (Neurology)',12,'NeuroCare Brain Center','Hyderabad','Rs. 800',4.9,'Mon, Tue, Thu, Sat','10:00 AM, 12:00 PM, 03:00 PM, 05:30 PM');
INSERT INTO "doctors" VALUES(17,'Dr. Vikram Malhotra','Pulmonologist','MBBS, DNB (Respiratory Diseases)',14,'Apex Chest & Lung Clinic','Bangalore','Rs. 650',4.8,'Mon, Tue, Wed, Fri','09:00 AM, 11:30 AM, 02:30 PM, 05:00 PM');
INSERT INTO "doctors" VALUES(18,'Dr. Sunita Deshmukh','Gastroenterologist','MBBS, MD, DM (Gastroenterology)',16,'Digestive Health Institute','Mumbai','Rs. 750',4.9,'Tue, Thu, Fri, Sat','10:30 AM, 01:00 PM, 04:00 PM, 06:30 PM');
INSERT INTO "doctors" VALUES(19,'Dr. Arvind Swaminathan','Orthopedic Specialist','MBBS, MS (Ortho), MCh',18,'Joint & Bone Hospital','Chennai','Rs. 700',4.9,'Mon, Wed, Thu, Sat','09:30 AM, 11:30 AM, 03:30 PM, 06:00 PM');
INSERT INTO "doctors" VALUES(20,'Dr. Pooja Singhania','Dermatologist','MBBS, MD (Dermatology)',10,'Skin & Aesthetic Clinic','Delhi','Rs. 600',4.8,'Mon, Tue, Wed, Thu, Sat','11:00 AM, 01:30 PM, 04:30 PM, 07:00 PM');
INSERT INTO "doctors" VALUES(21,'Dr. Devendra Sharma','General Physician','MBBS, MD (Internal Medicine)',20,'City Health Clinic','Hyderabad','Rs. 500',4.9,'Mon, Tue, Wed, Thu, Fri, Sat','09:00 AM, 10:30 AM, 12:00 PM, 04:00 PM, 06:00 PM, 07:30 PM');
INSERT INTO "doctors" VALUES(22,'Dr. Priya Nambiar','Endocrinologist','MBBS, MD, DM (Endocrinology)',13,'Diabetes & Hormone Care','Kochi','Rs. 650',4.9,'Mon, Wed, Thu, Sat','10:00 AM, 01:00 PM, 04:00 PM');
INSERT INTO "doctors" VALUES(23,'Dr. Suresh Kulkarni','Urologist','MBBS, MS, MCh (Urology)',17,'Kidney & Uro Care Hospital','Pune','Rs. 750',4.8,'Tue, Wed, Fri, Sat','09:30 AM, 12:00 PM, 05:00 PM');
INSERT INTO "doctors" VALUES(24,'Dr. Meenakshi Sundaram','Ophthalmologist','MBBS, MS (Ophthalmology)',11,'Vision Eye Center','Chennai','Rs. 550',4.8,'Mon, Tue, Thu, Fri, Sat','10:00 AM, 02:00 PM, 06:00 PM');
INSERT INTO "doctors" VALUES(25,'Dr. Farhan Siddiqui','ENT Specialist','MBBS, MS (ENT)',15,'Metro Ear Nose Throat Clinic','Kolkata','Rs. 600',4.8,'Mon, Wed, Fri, Sat','09:00 AM, 11:30 AM, 04:30 PM');
INSERT INTO "doctors" VALUES(26,'Dr. Kavitha Raman','Gynecologist','MBBS, DGO, MD (OBG)',14,'Women’s Wellness Center','Hyderabad','Rs. 700',4.9,'Mon, Tue, Wed, Thu, Sat','10:30 AM, 01:30 PM, 05:00 PM');
INSERT INTO "doctors" VALUES(27,'Dr. Siddharth Sen','Rheumatologist','MBBS, MD, DM (Clinical Immunology)',12,'Arthritis & Autoimmune Center','Kolkata','Rs. 800',4.9,'Tue, Thu, Sat','11:00 AM, 03:00 PM, 06:30 PM');
INSERT INTO "doctors" VALUES(28,'Dr. Radhika Bose','Psychiatrist','MBBS, MD (Psychiatry)',13,'MindCare Neuropsychiatry','Bangalore','Rs. 750',4.9,'Mon, Wed, Fri, Sat','10:00 AM, 02:30 PM, 05:30 PM');
CREATE TABLE email_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    recipient TEXT NOT NULL,
    subject TEXT NOT NULL,
    body TEXT NOT NULL,
    status TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE medicines (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    active_ingredient TEXT,
    category TEXT,
    uses TEXT,
    form TEXT,
    example_strength TEXT,
    precautions TEXT,
    common_side_effects TEXT
);
INSERT INTO "medicines" VALUES(1,'Acyclovir','Acyclovir','Antiviral','Herpes infections','Tablet/cream','200 mg','Dose depends on infection and kidney function.','Nausea; headache');
INSERT INTO "medicines" VALUES(2,'Adalimumab','Adalimumab (Humira)','Biologic / TNF Inhibitor','Psoriatic Arthritis, Ankylosing Spondylitis, Crohn''s, Plaque Psoriasis','Subcutaneous Auto-Injector','40 mg/0.8 mL','Do not administer during active severe infection; store in refrigerator.','Injection site pain/redness, upper respiratory infection, headache');
INSERT INTO "medicines" VALUES(3,'Albendazole','Albendazole','Anthelmintic','Selected worm infections','Tablet','400 mg','Use under appropriate medical/public-health guidance.','Abdominal discomfort; headache');
INSERT INTO "medicines" VALUES(4,'Alendronate','Alendronate Sodium (Fosamax)','Bisphosphonate / Bone Resorption Inhibitor','Postmenopausal Osteoporosis, Paget''s Disease of Bone, Glucocorticoid-induced Osteoporosis','Tablet (Weekly dose)','70 mg (Once Weekly)','Take with 8 oz plain water upon waking; remain upright (do not lie down) for 30 minutes; risk of esophageal ulceration.','Esophageal irritation, dyspepsia, musculoskeletal pain, osteonecrosis of the jaw (rare)');
INSERT INTO "medicines" VALUES(5,'Allopurinol','Allopurinol','Xanthine oxidase inhibitor','Gout prevention','Tablet','100 mg','Start and adjust under medical guidance.','Rash; GI upset');
INSERT INTO "medicines" VALUES(6,'Amiodarone','Amiodarone HCl','Class III Antiarrhythmic','Ventricular Fibrillation, Ventricular Tachycardia, Refractory Atrial Fibrillation','Tablet / IV Injection','200 mg','Baseline and periodic pulmonary function tests (PFTs), thyroid panel, liver enzymes, and eye exams required.','Pulmonary toxicity, thyroid dysfunction (hypo/hyper), corneal microdeposits, photosensitivity');
INSERT INTO "medicines" VALUES(7,'Amlodipine','Amlodipine','Calcium-channel blocker','High blood pressure','Tablet','5 mg','Requires blood-pressure monitoring.','Ankle swelling; dizziness');
INSERT INTO "medicines" VALUES(8,'Amoxicillin','Amoxicillin Trihydrate','Aminopenicillin Antibiotic','Bacterial infections, Lyme disease, Otitis media, Skin infections, Sepsis','Capsule / Suspension','500 mg','Contraindicated in penicillin allergy; complete full course.','Diarrhea, nausea, skin rash');
INSERT INTO "medicines" VALUES(9,'Apixaban','Apixaban','Anticoagulant','Blood-clot prevention/treatment','Tablet','5 mg','Bleeding risk and interactions require supervision.','Bleeding; bruising');
INSERT INTO "medicines" VALUES(10,'Artemether-Lumefantrine','Artemether/Lumefantrine','Antimalarial','Malaria','Tablet','20/120 mg','Use under appropriate malaria diagnosis/treatment guidance.','Headache; dizziness');
INSERT INTO "medicines" VALUES(11,'Artificial Tears','Lubricating drops','Ocular lubricant','Dry eye','Eye drops','As labeled','Use sterile products; persistent pain/vision change needs assessment.','Temporary blur; irritation');
INSERT INTO "medicines" VALUES(12,'Aspirin','Aspirin','Antiplatelet/NSAID','Selected cardiovascular prevention; pain','Tablet','75 mg','Bleeding, ulcers and age-specific issues need advice.','Stomach irritation; bleeding');
INSERT INTO "medicines" VALUES(13,'Atorvastatin','Atorvastatin','Statin','High cholesterol','Tablet','10 mg','Liver disease and interactions require review.','Muscle aches; digestive symptoms');
INSERT INTO "medicines" VALUES(14,'Azathioprine','Azathioprine (Imuran)','Immunosuppressive Antimetabolite','Myasthenia Gravis, Autoimmune Hepatitis, Renal transplant rejection, Systemic Lupus','Tablet','50 mg','Test TPMT/NUDT15 enzyme activity; regular complete blood count (CBC) monitoring required.','Leukopenia, nausea, liver function abnormalities');
INSERT INTO "medicines" VALUES(15,'Azithromycin','Azithromycin','Macrolide Antibiotic','Respiratory tract infections, Community Acquired Pneumonia, Strep, Chlamydia','Tablet / Suspension','500 mg','Caution in patients with QT prolongation; take full prescribed course.','Nausea, diarrhea, abdominal pain, headache');
INSERT INTO "medicines" VALUES(16,'Baclofen','Baclofen','Skeletal Muscle Relaxant','Multiple Sclerosis spasticity, Spinal cord injury muscle spasms','Tablet','10 mg','Avoid sudden withdrawal (hallucinations/seizures risk).','Drowsiness, weakness, dizziness, fatigue');
INSERT INTO "medicines" VALUES(17,'Benzoyl Peroxide','Benzoyl peroxide','Topical acne medicine','Acne','Gel','2.5%','May irritate skin and bleach fabrics.','Dryness; redness');
INSERT INTO "medicines" VALUES(18,'Betahistine','Betahistine Dihydrochloride','Histamine Analog / Vestibular Agent','Ménière''s Disease, Vertigo, Tinnitus, Hearing Loss','Tablet','16 mg / 24 mg','Caution in bronchial asthma and peptic ulcer history.','Mild nausea, headache, gastric discomfort');
INSERT INTO "medicines" VALUES(19,'Budesonide','Budesonide','Inhaled corticosteroid','Airway inflammation','Inhaler','200 mcg/actuation','Use as prescribed; rinse mouth after use.','Hoarseness; oral thrush');
INSERT INTO "medicines" VALUES(20,'Calcium Carbonate','Calcium carbonate','Mineral supplement','Calcium supplementation','Tablet','500 mg','Kidney stones and interactions may matter.','Constipation; bloating');
INSERT INTO "medicines" VALUES(21,'Calcium Carbonate + D3','Elemental Calcium (600mg) + Cholecalciferol (400 IU)','Bone Mineral & Vitamin Supplement','Osteoporosis prevention and treatment, Hypocalcemia, Osteomalacia, Rickets','Tablet','600 mg / 400 IU','Take with meals for optimal stomach acid absorption; separate from Iron or Levothyroxine by 2 hours.','Constipation, bloating, gas, hypercalcemia if overconsumed');
INSERT INTO "medicines" VALUES(22,'Carbamazepine','Carbamazepine','Antiseizure medicine','Epilepsy; selected nerve pain','Tablet','200 mg','Interactions and blood monitoring may be needed.','Dizziness; nausea; rash');
INSERT INTO "medicines" VALUES(23,'Carvedilol','Carvedilol','Alpha/Beta-Blocker','Heart Failure with reduced ejection fraction, Post-MI hypertension','Tablet','12.5 mg','Take with food to minimize postural hypotension risk.','Dizziness, hypotension, weight gain, fatigue');
INSERT INTO "medicines" VALUES(24,'Ceftriaxone','Ceftriaxone Sodium','Third-Generation Cephalosporin Antibiotic','Bacterial Meningitis, Severe Sepsis, Gonorrhea, Pyelonephritis, Lyme carditis','IM / IV Injection','1 g / 2 g','Do not mix with calcium-containing IV solutions; verify beta-lactam allergy.','Diarrhea, injection site pain, eosinophilia');
INSERT INTO "medicines" VALUES(25,'Celecoxib','Celecoxib (Celebrex)','COX-2 Selective NSAID','Osteoarthritis, Ankylosing Spondylitis, Acute Musculoskeletal Pain, Rheumatoid Arthritis','Capsule','100 mg / 200 mg','Lower GI bleed risk than non-selective NSAIDs; contraindicated in sulfonamide allergy and post-CABG surgery.','Hypertension, fluid retention, headache, dyspepsia');
INSERT INTO "medicines" VALUES(26,'Cetirizine','Cetirizine','Antihistamine','Allergic symptoms','Tablet','10 mg','May cause drowsiness; check interactions.','Drowsiness; dry mouth');
INSERT INTO "medicines" VALUES(27,'Cilostazol','Cilostazol (Pletal)','Phosphodiesterase-3 Inhibitor / Antiplatelet','Peripheral Artery Disease (PAD) intermittent claudication, Walking distance improvement','Tablet','100 mg','CONTRAINDICATED in patients with heart failure of any severity.','Headache, diarrhea, palpitations, dizziness');
INSERT INTO "medicines" VALUES(28,'Ciprofloxacin','Ciprofloxacin','Fluoroquinolone Antibiotic','Complicated UTI, Bacterial Prostatitis, Infectious Diarrhea, Typhoid','Tablet','500 mg','Black box warning for tendon rupture/tendinitis; avoid with dairy/antacids.','Nausea, diarrhea, dizziness, photosensitivity');
INSERT INTO "medicines" VALUES(29,'Clobetasol','Clobetasol Propionate','Super-Potent Topical Corticosteroid','Psoriasis, Severe Eczema, Lichen Planus','Ointment / Cream','0.05%','Do not use on face or for > 2 consecutive weeks without supervision.','Skin atrophy, striae, burning sensation, hypopigmentation');
INSERT INTO "medicines" VALUES(30,'Clonazepam','Clonazepam','Benzodiazepine / Anticonvulsant','Panic Disorder, Seizure Disorders, Acute Akathisia','Tablet','0.5 mg','High dependency risk; short-term use recommended; avoid alcohol.','Drowsiness, ataxia, coordination loss, fatigue');
INSERT INTO "medicines" VALUES(31,'Clopidogrel','Clopidogrel','Antiplatelet Agent','Recent MI, Stroke prevention, Peripheral Arterial Disease, Stent thrombosis','Tablet','75 mg','Increased bleeding risk; stop 5-7 days before scheduled surgery.','Bleeding, bruising, gastrointestinal discomfort');
INSERT INTO "medicines" VALUES(32,'Clotrimazole','Clotrimazole','Antifungal','Fungal infections','Cream/lozenge','1% cream','Persistent symptoms need assessment.','Skin irritation; burning');
INSERT INTO "medicines" VALUES(33,'Colchicine','Colchicine','Anti-inflammatory','Acute gout','Tablet','0.6 mg','Toxicity/interactions/kidney function require advice.','Diarrhea; nausea');
INSERT INTO "medicines" VALUES(34,'Darbepoetin Alfa','Darbepoetin Alfa (Aranesp)','Erythropoiesis-Stimulating Agent (ESA)','Anemia associated with Chronic Kidney Disease (CKD)','Subcutaneous / IV Pre-filled Syringe','40 mcg / 60 mcg','Target hemoglobin level 10-11 g/dL (do not exceed 11.5 g/dL due to stroke/thrombosis risk).','Hypertension, vascular access thrombosis, headache, arthralgia');
INSERT INTO "medicines" VALUES(35,'Denosumab','Denosumab (Prolia / Xgeva)','Monoclonal Antibody / RANKL Inhibitor','High fracture risk Osteoporosis, Giant cell tumor of bone, Bone metastases','Subcutaneous Injection','60 mg every 6 months','Correct pre-existing hypocalcemia before dosing; administer adequate Calcium and Vitamin D.','Hypocalcemia, back pain, extremity pain, musculoskeletal aches');
INSERT INTO "medicines" VALUES(36,'Dexamethasone','Dexamethasone Sodium Phosphate','Potent Glucocorticoid','Bacterial Meningitis adjunct, Cerebral Edema, Severe Croup, Allergic Shock','Tablet / IV Injection','4 mg / 8 mg','Monitor blood glucose and signs of infection.','Elevated blood sugar, mood changes, insomnia');
INSERT INTO "medicines" VALUES(37,'Dextromethorphan','Dextromethorphan','Antitussive','Cough suppression','Syrup','10 mg/5 mL','Important interactions exist with some antidepressants.','Drowsiness; dizziness');
INSERT INTO "medicines" VALUES(38,'Diclofenac','Diclofenac','NSAID','Pain and inflammation','Tablet/Gel','50 mg','GI, kidney and cardiovascular risks require advice.','Stomach upset; skin irritation');
INSERT INTO "medicines" VALUES(39,'Dicyclomine','Dicyclomine HCl','Anticholinergic / Antispasmodic','Irritable Bowel Syndrome (IBS) intestinal cramps & spasms','Capsule / Tablet','20 mg','Contraindicated in glaucoma, severe ulcerative colitis, urinary retention.','Dry mouth, blurred vision, dizziness, drowsiness');
INSERT INTO "medicines" VALUES(40,'Digoxin','Digoxin','Cardiac Glycoside','Atrial Fibrillation rate control, Systolic Heart Failure','Tablet','0.125 mg','Narrow therapeutic index; monitor serum digoxin and potassium levels.','Nausea, visual halos (yellow-green), arrhythmias, confusion');
INSERT INTO "medicines" VALUES(41,'Diltiazem','Diltiazem HCl (Cardizem)','Non-Dihydropyridine Calcium Channel Blocker','Atrial Fibrillation rate control, Angina Pectoris, Hypertension, Paroxysmal SVT','Extended-Release Capsule','120 mg / 240 mg','Contraindicated in severe bradycardia, second/third-degree AV block, sick sinus syndrome.','Bradycardia, peripheral edema, dizziness, constipation');
INSERT INTO "medicines" VALUES(42,'Dimenhydrinate','Dimenhydrinate','Antihistamine/antiemetic','Motion sickness','Tablet','50 mg','Can cause marked drowsiness; check interactions.','Drowsiness; dry mouth');
INSERT INTO "medicines" VALUES(43,'Donepezil','Donepezil HCl (Aricept)','Cholinesterase Inhibitor','Alzheimer''s Dementia, Mild-to-Moderate Cognitive Impairment','Tablet','10 mg','Risk of bradycardia and syncope; take at bedtime.','Nausea, diarrhea, insomnia, muscle cramps, fatigue');
INSERT INTO "medicines" VALUES(44,'Doxycycline','Doxycycline Hyclate','Tetracycline Antibiotic','Lyme Disease, Acne Vulgaris, Rosacea, Atypical Pneumonia, Malaria prophylaxis','Capsule','100 mg','Take with full glass of water and remain upright for 30 mins; sun sensitivity.','Nausea, photosensitivity, esophageal irritation');
INSERT INTO "medicines" VALUES(45,'Duloxetine','Duloxetine (Cymbalta)','SNRI (Serotonin-Norepinephrine Reuptake Inhibitor)','Major Depressive Disorder, GAD, Fibromyalgia, Chronic Musculoskeletal Pain','Delayed-Release Capsule','30 mg / 60 mg','Monitor blood pressure; do not crush capsules; suicidal thoughts risk.','Nausea, dry mouth, constipation, fatigue, insomnia');
INSERT INTO "medicines" VALUES(46,'Empagliflozin','Empagliflozin','SGLT2 inhibitor','Type 2 diabetes','Tablet','10 mg','Dehydration and kidney function require guidance.','Genital/urinary infections; dehydration');
INSERT INTO "medicines" VALUES(47,'Escitalopram','Escitalopram','SSRI','Anxiety; depression','Tablet','10 mg','Prescription medicine; interactions and monitoring matter.','Nausea; sleep changes');
INSERT INTO "medicines" VALUES(48,'Famotidine','Famotidine','H2 blocker','Acid-related disorders','Tablet','20 mg','Kidney impairment may require adjustment.','Headache; dizziness');
INSERT INTO "medicines" VALUES(49,'Ferrous Sulfate','Ferrous sulfate','Iron supplement','Iron deficiency','Tablet','200 mg','Causes of anemia should be evaluated.','Constipation; nausea');
INSERT INTO "medicines" VALUES(50,'Finasteride','Finasteride','5-alpha reductase inhibitor','Prostate enlargement','Tablet','5 mg','Not for use in pregnancy; effects take time.','Reduced libido; sexual side effects');
INSERT INTO "medicines" VALUES(51,'Fluconazole','Fluconazole','Triazole Antifungal','Vaginal Candidiasis, Oral Thrush, Esophageal Candidiasis, Cryptococcal Meningitis','Capsule','150 mg','Check drug interactions (CYP inhibitor); monitor liver enzymes on long therapy.','Headache, nausea, abdominal pain, diarrhea');
INSERT INTO "medicines" VALUES(52,'Fludrocortisone','Fludrocortisone Acetate','Mineralocorticoid Replacement','Addison''s Disease, Orthostatic Hypotension, Salt-wasting syndromes','Tablet','0.1 mg','Monitor blood pressure and serum potassium levels; avoid salt restriction.','Hypertension, hypokalemia, peripheral edema');
INSERT INTO "medicines" VALUES(53,'Fluoxetine','Fluoxetine','SSRI','Depression; selected anxiety','Capsule','20 mg','Prescription medicine; interactions and monitoring matter.','Nausea; sleep changes');
INSERT INTO "medicines" VALUES(54,'Fluticasone Nasal','Fluticasone Propionate (Flonase)','Nasal Corticosteroid','Allergic Rhinitis, Perennial Rhinitis, Nasal Polyps','Nasal Spray','50 mcg/spray','Point nozzle away from nasal septum to prevent epistaxis (nosebleeds).','Nosebleeds, nasal irritation, headache, burning sensation');
INSERT INTO "medicines" VALUES(55,'Furosemide','Furosemide','Loop diuretic','Fluid retention','Tablet','40 mg','Electrolytes, blood pressure and kidney function need monitoring.','Dehydration; dizziness');
INSERT INTO "medicines" VALUES(56,'Gabapentin','Gabapentin','Neuropathic pain medicine','Neuropathic pain','Capsule','100 mg','May cause dizziness/sedation; kidney function matters.','Drowsiness; dizziness');
INSERT INTO "medicines" VALUES(57,'Glipizide','Glipizide','Sulfonylurea','Type 2 Diabetes glycemic control','Tablet','5 mg','High risk of hypoglycemia; take 30 mins before first main meal.','Hypoglycemia, weight gain, dizziness');
INSERT INTO "medicines" VALUES(58,'Guaifenesin','Guaifenesin','Expectorant','Chest congestion','Syrup','100 mg/5 mL','Check combination products for duplicates.','Nausea; dizziness');
INSERT INTO "medicines" VALUES(59,'Haloperidol','Haloperidol (Haldol)','First-Generation Typical Antipsychotic','Acute Delirium agitation, Schizophrenia, Tourette Syndrome tics','Tablet / IM Injection','2 mg / 5 mg','Risk of extrapyramidal symptoms (acute dystonia, tardive dyskinesia) and QT prolongation.','Extrapyramidal symptoms, sedation, dry mouth, muscle stiffness');
INSERT INTO "medicines" VALUES(60,'Hydrochlorothiazide','Hydrochlorothiazide','Thiazide Diuretic','Hypertension, Edema, Fluid Retention','Tablet','25 mg','Risk of hypokalemia, hyponatremia, and elevated uric acid levels.','Frequent urination, dizziness, electrolyte imbalance');
INSERT INTO "medicines" VALUES(61,'Hydrocortisone','Hydrocortisone','Topical corticosteroid','Inflammatory/itchy skin','Cream','1%','Use thinly and for limited periods unless advised.','Irritation; skin thinning with prolonged misuse');
INSERT INTO "medicines" VALUES(62,'Hydroxychloroquine','Hydroxychloroquine','Antimalarial / DMARD','Systemic Lupus Erythematosus (SLE), Rheumatoid Arthritis, Discoid Lupus','Tablet','200 mg','Annual ophthalmologic retinal screening required for long term use.','Mild GI upset, headache, rash, retinopathy (rare long-term)');
INSERT INTO "medicines" VALUES(63,'Hydroxyurea','Hydroxyurea','Antineoplastic / Fetal Hemoglobin Inducer','Sickle Cell Disease painful crises reduction, Polycythemia Vera','Capsule','500 mg','Bone marrow suppression; monitor complete blood counts (CBC) with reticulocyte count.','Leukopenia, anemia, nausea, hyperpigmentation of nails/skin');
INSERT INTO "medicines" VALUES(64,'Ibuprofen','Ibuprofen','NSAID','Pain; fever; inflammation','Tablet','200 mg','GI, kidney, cardiovascular and pregnancy cautions.','Stomach upset; bleeding; kidney problems');
INSERT INTO "medicines" VALUES(65,'Infliximab','Infliximab (Remicade)','Biologic / Anti-TNF Alpha','Crohn''s Disease, Ulcerative Colitis, Rheumatoid Arthritis, Ankylosing Spondylitis','IV Infusion','100 mg vial','Screen for latent tuberculosis and hepatitis B prior to initiation; infection risk.','Infusion reactions, respiratory infections, headache');
INSERT INTO "medicines" VALUES(66,'Insulin Glargine','Insulin Glargine (Lantus)','Long-Acting Basal Insulin','Type 1 Diabetes, Type 2 Diabetes basal requirement','Subcutaneous Injection','100 units/mL','Rotate injection sites; monitor blood glucose to prevent severe hypoglycemia.','Hypoglycemia, lipodystrophy at injection site, weight gain');
INSERT INTO "medicines" VALUES(67,'Isoniazid','Isoniazid','Antibiotic','Tuberculosis treatment combination','Tablet','300 mg','TB treatment requires specialist/public-health guidance.','Liver injury; neuropathy');
INSERT INTO "medicines" VALUES(68,'Isosorbide Mononitrate','Isosorbide Mononitrate (Imdur)','Long-Acting Nitrate Vasodilator','Prophylaxis of Angina Pectoris due to Coronary Artery Disease','Extended-Release Tablet','30 mg / 60 mg','Requires a daily 12-hour nitrate-free interval to prevent drug tolerance; strictly avoid PDE-5 inhibitors.','Headache (severe at therapy initiation), dizziness, flushing, hypotension');
INSERT INTO "medicines" VALUES(69,'Isotretinoin','Isotretinoin','Retinoid','Severe Recalcitrant Nodular Acne, Cystic Acne','Capsule','20 mg','Extreme teratogen (strict contraception mandatory); monitor lipids/liver.','Dry lips, dry skin, nosebleeds, photosensitivity, elevated triglycerides');
INSERT INTO "medicines" VALUES(70,'Ketoconazole','Ketoconazole','Antifungal','Dandruff/fungal skin conditions','Shampoo/cream','2%','Follow directions; persistent symptoms need assessment.','Irritation; dryness');
INSERT INTO "medicines" VALUES(71,'Lactulose','Lactulose','Osmotic laxative','Constipation','Solution','10 g/15 mL','Excessive use may cause dehydration/electrolyte problems.','Gas; bloating; diarrhea');
INSERT INTO "medicines" VALUES(72,'Latanoprost','Latanoprost','Prostaglandin analogue','Glaucoma','Eye drops','0.005%','Use under ophthalmology guidance.','Eye redness; eyelash changes');
INSERT INTO "medicines" VALUES(73,'Levetiracetam','Levetiracetam','Antiseizure medicine','Epilepsy','Tablet','500 mg','Do not change/stop abruptly without medical advice.','Sleepiness; dizziness');
INSERT INTO "medicines" VALUES(74,'Levodopa/Carbidopa','Carbidopa-Levodopa','Dopamine Precursor','Parkinson''s Disease, Parkinsonism, Post-encephalitic syndrome','Tablet','25/100 mg','Avoid high protein meals at dose time; monitor for dyskinesias.','Nausea, involuntary movements (dyskinesia), orthostatic hypotension, dark urine');
INSERT INTO "medicines" VALUES(75,'Levothyroxine','Levothyroxine','Thyroid hormone','Hypothyroidism','Tablet','50 mcg','Dose is individualized using thyroid tests.','Palpitations; tremor if over-replaced');
INSERT INTO "medicines" VALUES(76,'Lisinopril','Lisinopril','ACE Inhibitor','Hypertension, Heart Failure, Post-Myocardial Infarction','Tablet','10 mg','Monitor serum potassium and renal function; persistent dry cough risk.','Dry cough, dizziness, headache, hyperkalemia');
INSERT INTO "medicines" VALUES(77,'Loperamide','Loperamide','Antidiarrheal','Short-term diarrhea symptom relief','Capsule','2 mg','Avoid self-treatment of some bloody/high-fever diarrhea.','Constipation; dizziness');
INSERT INTO "medicines" VALUES(78,'Loratadine','Loratadine','Antihistamine','Allergic symptoms','Tablet','10 mg','Check interactions and liver/kidney conditions.','Headache; dry mouth');
INSERT INTO "medicines" VALUES(79,'Losartan','Losartan','ARB','High blood pressure','Tablet','50 mg','Pregnancy and kidney/potassium issues need advice.','Dizziness; high potassium');
INSERT INTO "medicines" VALUES(80,'Melatonin','Melatonin','Sleep-regulating hormone','Jet lag; selected sleep problems','Tablet','1-3 mg','Check age, medicines and conditions with a clinician/pharmacist.','Drowsiness; headache');
INSERT INTO "medicines" VALUES(81,'Memantine','Memantine HCl (Namenda)','NMDA Receptor Antagonist','Moderate-to-Severe Alzheimer''s Dementia, Vascular Dementia, Cognitive Decline','Tablet / Oral Solution','10 mg / 20 mg','Dose adjustment required in severe renal impairment; monitor cognition.','Dizziness, headache, confusion, constipation');
INSERT INTO "medicines" VALUES(82,'Mesalamine','Mesalamine (5-ASA)','Aminosalicylate / Anti-inflammatory','Ulcerative Colitis, Proctitis, Crohn''s Colitis maintenance','Delayed-Release Tablet / Enema','800 mg','Monitor renal function (creatinine) prior to and during therapy.','Abdominal cramps, headache, flatulence, nausea');
INSERT INTO "medicines" VALUES(83,'Metformin','Metformin','Biguanide','Type 2 diabetes','Tablet','500 mg','Kidney function and acute illness affect safety.','Nausea; diarrhea');
INSERT INTO "medicines" VALUES(84,'Methimazole','Methimazole','Antithyroid medicine','Hyperthyroidism','Tablet','5 mg','Requires clinician monitoring.','Rash; rare serious blood/liver effects');
INSERT INTO "medicines" VALUES(85,'Methotrexate','Methotrexate','DMARD / Immunosuppressant','Rheumatoid Arthritis, Severe Psoriasis, Psoriatic Arthritis','Tablet (Weekly dose)','7.5 mg - 15 mg (Once Weekly)','TAKEN ONCE WEEKLY ONLY (not daily); supplement with folic acid; liver/CBC tests.','Nausea, mouth sores, fatigue, elevated liver enzymes, hair thinning');
INSERT INTO "medicines" VALUES(86,'Methylphenidate','Methylphenidate (Ritalin / Concerta)','CNS Stimulant','ADHD (Attention Deficit Hyperactivity Disorder), Narcolepsy','Extended-Release Tablet','18 mg / 36 mg','Monitor blood pressure and heart rate; schedule II controlled substance.','Decreased appetite, insomnia, dry mouth, tachycardia');
INSERT INTO "medicines" VALUES(87,'Metoprolol','Metoprolol','Beta blocker','Selected heart-rate/blood-pressure conditions','Tablet','25 mg','Do not stop abruptly; asthma/low pulse require caution.','Slow heartbeat; dizziness');
INSERT INTO "medicines" VALUES(88,'Metronidazole','Metronidazole (Flagyl)','Nitroimidazole Antibacterial / Antiprotozoal','Bacterial Vaginosis, C. difficile infection, Giardiasis, Trichomoniasis, Dental abscess','Tablet','400 mg / 500 mg','STRICTLY NO ALCOHOL during and 48h after therapy (severe disulfiram reaction).','Metallic taste, dark urine, nausea, headache');
INSERT INTO "medicines" VALUES(89,'Montelukast','Montelukast Sodium (Singulair)','Leukotriene Receptor Antagonist','Asthma prophylaxis, Allergic Rhinitis, Exercise-induced bronchoconstriction','Chewable Tablet / Tablet','10 mg','Monitor for neuropsychiatric events (mood changes, vivid dreams).','Headache, abdominal pain, dream abnormalities');
INSERT INTO "medicines" VALUES(90,'Naproxen','Naproxen','NSAID','Pain and inflammation','Tablet','250 mg','GI, kidney and cardiovascular risks require advice.','Stomach upset; bleeding');
INSERT INTO "medicines" VALUES(91,'Nitrofurantoin','Nitrofurantoin','Antibiotic','Selected uncomplicated urinary infections','Capsule','100 mg','Prescription medicine; diagnosis and kidney function matter.','Nausea; rare lung/liver effects');
INSERT INTO "medicines" VALUES(92,'Nitroglycerin','Nitroglycerin','Vasodilator / Nitrate','Acute Angina Pectoris, Angina Prophylaxis','Sublingual Tablet / Spray','0.4 mg','Contraindicated with PDE-5 inhibitors (e.g. Sildenafil) due to severe hypotension.','Throbbing headache, hypotension, facial flushing');
INSERT INTO "medicines" VALUES(93,'Octreotide','Octreotide Acetate (Sandostatin)','Somatostatin Analog','Zollinger-Ellison Syndrome gastrinoma, Acute bleeding esophageal varices, Acromegaly','Subcutaneous / IV Injection','100 mcg / 500 mcg','Monitor gallbladder via ultrasound (risk of gallstones on prolonged therapy).','Abdominal pain, diarrhea, gallstones, flatulence');
INSERT INTO "medicines" VALUES(94,'Omeprazole','Omeprazole','Proton-pump inhibitor','Acid-related disorders','Capsule','20 mg','Long-term use should be medically reviewed.','Headache; GI symptoms');
INSERT INTO "medicines" VALUES(95,'Ondansetron','Ondansetron','Antiemetic','Nausea and vomiting','Tablet','4 mg','Heart-rhythm conditions/interactions may matter.','Headache; constipation');
INSERT INTO "medicines" VALUES(96,'Oral Rehydration Salts','ORS','Rehydration solution','Dehydration/fluid loss','Powder','Standard sachet','Prepare exactly as package instructions state.','Nausea if taken too quickly');
INSERT INTO "medicines" VALUES(97,'Oxybutynin','Oxybutynin Chloride','Urinary Antispasmodic / Anticholinergic','Overactive Bladder, Urinary Urgency and Frequency, Neurogenic Bladder','Tablet','5 mg','May exacerbate glaucoma, gastric retention, or urinary obstruction.','Dry mouth, constipation, blurred vision, drowsiness');
INSERT INTO "medicines" VALUES(98,'Pantoprazole','Pantoprazole','Proton Pump Inhibitor (PPI)','GERD, Erosive Esophagitis, Zollinger-Ellison Syndrome, Peptic Ulcer','Delayed-Release Tablet','40 mg','Long term use: risk of hypomagnesemia, B12 deficiency, bone fractures.','Headache, diarrhea, abdominal pain, flatulence');
INSERT INTO "medicines" VALUES(99,'Paracetamol','Acetaminophen','Analgesic/antipyretic','Pain and fever','Tablet','500 mg','Check total intake; overdose can injure liver.','Nausea; rash; liver injury in overdose');
INSERT INTO "medicines" VALUES(100,'Permethrin','Permethrin','Antiparasitic','Scabies; lice','Cream/lotion','5% cream','Use exactly as directed.','Skin irritation; itching');
INSERT INTO "medicines" VALUES(101,'Pirfenidone','Pirfenidone (Esbriet)','Antifibrotic Agent','Idiopathic Pulmonary Fibrosis (IPF) progression slowing','Capsule / Tablet','267 mg / 801 mg','Take with food to reduce nausea; monitor monthly liver function tests; avoid direct sunlight.','Nausea, skin rash/photosensitivity, fatigue, loss of appetite');
INSERT INTO "medicines" VALUES(102,'Prednisolone','Prednisolone','Systemic Corticosteroid','Severe inflammatory flares, Autoimmune diseases, Bell''s Palsy, Lupus, Multiple Sclerosis','Tablet','5 mg / 20 mg','Take with meals; taper dose gradually; monitor blood glucose.','Fluid retention, insomnia, increased appetite');
INSERT INTO "medicines" VALUES(103,'Prednisone','Prednisone','Systemic Corticosteroid','Severe inflammatory flares, Autoimmune diseases, Asthma, Lupus, Bell''s Palsy','Tablet','20 mg','Taper slowly if used > 2 weeks; monitor blood glucose, BP, bone density.','Insomnia, mood swings, increased appetite, fluid retention');
INSERT INTO "medicines" VALUES(104,'Pregabalin','Pregabalin','Neuropathic pain medicine','Neuropathic pain','Capsule','75 mg','May cause dizziness/sedation; professional supervision.','Dizziness; drowsiness');
INSERT INTO "medicines" VALUES(105,'Pyridostigmine','Pyridostigmine Bromide (Mestinon)','Cholinesterase Inhibitor','Myasthenia Gravis muscle weakness, Postural Orthostatic Tachycardia','Tablet / Syrup','60 mg','Watch for cholinergic crisis (excessive salivation, abdominal cramps, bradycardia).','Abdominal cramps, diarrhea, increased salivation, muscle twitching');
INSERT INTO "medicines" VALUES(106,'Quetiapine','Quetiapine (Seroquel)','Atypical Antipsychotic','Bipolar Disorder, Schizophrenia, Major Depression adjunct','Tablet','50 mg','Monitor for metabolic syndrome, lipid profile, and fasting glucose.','Sedation, weight gain, dry mouth, dizziness, constipation');
INSERT INTO "medicines" VALUES(107,'Rifampicin','Rifampicin','Antibiotic','Tuberculosis treatment combination','Capsule','600 mg','TB treatment must follow specialist/public-health regimen.','Orange body fluids; liver effects');
INSERT INTO "medicines" VALUES(108,'Rivaroxaban','Rivaroxaban (Xarelto)','Direct Oral Anticoagulant (DOAC)','DVT/PE treatment and secondary prevention, Nonvalvular Atrial Fibrillation','Tablet','20 mg','Take 15mg and 20mg doses WITH food for proper absorption; bleeding hazard.','Bleeding, bruising, abdominal pain');
INSERT INTO "medicines" VALUES(109,'Rosuvastatin','Rosuvastatin','Statin','High cholesterol','Tablet','10 mg','Interactions, pregnancy and liver conditions require review.','Muscle aches; headache');
INSERT INTO "medicines" VALUES(110,'Sacubitril/Valsartan (Entresto)','Sacubitril/Valsartan (ARNI)','Angiotensin Receptor-Neprilysin Inhibitor','Heart Failure with reduced ejection fraction (HFrEF), Cardiovascular death reduction','Tablet','24/26 mg / 49/51 mg / 97/103 mg','Mandatory 36-hour washout period when switching from an ACE inhibitor to prevent severe angioedema.','Hypotension, hyperkalemia, dizziness, renal impairment');
INSERT INTO "medicines" VALUES(111,'Salbutamol','Salbutamol','Bronchodilator','Asthma/bronchospasm symptoms','Inhaler','100 mcg/actuation','Use within clinician-approved asthma plan.','Tremor; fast heartbeat');
INSERT INTO "medicines" VALUES(112,'Semaglutide','Semaglutide (Ozempic / Wegovy)','GLP-1 Receptor Agonist','Type 2 Diabetes, Chronic Weight Management, Cardiovascular risk reduction','Subcutaneous Injection / Tablet','0.5 mg / 1 mg','Contraindicated in personal/family history of medullary thyroid carcinoma.','Nausea, vomiting, diarrhea, constipation, decreased appetite');
INSERT INTO "medicines" VALUES(113,'Sertraline','Sertraline','SSRI','Depression; anxiety','Tablet','50 mg','Prescription medicine; supervision and monitoring are required.','Nausea; sleep changes');
INSERT INTO "medicines" VALUES(114,'Sevelamer','Sevelamer Carbonate (Renvela)','Non-Calcium Phosphate Binder','Control of serum phosphorus in Chronic Kidney Disease (CKD) on dialysis','Tablet / Powder for Oral Suspension','800 mg','Must be taken WITH meals to bind dietary phosphate; do not chew tablets.','Nausea, vomiting, constipation, diarrhea, flatulence');
INSERT INTO "medicines" VALUES(115,'Sildenafil','Sildenafil Citrate','PDE-5 Inhibitor / Vasodilator','Erectile Dysfunction, Pulmonary Arterial Hypertension (Revatio)','Tablet','50 mg / 20 mg','ABSOLUTELY CONTRAINDICATED with Nitrates (severe fatal hypotension risk).','Headache, facial flushing, nasal congestion, blue-tinted vision');
INSERT INTO "medicines" VALUES(116,'Simethicone','Simethicone','Antiflatulent','Gas and bloating','Tablet','80 mg','Persistent symptoms need assessment.','Mild GI symptoms');
INSERT INTO "medicines" VALUES(117,'Sodium Bicarbonate','Sodium Bicarbonate','Alkalinizing Agent / Renal Buffer','Metabolic Acidosis in Chronic Kidney Disease, Uric acid kidney stone dissolution','Tablet','650 mg','Monitor serum sodium, potassium, and blood pressure (adds dietary sodium load).','Abdominal distension, belching, fluid retention, mild alkalosis');
INSERT INTO "medicines" VALUES(118,'Spironolactone','Spironolactone','Potassium-sparing diuretic','Selected fluid retention','Tablet','25 mg','High potassium and kidney problems are important.','High potassium; dizziness');
INSERT INTO "medicines" VALUES(119,'Sucralfate','Sucralfate','Mucosal Protectant','Active Duodenal Ulcers, Stress Ulcer Prophylaxis, Gastric Erosion','Tablet / Suspension','1 g','Take on an empty stomach 1 hour before meals; separate from other drugs.','Constipation, dry mouth, indigestion');
INSERT INTO "medicines" VALUES(120,'Sumatriptan','Sumatriptan','5-HT1 Receptor Agonist (Triptan)','Acute Migraine with or without aura, Cluster Headache','Tablet / Nasal Spray','50 mg','Contraindicated in ischemic heart disease, uncontrolled hypertension.','Chest tightness, flushing, tingling, dizziness');
INSERT INTO "medicines" VALUES(121,'Tacrolimus','Tacrolimus (Prograf)','Calcineurin Inhibitor / Immunosuppressant','Kidney/Organ Transplant rejection prophylaxis, Refractory Nephrotic Syndrome, Lupus Nephritis','Capsule','1 mg / 5 mg','Therapeutic drug monitoring of whole blood trough levels mandatory; nephrotoxicity and neurotoxicity risk.','Tremor, nephrotoxicity, hypertension, hyperkalemia, hyperglycemia');
INSERT INTO "medicines" VALUES(122,'Tamsulosin','Tamsulosin','Alpha-1 blocker','Prostate-related urinary symptoms','Capsule','0.4 mg','May lower blood pressure.','Dizziness; low blood pressure');
INSERT INTO "medicines" VALUES(123,'Terbinafine','Terbinafine','Antifungal','Fungal skin infections','Cream/tablet','1% cream','Oral therapy needs medical assessment.','Skin irritation; GI symptoms');
INSERT INTO "medicines" VALUES(124,'Teriparatide','Teriparatide (Forteo)','Recombinant Human Parathyroid Hormone (1-34) / Anabolic Bone Builder','Severe Osteoporosis with high fracture risk, Non-union bone fractures','Subcutaneous Injection Pen','20 mcg/dose daily','Black box warning for osteosarcoma (treatment duration capped at 24 months total in a lifetime).','Hypercalcemia, dizziness, leg cramps, nausea');
INSERT INTO "medicines" VALUES(125,'Thiamine (Vitamin B1)','Thiamine HCl','Essential Vitamin / Neuroprotectant','Wernicke-Korsakoff Amnesia syndrome, Beriberi, Alcohol-related neurotoxicity','Tablet / IV Injection','100 mg / 500 mg IV','Must be administered BEFORE any IV glucose in malnourished patients to prevent acute Wernicke encephalopathy.','Rare allergic reaction, mild warmth sensation');
INSERT INTO "medicines" VALUES(126,'Timolol','Timolol','Beta blocker eye drop','Glaucoma','Eye drops','0.5%','Can affect heart rate/breathing; eye-care supervision.','Eye irritation; slow heartbeat');
INSERT INTO "medicines" VALUES(127,'Tiotropium','Tiotropium Bromide (Spiriva)','Long-Acting Anticholinergic (LAMA)','COPD maintenance, Severe Persistent Asthma','Inhalation Powder / Mist','18 mcg','Not for acute bronchospasm rescue; rinse mouth to prevent dry throat.','Dry mouth, upper respiratory tract infection, cough, constipation');
INSERT INTO "medicines" VALUES(128,'Ursodeoxycholic Acid','Ursodiol (UDCA)','Bile Acid Derivative','Primary Biliary Cholangitis, Gallstone Dissolution, Cholestasis','Capsule','300 mg','Periodic liver enzyme monitoring required.','Diarrhea, dizziness, back pain, nausea');
INSERT INTO "medicines" VALUES(129,'Vitamin B12','Cyanocobalamin','Vitamin supplement','B12 deficiency','Tablet','1000 mcg','Underlying deficiency causes may need evaluation.','Occasional skin reaction');
INSERT INTO "medicines" VALUES(130,'Vitamin D3','Cholecalciferol','Vitamin supplement','Vitamin D deficiency','Tablet','1000 IU','Excessive intake can cause high calcium.','High calcium if excessive');
INSERT INTO "medicines" VALUES(131,'Warfarin','Warfarin Sodium','Vitamin K Antagonist Anticoagulant','Venous Thromboembolism, Atrial Fibrillation, Mechanical heart valves','Tablet','5 mg','Regular INR blood monitoring mandatory; strict Vitamin K intake consistency.','Bleeding, bruising, skin necrosis (rare)');
INSERT INTO "medicines" VALUES(132,'Dapagliflozin','Dapagliflozin Propanediol','Endocrinology / SGLT2 Inhibitor','Type 2 diabetes mellitus, heart failure with reduced ejection fraction, CKD','Film-Coated Tablet','5mg, 10mg','Maintain adequate daily fluid intake; monitor for genital mycotic infections','Polyuria, mild dehydration, genital yeast infection');
INSERT INTO "medicines" VALUES(133,'Sacubitril/Valsartan','Sacubitril + Valsartan','Cardiovascular / ARNI','Chronic heart failure with reduced ejection fraction (HFrEF NYHA Class II-IV)','Film-Coated Tablet','24/26mg, 49/51mg, 97/103mg','Do not take within 36 hours of an ACE inhibitor; check blood pressure and potassium','Hypotension, hyperkalemia, renal impairment');
INSERT INTO "medicines" VALUES(134,'Sitagliptin','Sitagliptin Phosphate','Endocrinology / DPP-4 Inhibitor','Type 2 diabetes mellitus glycemic improvement','Film-Coated Tablet','25mg, 50mg, 100mg','Adjust dose for moderate-to-severe renal impairment; report severe persistent abdominal pain','Upper respiratory tract infection, headache, nasopharyngitis');
INSERT INTO "medicines" VALUES(135,'Ivabradine','Ivabradine Hydrochloride','Cardiovascular / Hyperpolarization-Activated Channel Blocker','Symptomatic chronic stable angina, chronic heart failure with resting HR >= 70 bpm','Film-Coated Tablet','5mg, 7.5mg','Take twice daily with meals; monitor resting heart rate regularly','Luminous visual phenomena (phosphenes), bradycardia');
INSERT INTO "medicines" VALUES(136,'Spiramycin','Spiramycin','Antibacterial / Macrolide','Toxoplasmosis in pregnancy, cryptosporidiosis, respiratory and odontogenic infections','Film-Coated Tablet','1.5 MIU, 3.0 MIU','Complete prescribed treatment duration; safe during first trimester for toxoplasmosis','Nausea, vomiting, diarrhea, abdominal discomfort');
INSERT INTO "medicines" VALUES(137,'Tizanidine','Tizanidine Hydrochloride','Neurology / Alpha-2 Adrenergic Agonist Muscle Relaxant','Acute painful musculoskeletal spasms, chronic spasticity associated with neurological disorders','Tablet','2mg, 4mg','Take consistently with or without food; monitor for hypotension and sedation','Dry mouth, somnolence, dizziness, asthenia');
INSERT INTO "medicines" VALUES(138,'Ropinirole','Ropinirole Hydrochloride','Neurology / Non-Ergot Dopamine Agonist','Idiopathic Parkinson disease, moderate-to-severe primary Restless Legs Syndrome','Film-Coated Tablet','0.25mg, 1mg, 2mg, 5mg','Take with meals to reduce nausea; monitor for sudden sleep attacks or impulse control disorders','Nausea, somnolence, dizziness, hallucinations');
INSERT INTO "medicines" VALUES(139,'Pramipexole','Pramipexole Dihydrochloride','Neurology / Non-Ergot Dopamine Agonist','Signs and symptoms of idiopathic Parkinson disease, Restless Legs Syndrome','Tablet','0.125mg, 0.25mg, 1.0mg','Titrate slowly; reduce dose in renal impairment; beware of postural hypotension','Nausea, dyskinesia, dizziness, peripheral edema');
INSERT INTO "medicines" VALUES(140,'Venlafaxine','Venlafaxine Hydrochloride','Psychiatry / SNRI','Major depressive disorder, generalized anxiety disorder, social anxiety disorder','Extended-Release Capsule','37.5mg, 75mg, 150mg','Do not crush or chew ER capsules; monitor blood pressure and pulse','Nausea, dry mouth, sweating, hypertension at higher doses');
INSERT INTO "medicines" VALUES(141,'Mirtazapine','Mirtazapine','Psychiatry / NaSSA Antidepressant','Major depressive disorder in adults','Tablet / Orally Disintegrating','15mg, 30mg, 45mg','Take at bedtime due to sedating effect; stimulates appetite','Somnolence, increased appetite, weight gain, dry mouth');
INSERT INTO "medicines" VALUES(142,'Aripiprazole','Aripiprazole','Psychiatry / Atypical Antipsychotic (Dopamine Partial Agonist)','Schizophrenia, bipolar I disorder manic episodes, adjunctive for MDD, Tourette disorder','Tablet','5mg, 10mg, 15mg','Take once daily without regard to meals; monitor for akathisia (motor restlessness)','Akathisia, headache, nausea, insomnia');
INSERT INTO "medicines" VALUES(143,'Topiramate','Topiramate','Neurology / Antiepileptic & Migraine Preventive','Prophylaxis of migraine headache, initial monotherapy or adjunctive for epilepsy','Film-Coated Tablet','25mg, 50mg, 100mg','Maintain high fluid intake to prevent kidney stones; avoid abrupt withdrawal','Paresthesia (tingling in fingers/toes), anorexia, cognitive slowing, taste alteration');
INSERT INTO "medicines" VALUES(144,'Lamotrigine','Lamotrigine','Neurology / Antiepileptic & Mood Stabilizer','Epilepsy adjunctive and monotherapy, maintenance treatment of Bipolar I disorder','Dispersible / Scored Tablet','25mg, 50mg, 100mg','Report any skin rash immediately (risk of serious dermatologic reactions / SJS)','Skin rash, dizziness, headache, diplopia');
INSERT INTO "medicines" VALUES(145,'Budesonide (Oral)','Budesonide','Gastrointestinal / Corticosteroid with High First-Pass Metabolism','Induction of remission in mild-to-moderate active Crohn disease involving the ileum and/or ascending colon','Extended-Release Capsule','3mg','Swallow whole without opening or chewing; lower systemic side effects than prednisone','Headache, respiratory infection, nausea, dyspepsia');
INSERT INTO "medicines" VALUES(146,'Rifaximin','Rifaximin','Gastrointestinal / Non-Systemic Antibiotic','Reduction in risk of overt hepatic encephalopathy recurrence, IBS with diarrhea, traveler diarrhea','Film-Coated Tablet','200mg, 550mg','Minimal systemic absorption (< 0.4%); can be taken with or without food','Nausea, flatulence, abdominal pain, headache');
INSERT INTO "medicines" VALUES(147,'Liraglutide','Liraglutide','Endocrinology / GLP-1 Receptor Agonist','Type 2 diabetes mellitus, chronic weight management adjunct in obesity','Subcutaneous Injection Pen','6mg/mL (0.6mg, 1.2mg, 1.8mg, 3.0mg)','Administer once daily any time of day independent of meals; store unopened in refrigerator','Nausea, diarrhea, decreased appetite, vomiting');
INSERT INTO "medicines" VALUES(148,'Tirzepatide','Tirzepatide','Endocrinology / Dual GIP & GLP-1 Receptor Agonist','Glycemic control in type 2 diabetes mellitus, chronic weight management in adults','Single-Dose Pen (Subcutaneous)','2.5mg, 5mg, 7.5mg, 10mg, 12.5mg, 15mg','Administer once weekly subcutaneously into abdomen, thigh, or upper arm','Nausea, diarrhea, decreased appetite, vomiting, constipation');
INSERT INTO "medicines" VALUES(149,'Brimonidine Tartrate','Brimonidine Tartrate 0.2%','Ophthalmology / Alpha-2 Adrenergic Agonist','Lowering intraocular pressure in patients with open-angle glaucoma or ocular hypertension','Ophthalmic Solution Drops','5mL, 10mL bottle','Remove soft contact lenses before instilling; wait 15 min before reinserting','Ocular hyperemia, burning/stinging, foreign body sensation');
INSERT INTO "medicines" VALUES(150,'Dorzolamide','Dorzolamide Hydrochloride 2%','Ophthalmology / Carbonic Anhydrase Inhibitor','Elevated intraocular pressure in open-angle glaucoma and pseudoexfoliative glaucoma','Ophthalmic Solution Drops','5mL, 10mL bottle','Avoid touching dropper tip to eye; space 10 minutes apart from other eye drops','Bitter taste in mouth, ocular burning, blurred vision');
INSERT INTO "medicines" VALUES(151,'Clindamycin (Topical 1%)','Clindamycin Phosphate 1%','Dermatology / Lincosamide Antibiotic','Inflammatory acne vulgaris with papules and pustules','Topical Gel / Lotion','30g, 60g tube','Wash affected skin before applying a thin film twice daily; avoid eye contact','Dry skin, erythema, peeling, burning');
INSERT INTO "medicines" VALUES(152,'Penciclovir (Topical 1%)','Penciclovir 1%','Dermatology / Antiviral Nucleoside Analogue','Recurrent herpes labialis (cold sores) on lips and face in adults','Topical Cream 1%','2g, 5g tube','Apply every 2 hours during waking hours for 4 days starting at first prodromal sign','Mild erythema, transient numbness, local irritation');
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'Patient',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
, phone TEXT DEFAULT '', age INTEGER DEFAULT 0, gender TEXT DEFAULT 'Not Specified', blood_group TEXT DEFAULT 'Unknown', city TEXT DEFAULT '', medical_notes TEXT DEFAULT '');
DELETE FROM "sqlite_sequence";
INSERT INTO "sqlite_sequence" VALUES('users',14);
INSERT INTO "sqlite_sequence" VALUES('email_logs',14);
INSERT INTO "sqlite_sequence" VALUES('activity_logs',38);
INSERT INTO "sqlite_sequence" VALUES('appointments',7);
INSERT INTO "sqlite_sequence" VALUES('conditions',182);
INSERT INTO "sqlite_sequence" VALUES('medicines',152);
INSERT INTO "sqlite_sequence" VALUES('doctors',14);
COMMIT;
