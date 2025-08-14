create database Lawerfirm;
CREATE TABLE LawFirm (
    firm_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100)
);

insert into LawFirm (name, address, phone, email) 
values 
('Lawfirst', 'New Yourk', '017-5612-865', 'lawf@gmail.com'),
('Lawhelp', 'New Yourk', '018-5452-865', 'help@gmail.com'),
('Law', 'New Yourk', '017-9886-865', 'law@gmail.com');

CREATE TABLE Lawyer (
    lawyer_id INT PRIMARY KEY AUTO_INCREMENT,
    firm_id INT,
    name VARCHAR(255) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    FOREIGN KEY (firm_id) REFERENCES LawFirm(firm_id)
);

insert into Lawyer (firm_id, name, specialization, phone, email) 
values 
(1, 'John Smith', 'Criminal Law', '017-1111-222', 'john.smith@gmail.com'),
(1, 'John Meth', 'Family Law', '017-1861-282', 'meth@gmail.com'),
(2, 'Peter Ben', 'Corporate Law', '017-3865-222', 'peter@gmail.com'),
(2, 'Michael Johnson', 'Family Law', '018-5555-666', 'michael.johnson@gmail.com'),
(3, 'Ben Johnson', 'Family Law', '018-8658-666', 'ben@gmail.com'),
(3, 'Sarah Davis', 'Immigration Law', '017-7777-888', 'sarah.davis@gmail.com');

CREATE TABLE CaseFile (
    case_id INT PRIMARY KEY AUTO_INCREMENT,
    case_number VARCHAR(100) UNIQUE,
    title VARCHAR(255),
    case_type VARCHAR(100),
    start_date DATE,
    status VARCHAR(50),
    court_name VARCHAR(100)
);
insert into CaseFile (case_number, title, case_type, start_date, `status`, court_name) 
values
('C-8654', 'State vs. Brown', 'Criminal', '2024-02-15', 'Open', 'Supreme Court'),
('C-1223', 'Johnson Divorce', 'Family', '2024-03-01', 'Closed', 'Family Court'),
('C-1235', 'Immigration Appeal', 'Immigration', '2024-01-20', 'Open', 'Immigration Court'),
('C-2411', 'Corporate Tax Dispute', 'Corporate', '2024-05-10', 'In Progress', 'Tax Court');


CREATE TABLE Client (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100)
);
insert into Client (name, phone, email)
values
('Bob', '018-8897-666', 'bob@gmail.com'),
('Mary', '018-8696-853', 'mary@gmail.com'),
('Adam', '018-8543-544', 'adam@gmail.com'),
('Ann', '018-8465-896', 'ann@gmail.com');

CREATE TABLE ClientDetails (
    client_id INT PRIMARY KEY,
    address TEXT,
    date_of_birth DATE,
    gender VARCHAR(10),
    FOREIGN KEY (client_id) REFERENCES Client(client_id)
);
insert into ClientDetails (client_id, address, date_of_birth, gender)
values
(1, 'New york, Main St. 12', '1985-04-12', 'Male'),
(2, 'New york, Fran St. 5', '1990-07-21', 'Female'),
(3, 'New york, Deri St. 8', '1988-11-03', 'Male'),
(4, 'New york, First Ave. 25', '1995-09-17', 'Female');

CREATE TABLE LawyerCase (
    lawyer_id INT,
    case_id INT,
    role VARCHAR(50),
    PRIMARY KEY (lawyer_id, case_id),
    FOREIGN KEY (lawyer_id) REFERENCES Lawyer(lawyer_id),
    FOREIGN KEY (case_id) REFERENCES CaseFile(case_id)
);
insert into LawyerCase (lawyer_id, case_id, role)
values
(1, 1, 'Lead Lawyer'),
(2, 4, 'Advisor'),
(3, 2, 'Lead Lawyer'),
(5, 3, 'Lead Lawyer');

CREATE TABLE ClientCase (
    client_id INT,
    case_id INT,
    is_primary BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (client_id, case_id),
    FOREIGN KEY (client_id) REFERENCES Client(client_id),
    FOREIGN KEY (case_id) REFERENCES CaseFile(case_id)
);
insert into ClientCase (client_id, case_id, is_primary) 
values
(1, 1, TRUE),
(2, 2, TRUE),
(3, 3, TRUE),
(4, 4, TRUE);

CREATE TABLE Hearing (
    hearing_id INT PRIMARY KEY AUTO_INCREMENT,
    case_id INT,
    hearing_date DATE,
    judge_name VARCHAR(255),
    outcome TEXT,
    FOREIGN KEY (case_id) REFERENCES CaseFile(case_id)
);
insert into Hearing (case_id, hearing_date, judge_name, outcome) 
values
(1, '2024-03-20', 'Judge Adams', 'Pending'),
(2, '2024-03-15', 'Judge Smith', 'Divorce Granted'),
(3, '2024-04-10', 'Judge Lee', 'Pending');

CREATE TABLE Document (
    document_id INT PRIMARY KEY AUTO_INCREMENT,
    case_id INT,
    title VARCHAR(255),
    upload_date DATE,
    file_path TEXT,
    FOREIGN KEY (case_id) REFERENCES CaseFile(case_id)
);
insert into Document (case_id, title, upload_date, file_path)
values
(1, 'Police Report', '2024-02-16', '/docs/police_report.pdf'),
(2, 'Divorce Agreement', '2024-03-02', '/docs/divorce_agreement.pdf'),
(4, 'Tax Records', '2024-05-15', '/docs/tax_records.pdf');

CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    lawyer_id INT,
    client_id INT,
    appointment_date DATETIME,
    purpose TEXT,
    FOREIGN KEY (lawyer_id) REFERENCES Lawyer(lawyer_id),
    FOREIGN KEY (client_id) REFERENCES Client(client_id)
);
insert into Appointment (lawyer_id, client_id, appointment_date, purpose) 
values
(1, 1, '2024-02-14 10:00:00', 'Case discussion'),
(3, 2, '2024-03-05 14:30:00', 'Divorce consultation'),
(5, 3, '2024-01-22 09:00:00', 'Immigration appeal preparation');

CREATE TABLE Invoice (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    issue_date DATE,
    due_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (client_id) REFERENCES Client(client_id)
);
insert into Invoice (client_id, issue_date, due_date, total_amount, status) 
values
(1, '2024-02-14', '2024-03-14', 500.00, 'Paid'),
(2, '2024-03-05', '2024-04-05', 750.00, 'Unpaid'),
(3, '2024-01-22', '2024-02-22', 1000.00, 'Paid');

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    method VARCHAR(50),
    FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id)
);
insert into Payment (invoice_id, payment_date, amount, method) 
values
(1, '2024-02-20', 500.00, 'Credit Card'),
(3, '2024-02-25', 1000.00, 'Bank Transfer');

CREATE TABLE ContactLog (
    contact_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    lawyer_id INT,
    contact_date DATETIME,
    method VARCHAR(50),
    notes TEXT,
    FOREIGN KEY (client_id) REFERENCES Client(client_id),
    FOREIGN KEY (lawyer_id) REFERENCES Lawyer(lawyer_id)
);
insert into ContactLog (client_id, lawyer_id, contact_date, method, notes) 
values
(1, 1, '2024-02-13 15:00:00', 'Phone', 'Discussed evidence'),
(2, 3, '2024-03-04 11:00:00', 'Email', 'Sent divorce papers'),
(3, 5, '2024-01-21 16:30:00', 'Meeting', 'Prepared immigration documents');

CREATE TABLE LegalArea (
    area_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);
insert into LegalArea (name) 
values
('Criminal Law'),
('Family Law'),
('Corporate Law'),
('Immigration Law'),
('Tax Law');

CREATE TABLE LawyerSpecialization (
    lawyer_id INT,
    area_id INT,
    PRIMARY KEY (lawyer_id, area_id),
    FOREIGN KEY (lawyer_id) REFERENCES Lawyer(lawyer_id),
    FOREIGN KEY (area_id) REFERENCES LegalArea(area_id)
);
insert into LawyerSpecialization (lawyer_id, area_id) 
values
(1, 1),
(2, 3),
(3, 2),
(5, 4),
(6, 5);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    firm_id INT,
    name VARCHAR(255),
    position VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    FOREIGN KEY (firm_id) REFERENCES LawFirm(firm_id)
);
insert into Employee (firm_id, name, position, phone, email) 
values
(1, 'Kate Moore', 'Paralegal', '017-8968-265', 'kate@gmail.com'),
(2, 'Tom Reed', 'Secretary', '018-7856-897', 'tom@gmail.com'),
(3, 'Lisa Green', 'IT Support', '017-8964-398', 'lisa@gmail.com');

CREATE TABLE CaseNote (
    note_id INT PRIMARY KEY AUTO_INCREMENT,
    case_id INT,
    lawyer_id INT,
    note_date DATETIME,
    content TEXT,
    FOREIGN KEY (case_id) REFERENCES CaseFile(case_id),
    FOREIGN KEY (lawyer_id) REFERENCES Lawyer(lawyer_id)
);
insert into CaseNote (case_id, lawyer_id, note_date, content) 
values
(1, 1, '2024-02-17 09:00:00', 'Reviewed police report'),
(2, 3, '2024-03-06 10:00:00', 'Prepared divorce settlement proposal');

CREATE TABLE CaseReview (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    case_id INT,
    client_id INT,
    review_date DATE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    FOREIGN KEY (case_id) REFERENCES CaseFile(case_id),
    FOREIGN KEY (client_id) REFERENCES Client(client_id)
);
insert into CaseReview (case_id, client_id, review_date, rating, comments) 
values
(2, 2, '2024-03-20', 5, 'Excellent service'),
(3, 3, '2024-02-10', 4, 'Good support, case still pending');

CREATE TABLE Evidence (
    evidence_id INT PRIMARY KEY AUTO_INCREMENT,
    case_id INT,
    type VARCHAR(100),
    description TEXT,
    submitted_by VARCHAR(100),
    submission_date DATE,
    file_path TEXT,
    FOREIGN KEY (case_id) REFERENCES CaseFile(case_id)
);
insert into Evidence (case_id, type, description, submitted_by, submission_date, file_path) 
values
(1, 'Document', 'Police report file', 'Officer John', '2024-02-16', '/evidence/police_report.pdf'),
(4, 'File', 'Tax dispute records', 'Client', '2024-05-12', '/evidence/tax_dispute.pdf');

CREATE TABLE Court (
    court_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    location VARCHAR(255),
    jurisdiction VARCHAR(255)
);
insert into Court (name, location, jurisdiction) 
values
('Supreme Court', 'Main st', 'National'),
('Family Court', 'First st', 'Regional');

CREATE TABLE CourtSchedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    court_id INT,
    case_id INT,
    hearing_date DATE,
    judge_name VARCHAR(255),
    FOREIGN KEY (court_id) REFERENCES Court(court_id),
    FOREIGN KEY (case_id) REFERENCES CaseFile(case_id)
);
insert into CourtSchedule (court_id, case_id, hearing_date, judge_name) 
values
(1, 1, '2024-03-20', 'Judge Adams'),
(2, 2, '2024-03-15', 'Judge Smith'),
(1, 3, '2024-04-10', 'Judge Lee'),
(2, 4, '2024-05-20', 'Judge Carter');

