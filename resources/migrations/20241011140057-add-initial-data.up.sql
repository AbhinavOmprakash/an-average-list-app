-- Create the doctors table
CREATE TABLE doctors (
    id serial PRIMARY KEY
    , name varchar(255) NOT NULL
    , specialty varchar(255)
);

-- Create the patients table
CREATE TABLE patients (
    id serial PRIMARY KEY
    , name varchar(255) NOT NULL
    , age int
);

-- Create the doctors_patients join table to establish the many-to-many relationship
CREATE TABLE doctors_patients (
    doctor_id int NOT NULL
    , patient_id int NOT NULL
    , PRIMARY KEY (doctor_id , patient_id)
    , FOREIGN KEY (doctor_id) REFERENCES doctors (id) ON DELETE CASCADE
    , FOREIGN KEY (patient_id) REFERENCES patients (id) ON DELETE CASCADE
);

-- Create the consultations table with one-to-one relationships to doctor and patient
CREATE TABLE consultations (
    id serial PRIMARY KEY
    , doctor_id int NOT NULL
    , patient_id int NOT NULL
    , consultation_date timestamp NOT NULL
    , notes text
    , FOREIGN KEY (doctor_id) REFERENCES doctors (id) ON DELETE CASCADE
    , FOREIGN KEY (patient_id) REFERENCES patients (id) ON DELETE CASCADE
);

-- seed data

-- courtesy of chatgpt
INSERT INTO doctors (name, specialty) VALUES 
('John Smith', 'Cardiology'),
('Emily Taylor', 'Pediatrics'),
('Michael Brown', 'Orthopedics'),
('Sarah Johnson', 'Dermatology'),
('David Lee', 'Neurology'),
('Anna Davis', 'General Surgery'),
('Christopher Wilson', 'Psychiatry'),
('Jessica White', 'Oncology'),
('William Harris', 'Endocrinology'),
('Susan Clark', 'Family Medicine');


-- Seed the patients table with 100 rows
INSERT INTO patients (name , age)
    VALUES ('Alice Johnson' , 34)
    , ('Mohammed Ali' , 45)
    , ('Ling Zhang' , 29)
    , ('Carlos Mendes' , 51)
    , ('Amina Hassan' , 60)
    , ('Anita Desai' , 28)
    , ('Takashi Yamada' , 39)
    , ('Priya Nair' , 50)
    , ('Jamal Williams' , 31)
    , ('Emma Clarke' , 42)
    , ('Daniel Kim' , 27)
    , ('Sara Abdi' , 63)
    , ('Miguel Gonzalez' , 46)
    , ('Fatima Rahman' , 40)
    , ('Lucas Perez' , 22)
    , ('Sofia Rossi' , 54)
    , ('Adrian Chen' , 36)
    , ('Mariam Salem' , 33)
    , ('Diego Fernandez' , 58)
    , ('Lila Patel' , 30)
    , ('Henry Nguyen' , 48)
    , ('Luna Martinez' , 43)
    , ('Tariq Khan' , 37)
    , ('Olivia Lee' , 52)
    , ('Rajesh Gupta' , 25)
    , ('Nia Washington' , 47)
    , ('Hassan Raza' , 55)
    , ('Nina Petrova' , 41)
    , ('Omar Bouzid' , 26)
    , ('Sophie Anderson' , 38)
    , ('Ibrahim Dada' , 64)
    , ('Viktor Ivanov' , 35)
    , ('Chen Wei' , 49)
    , ('Elena Garcia' , 53)
    , ('Akira Saito' , 57)
    , ('Rana Malik' , 34)
    , ('Daniel O Connor' , 56)
    , ('Jorge Santos' , 44)
    , ('Rania Aziz' , 62)
    , ('Gabriel Ortiz' , 23)
    , ('Leah Thompson' , 24)
    , ('Kiran Mehta' , 31)
    , ('Naomi Jackson' , 59)
    , ('Aaron Singh' , 30)
    , ('Elif Kaya' , 50)
    , ('David Harris' , 28)
    , ('Hana Yamamoto' , 33)
    , ('Amara Bello' , 29)
    , ('Vincent Franco' , 27)
    , ('Lucia Rossi' , 32)
    , ('Amir Farouk' , 45)
    , ('Maya Thomas' , 26)
    , ('James Walker' , 39)
    , ('Ahmed Saleh' , 61)
    , ('Ming Wu' , 46)
    , ('Jessica Torres' , 22)
    , ('Elias Ibrahim' , 41)
    , ('Hala Khalil' , 37)
    , ('Samuel Cohen' , 55)
    , ('Paola Herrera' , 30)
    , ('Yasmin Adnan' , 43)
    , ('Ryan Murphy' , 28)
    , ('Yuki Morimoto' , 49)
    , ('Esther Owusu' , 53)
    , ('Li Na' , 25)
    , ('Sean White' , 36)
    , ('Nadia Khan' , 58)
    , ('Fernando Oliveira' , 47)
    , ('Aysha Said' , 51)
    , ('Louis Dupont' , 38)
    , ('Zara Ali' , 48)
    , ('Benedict Cheng' , 27)
    , ('Emily Graham' , 35)
    , ('Andres Cruz' , 60)
    , ('Sana Qureshi' , 29)
    , ('Thiago Silva' , 57)
    , ('Camila Fernandez' , 44)
    , ('Josiah Mwangi' , 39)
    , ('Rahul Sharma' , 56)
    , ('Sophia Lim' , 24)
    , ('Liam Kelly' , 63)
    , ('Carla Russo' , 40)
    , ('Oluwaseun Adeyemi' , 50)
    , ('Isabella Moreno' , 42)
    , ('Victor Huang' , 52)
    , ('Selena Gomez' , 23)
    , ('Rohit Joshi' , 34)
    , ('Isabel Reyes' , 54)
    , ('Aiden Lee' , 32)
    , ('Catherine Mills' , 25)
    , ('Abdullah Al-Farsi' , 41)
    , ('Tina Pham' , 33)
    , ('Santiago Torres' , 47)
    , ('Hector Ramirez' , 31)
    , ('Shivani Nanda' , 30)
    , ('Frederick Asante' , 43)
    , ('Alexis Brown' , 37)
    , ('Jun Park' , 29)
    , ('Selena Wang' , 26)
    , ('Marcus Evans' , 45)
    , ('Dina Ali' , 42)
    , ('Raj Patel' , 51)
    , ('Beatriz Sousa' , 48);

-- Seed the doctors_patients join table with random assignments
INSERT INTO doctors_patients (
    doctor_id
    , patient_id)
SELECT
    doctor_id
    , patient_id
FROM (
    SELECT
        doctor_id
        , patient_id
    FROM (
        SELECT
            d.id AS doctor_id
            , p.id AS patient_id
            , ROW_NUMBER() OVER (PARTITION BY p.id ORDER BY RANDOM()) AS row_num
        FROM
            doctors d
            , patients p) subquery
    WHERE
        row_num <= 3 -- Each patient will be linked to up to 3 doctors
) AS assignment;

-- consultations
INSERT INTO consultations (
    doctor_id
    , patient_id
    , consultation_date
    , notes)
SELECT
    doctor_id
    , patient_id
    , datetime (julianday ('now') - abs(random() % 365) , -- random date within the last year
    (abs(random() % 86400)) || ' seconds' -- random time within the day
) AS random_timestamp
    , CASE ABS(RANDOM() % 10)
    WHEN 0 THEN
        'Discussed ongoing symptoms and treatment plan.'
    WHEN 1 THEN
        'Reviewed test results and adjusted medication.'
    WHEN 2 THEN
        'Patient reports improvement in symptoms.'
    WHEN 3 THEN
        'Explored alternative therapies for pain management.'
    WHEN 4 THEN
        'Addressed patient concerns about side effects.'
    WHEN 5 THEN
        'Provided guidance on diet and exercise.'
    WHEN 6 THEN
        'Scheduled follow-up appointment in two weeks.'
    WHEN 7 THEN
        'Patient requested additional information on diagnosis.'
    WHEN 8 THEN
        'Discussed options for surgical intervention.'
    WHEN 9 THEN
        'Addressed mental health and provided resources.'
    END AS notes
FROM
    doctors_patients
