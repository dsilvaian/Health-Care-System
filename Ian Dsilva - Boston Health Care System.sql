/*Drop Database Tables, Index, Procedure, trigger*/
DROP TABLE Payment;
DROP TABLE Invoice;
DROP TABLE Prescription;
DROP TABLE Medicine;
DROP TABLE Diagnosis;
DROP TABLE Insurance;
DROP TABLE Paycheck;
DROP TABLE Appointment_history;
DROP TABLE Nurse;
DROP TABLE Appointment;
DROP TABLE Doctor;
DROP TABLE Employee;
DROP TABLE Paitent;

/*
DROP INDEX nurse_employee_idx;
DROP INDEX doctor_employee_idx;
DROP INDEX paycheck_employee_idx;
DROP INDEX appoinment_doctor_idx;
DROP INDEX appoinment_paitent_idx;
DROP INDEX insurance_patient_idx;
DROP INDEX invoice_patient_idx;
DROP INDEX invoice_diagnosis_idx;
DROP INDEX invoice_prescription_idx;
DROP INDEX payment_invoice_idx;
DROP INDEX prescription_medicine_idx;

DROP TRIGGER app_history_track;
*/

DROP PROCEDURE add_new_paitent;
DROP PROCEDURE add_new_employee;
DROP PROCEDURE add_paitent_diagnosis;


/*Intialize Database Tables*/


CREATE TABLE Paitent (
    p_id DECIMAL(12) NOT NULL PRIMARY KEY,
    p_name VARCHAR(32) NOT NULL,
    gender VARCHAR(8) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone DECIMAL(32) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(32) NOT NULL,
    zip DECIMAL(32) NOT NULL
);

CREATE TABLE Employee (
    employee_id DECIMAL(12) NOT NULL PRIMARY KEY,
    gender VARCHAR(8) NOT NULL,
    date_of_birth DATE NOT NULL,
    ssn VARCHAR(32) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(32) NOT NULL,
    zip DECIMAL(32) NOT NULL
);

CREATE TABLE Nurse(
    nurse_id DECIMAL(12) NOT NULL PRIMARY KEY,
    nurse_name VARCHAR(32) NOT NULL,
    employee_id DECIMAL(12) NOT NULL,
    FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Doctor(
    d_id DECIMAL(12) NOT NULL PRIMARY KEY,
    d_name VARCHAR(32) NOT NULL,
    employee_id DECIMAL(12) NOT NULL,
    FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Appointment (
    app_id DECIMAL(12) NOT NULL PRIMARY KEY,
    p_id DECIMAL(12),
    app_date_time TIMESTAMP NOT NULL,
    d_id DECIMAL(12) NOT NULL,
    FOREIGN KEY(p_id) REFERENCES Paitent(p_id),
    FOREIGN KEY(d_id) REFERENCES Doctor(d_id)
);

CREATE TABLE Paycheck (
    check_num  DECIMAL(12) NOT NULL PRIMARY KEY,
    employee_id DECIMAL(12) NOT NULL,
    salary DECIMAL(12) NOT NULL,
    bonus DECIMAL(12),
    FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Insurance (
    inscom_id DECIMAL(12) NOT NULL PRIMARY KEY,
    p_id DECIMAL(12) NOT NULL,
    inscom_name VARCHAR(255) NOT NULL, 
    category_ins VARCHAR(255) NOT NULL, 
    address VARCHAR(255) NOT NULL, 
    phone DECIMAL(32) NOT NULL,
    city VARCHAR(32) NOT NULL,
    zip DECIMAL(32) NOT NULL,
    FOREIGN KEY(p_id) REFERENCES Paitent(p_id)
);

CREATE TABLE Diagnosis (
    diag_id DECIMAL(12) NOT NULL PRIMARY KEY,
    diag_category VARCHAR(32) NOT NULL
);

CREATE TABLE Medicine (
    med_id DECIMAL(12) NOT NULL PRIMARY KEY,
    med_name VARCHAR(255) NOT NULL,
    med_price DECIMAL(32) NOT NULL,
    med_expirydate DATE NOT NULL
);

CREATE TABLE Prescription (
    pres_id DECIMAL(12) NOT NULL PRIMARY KEY,
    med_id DECIMAL(12) NOT NULL,
    med_quantity DECIMAL(32) NOT NULL,
    FOREIGN KEY(med_id) REFERENCES Medicine(med_id)
);

CREATE TABLE Invoice (
    inv_num DECIMAL(12) NOT NULL PRIMARY KEY,
    p_id DECIMAL(12) NOT NULL,
    diag_id DECIMAL(12) NOT NULL,
    pres_id DECIMAL(12) NOT NULL,
    amount DECIMAL(32) NOT NULL,
    FOREIGN KEY(p_id) REFERENCES Paitent(p_id),
    FOREIGN KEY(diag_id ) REFERENCES Diagnosis(diag_id ),
    FOREIGN KEY(pres_id) REFERENCES Prescription(pres_id)
);

CREATE TABLE Payment (
    pay_id DECIMAL(12) NOT NULL PRIMARY KEY,
    inv_num DECIMAL(12) NOT NULL,
    pay_method VARCHAR(32) NOT NULL,
    pay_date DATE NOT NULL,
    FOREIGN KEY(inv_num) REFERENCES Invoice(inv_num)
);


/*Indexing*/


CREATE UNIQUE INDEX nurse_employee_idx
ON Nurse(employee_id);

CREATE UNIQUE INDEX doctor_employee_idx
ON Doctor(employee_id);

CREATE UNIQUE INDEX paycheck_employee_idx
ON Paycheck(employee_id);

CREATE INDEX appoinment_doctor_idx
ON Appointment(d_id);

CREATE INDEX appoinment_paitent_idx
ON Appointment(p_id);

CREATE INDEX insurance_patient_idx
ON Insurance(p_id);

CREATE INDEX invoice_patient_idx
ON Invoice(p_id);

CREATE INDEX invoice_diagnosis_idx
ON Invoice(diag_id);

CREATE INDEX invoice_prescription_idx
ON Invoice(pres_id);

CREATE INDEX payment_invoice_idx
ON Payment(inv_num);

CREATE INDEX prescription_medicine_idx
ON Prescription(med_id);


/*Inserting Data*/

INSERT INTO Paitent VALUES (1, 'Jake', 'Male', CAST('28-Jul-1998' AS DATE), 6256357654, 'Harrison Street', 'Boston', 02134);
INSERT INTO Paitent VALUES (2, 'Sara', 'Female', CAST('13-Feb-2000' AS DATE), 8479832340, 'Clark Avenue', 'Boston', 02120);
INSERT INTO Paitent VALUES (3, 'Ken', 'Male', CAST('02-Jan-1968' AS DATE), 7567342732, 'Harvard Street', 'Boston', 02174);
INSERT INTO Paitent VALUES (4, 'Mike', 'Male', CAST('15-Nov-1973' AS DATE), 9234356742, 'Packard Street', 'Boston', 02152);
INSERT INTO Paitent VALUES (5, 'Rebecca', 'Female', CAST('27-Dec-1991' AS DATE), 8653487654, 'Fenway Avenue', 'Boston', 02764);

SELECT * FROM Paitent;

INSERT INTO Employee VALUES (201, 'Female', CAST('30-May-1974' AS DATE), 'ABCHE9871', 'Solitaire Avenue', 'Boston', 02315);
INSERT INTO Employee VALUES (202, 'Male', CAST('18-Sep-1961' AS DATE), 'BXCN87452', 'Brighton Avenue', 'Boston', 02456);
INSERT INTO Employee VALUES (203, 'Female', CAST('20-Aug-1991' AS DATE), 'GHRY23674', 'Kelly Street', 'Boston', 02341);
INSERT INTO Employee VALUES (204, 'Male', CAST('15-Nov-1988' AS DATE), 'OLKY23485', 'Back Bay', 'Boston', 02589);
INSERT INTO Employee VALUES (205, 'Female', CAST('31-Dec-1995' AS DATE), 'LOUI98571', 'Copley Street', 'Boston', 02785);
INSERT INTO Employee VALUES (206, 'Female', CAST('12-Dec-1987' AS DATE), 'MHFD98571', 'Keith Street', 'Boston', 02755);

SELECT * FROM Employee;

INSERT INTO Nurse VALUES(51, 'Martha', 206);
INSERT INTO Nurse VALUES(52, 'Jake', 204);
INSERT INTO Nurse VALUES(53, 'Jessica', 205);

SELECT * FROM Nurse;

INSERT INTO Doctor VALUES(151, 'Louis', 203);
INSERT INTO Doctor VALUES(152, 'Jacob', 202);
INSERT INTO Doctor VALUES(153, 'Alice', 201);

SELECT * FROM Doctor;

INSERT INTO Paycheck VALUES(801, 201, 80000, 1000);
INSERT INTO Paycheck VALUES(802, 202, 120000, 40000);
INSERT INTO Paycheck VALUES(803, 204, 10000, 2000);

SELECT * FROM Paycheck;

INSERT INTO Insurance VALUES(501, 2, 'Liberty Insurance', 'Health', 'Harvard Street', 8764536273, 'Boston', 02135);
INSERT INTO Insurance VALUES(502, 5, 'McMillen Insurance', 'Health', 'Kenmore', 7536543721, 'Boston', 02456);
INSERT INTO Insurance VALUES(503, 3, 'Liberty Insurance', 'Dental', 'Harvard Street', 8764536273, 'Boston', 02135);
INSERT INTO Insurance VALUES(504, 4, 'Lily Health Insurance', 'Health', 'Downtown Abbey', 9756438754, 'Boston', 02567);
INSERT INTO Insurance VALUES(505, 1, 'Ortho Insurance', 'Dental', 'Watertown Street', 8765648321, 'Boston', 045631);

SELECT * FROM Insurance;

INSERT INTO Diagnosis VALUES(301, 'Full body check-up');
INSERT INTO Diagnosis VALUES(302, 'Fever');
INSERT INTO Diagnosis VALUES(303, 'Kidney Transplant');

SELECT * FROM Diagnosis;

INSERT INTO Medicine VALUES(701, 'Paracetamol', 100, CAST('30-Dec-2023' AS DATE));
INSERT INTO Medicine VALUES(702, 'Bristol', 40, CAST('28-Aug-2024' AS DATE));
INSERT INTO Medicine VALUES(703, 'Crocin', 200, CAST('21-May-2024' AS DATE));
INSERT INTO Medicine VALUES(704, 'Hvoac', 500, CAST('30-June-2025' AS DATE));

SELECT * FROM Medicine;

INSERT INTO Prescription VALUES(401, 701, 6);
INSERT INTO Prescription VALUES(402, 702, 4);
INSERT INTO Prescription VALUES(403, 703, 14);
INSERT INTO Prescription VALUES(405, 704, 4);

SELECT * FROM Prescription;

INSERT INTO Invoice VALUES(601, 2, 301,402, 4000);
INSERT INTO Invoice VALUES(602, 4, 302,401, 500);
INSERT INTO Invoice VALUES(603, 5, 303, 403, 60000);
INSERT INTO Invoice VALUES(605, 4, 302, 405, 1000);

SELECT * FROM Invoice;

INSERT INTO Appointment VALUES(101, 2, timestamp '2022-12-20 08:30:00', 151);
INSERT INTO Appointment VALUES(102, 5, timestamp '2023-01-01 10:00:00', 151);
INSERT INTO Appointment VALUES(103, 1, timestamp '2022-12-20 16:30:00', 153);
INSERT INTO Appointment VALUES(104, 4, timestamp '2023-01-30 13:00:00', 152);
INSERT INTO Appointment VALUES(105, 3, timestamp '2023-02-12 11:30:00', 152);
INSERT INTO Appointment VALUES(107, 5, timestamp '2022-12-26 12:30:00', 151);
INSERT INTO Appointment VALUES(108, 4, timestamp '2022-12-26 13:30:00', 151);

SELECT * FROM Appointment;

INSERT INTO Payment VALUES(901, 601, 'Cash', CAST('20-Dec-2022' AS DATE));
INSERT INTO Payment VALUES(902, 602, 'Check', CAST('04-Feb-2023' AS DATE));
INSERT INTO Payment VALUES(903, 603, 'Insurance and Cash', CAST('12-Feb-2023' AS DATE));

SELECT * FROM Payment;

/*Procedures*/

CREATE OR REPLACE PROCEDURE add_new_paitent (
    p_id IN DECIMAL,
    p_name IN VARCHAR,
    gender IN VARCHAR,
    date_of_birth IN DATE,
    phone IN DECIMAL,
    address IN VARCHAR,
    city IN VARCHAR,
    zip IN DECIMAL,
    
    app_id DECIMAL,
    app_date_time IN DATE,
    d_id IN DECIMAL,
    
    inscom_id_argins IN DECIMAL,
    inscom_name_argins IN VARCHAR, 
    category_argins IN VARCHAR, 
    address_argins IN VARCHAR, 
    phone_argins IN DECIMAL,
    city_argins IN VARCHAR,
    zip_argins IN DECIMAL)
AS
BEGIN
    INSERT INTO Paitent (p_id, p_name, gender, date_of_birth, phone, address, city, zip)
    VALUES(p_id,  p_name, gender, date_of_birth, phone, address, city, zip);
    
    INSERT INTO Insurance (inscom_id, p_id, inscom_name,  category_ins, address, phone, city, zip)
    VALUES(inscom_id_argins,  p_id, inscom_name_argins,  category_argins,  address_argins, phone_argins, city_argins, zip_argins);
    
    INSERT INTO Appointment (app_id, p_id, app_date_time, d_id)
    VALUES(app_id, p_id, app_date_time, d_id);
END;
/

BEGIN
    add_new_paitent(6, 'Jacob', 'Male', CAST('20-Dec-1987' AS DATE), 8657439842, 'Holler Avenue', 'Boston', 01237, 
                    106, timestamp '2022-12-02 12:30:00', 153, 
                    506, 'McMillen Insurance', 'Health', 'Kenmore', 7536543721, 'Boston', 02456);
END;
/

SELECT *
FROM Paitent
JOIN Appointment ON Appointment.p_id = Paitent.p_id
JOIN Insurance ON Insurance.p_id = Paitent.p_id
WHERE Appointment.app_id = 106 AND Paitent.p_id = 6;

CREATE OR REPLACE PROCEDURE add_new_employee (
    employee_id IN DECIMAL,
    gender IN VARCHAR,
    date_of_birth IN DATE,
    ssn IN VARCHAR,
    address IN VARCHAR,
    city IN VARCHAR,
    zip IN DECIMAL,
    emp_name IN VARCHAR,
    emp_type IN VARCHAR)
AS
BEGIN
    INSERT INTO Employee (employee_id, gender, date_of_birth, ssn, address, city, zip)
    VALUES(employee_id, gender, date_of_birth, ssn, address, city, zip);    
    
    IF (emp_type = 'Nurse') THEN
        INSERT INTO Nurse (nurse_id, nurse_name, employee_id)
        VALUES(NVL((SELECT MAX(nurse_id)+1 FROM Nurse), 1), emp_name, employee_id);
    ELSE
       INSERT INTO Doctor (d_id, d_name,  employee_id)
        VALUES(NVL((SELECT MAX(d_id)+1 FROM Doctor), 1), emp_name,  employee_id);
    END IF;
END;
/

BEGIN 
    add_new_employee(207, 'Female', CAST('25-Dec-1990' AS DATE), 'HGFH7865', 
                    'Griggs Avenue', 'Boston', 02315, 'Katherine', 'Nurse');
END;
/

SELECT *
FROM Employee
JOIN Nurse ON Nurse.employee_id = Employee.employee_id
WHERE Nurse.employee_id = 207;

BEGIN 
    add_new_employee(208, 'Male', CAST('12-Nov-1968' AS DATE), 'FHSL8975', 
                    'Back Bay', 'Boston', 02212, 'Scott', 'Doctor');
END;
/

SELECT *
FROM Employee
JOIN Doctor ON Doctor.employee_id = Employee.employee_id
WHERE Doctor.employee_id = 208;

CREATE OR REPLACE PROCEDURE add_paitent_diagnosis (
    diag_id IN DECIMAL,
    diag_category IN VARCHAR,
    
    pres_id IN DECIMAL,
    med_id IN DECIMAL,
    med_quantity IN DECIMAL,
    
    inv_num IN DECIMAL,
    p_id IN DECIMAL,
    amount IN DECIMAL,
    
    pay_id IN DECIMAL,
    pay_method IN VARCHAR,
    pay_date IN DATE)
AS
BEGIN
    INSERT INTO Diagnosis(diag_id, diag_category)
    VALUES(diag_id, diag_category);
    
    INSERT INTO Prescription(pres_id, med_id, med_quantity)
    VALUES(pres_id, med_id, med_quantity);
    
    INSERT INTO Invoice(inv_num, p_id, diag_id, pres_id, amount)
    VALUES(inv_num, p_id, diag_id, pres_id, amount);
    
    INSERT INTO Payment(pay_id, inv_num, pay_method,  pay_date)
    VALUES(pay_id, inv_num, pay_method,  pay_date);
END;
/

BEGIN
    add_paitent_diagnosis(304, 'Spine Alignment', 404, 703, 14, 604, 6, 5000, 
                        904, 'Check',  CAST('25-Dec-2022' AS DATE));
END;
/

SELECT * 
FROM Invoice
JOIN Diagnosis ON Diagnosis.diag_id = Invoice.diag_id
JOIN Prescription ON Prescription.pres_id = Invoice.pres_id
JOIN Payment ON Payment.inv_num = Invoice.inv_num
WHERE Invoice.inv_num = 604 AND Diagnosis.diag_id = 304 AND Prescription.pres_id = 404 AND Payment.pay_id = 904;

/*Triggers*/


CREATE TABLE Appointment_history (
    cancellation_id DECIMAL(12) NOT NULL PRIMARY KEY,
    previous_app_date_time TIMESTAMP NOT NULL,
    new_app_date_time TIMESTAMP NOT NULL,
    app_id DECIMAL(12) NOT NULL,
    FOREIGN KEY(app_id) REFERENCES Appointment(app_id)
);

CREATE OR REPLACE TRIGGER app_history_track
BEFORE UPDATE OF app_date_time ON Appointment
FOR EACH ROW
BEGIN
    IF :OLD.app_date_time <> :NEW.app_date_time THEN
        INSERT INTO Appointment_history(cancellation_id, previous_app_date_time, new_app_date_time, app_id)
        VALUES (NVL((SELECT MAX(cancellation_id)+1 FROM Appointment_history), 1), :OLD.app_date_time, :NEW.app_date_time, :OLD.app_id);
    END IF;
END;
/

SELECT * FROM Appointment;

SELECT * FROM Appointment_history;

UPDATE Appointment
SET app_date_time = timestamp '2022-12-26 10:30:00'
WHERE app_id = 101;

UPDATE Appointment
SET app_date_time = timestamp '2022-12-26 16:30:00'
WHERE app_id = 101;

UPDATE Appointment
SET app_date_time = timestamp '2022-12-30 16:30:00'
WHERE app_id = 103;

/*List the number of appointments scheduled for each doctor in the month of December 2022*/

SELECT Doctor.d_id, Doctor.d_name, COUNT(*)
FROM Appointment
JOIN Doctor ON Doctor.d_id = Appointment.d_id
WHERE TO_CHAR(Appointment.app_date_time, 'mm-yyyy') =  '12-2022'
GROUP BY Doctor.d_name, Doctor.d_id;


/*Get the list of paitent who rescheduled their appointments */

SELECT * 
FROM Paitent
JOIN Appointment ON Appointment.p_id = Paitent.p_id
WHERE Appointment.app_id IN (
    SELECT DISTINCT app_id
    FROM Appointment_history
);

/*List name and quantity of Medications prescribed for patient “Mike”.*/

SELECT Paitent.p_id, Paitent.p_name, Medicine.med_name, Prescription.med_quantity
FROM Paitent
JOIN Invoice ON Invoice.p_id = Paitent.p_id
JOIN Prescription ON Prescription.pres_id = Invoice.pres_id
JOIN Medicine ON Medicine.med_id = Prescription.med_id
WHERE Paitent.p_name = 'Mike';



