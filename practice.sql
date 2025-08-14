--
SELECT l.lawyer_id, l.name AS lawyer_name, f.name AS firm_name
FROM LawFirm f
LEFT JOIN Lawyer l ON f.firm_id = l.firm_id;

SELECT c.client_id, c.name, d.address, d.date_of_birth
FROM Client c
LEFT JOIN ClientDetails d ON c.client_id = d.client_id;

SELECT cf.case_id, cf.title, lc.role
FROM CaseFile cf
LEFT JOIN LawyerCase lc ON cf.case_id = lc.case_id;

SELECT i.invoice_id, i.total_amount, SUM(p.amount) AS total_paid
FROM Invoice i
LEFT JOIN Payment p ON i.invoice_id = p.invoice_id
GROUP BY i.invoice_id;

SELECT c.name AS client_name, a.appointment_date
FROM Client c
LEFT JOIN Appointment a ON c.client_id = a.client_id;

SELECT cf.case_number, h.hearing_date
FROM CaseFile cf
LEFT JOIN Hearing h ON cf.case_id = h.case_id;

SELECT l.name, la.name AS legal_area
FROM Lawyer l
LEFT JOIN LawyerSpecialization ls ON l.lawyer_id = ls.lawyer_id
LEFT JOIN LegalArea la ON ls.area_id = la.area_id;

SELECT f.name, COUNT(e.employee_id) AS employee_count
FROM LawFirm f
LEFT JOIN Employee e ON f.firm_id = e.firm_id
GROUP BY f.name;

SELECT cf.title, COUNT(ev.evidence_id) AS evidence_count
FROM CaseFile cf
LEFT JOIN Evidence ev ON cf.case_id = ev.case_id
GROUP BY cf.title;

SELECT c.name, MAX(i.total_amount) AS max_invoice
FROM Client c
LEFT JOIN Invoice i ON c.client_id = i.client_id
GROUP BY c.name;

-- 
SELECT l.name AS lawyer_name, f.name AS firm_name
FROM Lawyer l
RIGHT JOIN LawFirm f ON l.firm_id = f.firm_id;

SELECT c.name, d.address
FROM ClientDetails d
RIGHT JOIN Client c ON d.client_id = c.client_id;

SELECT lc.role, cf.title
FROM LawyerCase lc
RIGHT JOIN CaseFile cf ON lc.case_id = cf.case_id;

SELECT p.payment_id, i.total_amount
FROM Payment p
RIGHT JOIN Invoice i ON p.invoice_id = i.invoice_id;

SELECT a.appointment_date, c.name
FROM Appointment a
RIGHT JOIN Client c ON a.client_id = c.client_id;

SELECT h.hearing_date, cf.title
FROM Hearing h
RIGHT JOIN CaseFile cf ON h.case_id = cf.case_id;

SELECT la.name AS legal_area, l.name AS lawyer_name
FROM LawyerSpecialization ls
RIGHT JOIN LegalArea la ON ls.area_id = la.area_id
RIGHT JOIN Lawyer l ON ls.lawyer_id = l.lawyer_id;

SELECT e.name AS employee_name, f.name AS firm_name
FROM Employee e
RIGHT JOIN LawFirm f ON e.firm_id = f.firm_id;

SELECT ev.type, cf.title
FROM Evidence ev
RIGHT JOIN CaseFile cf ON ev.case_id = cf.case_id;

SELECT cn.content, cf.title
FROM CaseNote cn
RIGHT JOIN CaseFile cf ON cn.case_id = cf.case_id;

--
SELECT l.name AS lawyer_name, f.name AS firm_name
FROM Lawyer l
INNER JOIN LawFirm f ON l.firm_id = f.firm_id;

SELECT c.name, i.total_amount
FROM Client c
INNER JOIN Invoice i ON c.client_id = i.client_id;

SELECT l.name, cf.title
FROM LawyerCase lc
INNER JOIN Lawyer l ON lc.lawyer_id = l.lawyer_id
INNER JOIN CaseFile cf ON lc.case_id = cf.case_id;

SELECT cf.title, h.hearing_date
FROM CaseFile cf
INNER JOIN Hearing h ON cf.case_id = h.case_id;

SELECT cf.title, COUNT(ev.evidence_id) AS total_evidence
FROM CaseFile cf
INNER JOIN Evidence ev ON cf.case_id = ev.case_id
GROUP BY cf.title;

SELECT c.name, a.appointment_date
FROM Client c
INNER JOIN Appointment a ON c.client_id = a.client_id;

SELECT l.name, la.name AS legal_area
FROM Lawyer l
INNER JOIN LawyerSpecialization ls ON l.lawyer_id = ls.lawyer_id
INNER JOIN LegalArea la ON ls.area_id = la.area_id;

SELECT cf.title, cr.rating
FROM CaseFile cf
INNER JOIN CaseReview cr ON cf.case_id = cr.case_id;

SELECT i.invoice_id, SUM(p.amount) AS paid
FROM Invoice i
INNER JOIN Payment p ON i.invoice_id = p.invoice_id
GROUP BY i.invoice_id;

SELECT cs.hearing_date, co.name AS court_name, cf.title
FROM CourtSchedule cs
INNER JOIN Court co ON cs.court_id = co.court_id
INNER JOIN CaseFile cf ON cs.case_id = cf.case_id;

--
SELECT f.name AS firm_name, l.name AS lawyer_name
FROM LawFirm f
LEFT JOIN Lawyer l ON f.firm_id = l.firm_id
UNION
SELECT f.name, l.name
FROM LawFirm f
RIGHT JOIN Lawyer l ON f.firm_id = l.firm_id;

SELECT c.name, i.total_amount
FROM Client c
LEFT JOIN Invoice i ON c.client_id = i.client_id
UNION
SELECT c.name, i.total_amount
FROM Client c
RIGHT JOIN Invoice i ON c.client_id = i.client_id;

SELECT cf.title, h.hearing_date
FROM CaseFile cf
LEFT JOIN Hearing h ON cf.case_id = h.case_id
UNION
SELECT cf.title, h.hearing_date
FROM CaseFile cf
RIGHT JOIN Hearing h ON cf.case_id = h.case_id;

SELECT l.name, la.name AS legal_area
FROM Lawyer l
LEFT JOIN LawyerSpecialization ls ON l.lawyer_id = ls.lawyer_id
LEFT JOIN LegalArea la ON ls.area_id = la.area_id
UNION
SELECT l.name, la.name
FROM Lawyer l
RIGHT JOIN LawyerSpecialization ls ON l.lawyer_id = ls.lawyer_id
RIGHT JOIN LegalArea la ON ls.area_id = la.area_id;

SELECT i.invoice_id, p.amount
FROM Invoice i
LEFT JOIN Payment p ON i.invoice_id = p.invoice_id
UNION
SELECT i.invoice_id, p.amount
FROM Invoice i
RIGHT JOIN Payment p ON i.invoice_id = p.invoice_id;

SELECT c.name, a.appointment_date
FROM Client c
LEFT JOIN Appointment a ON c.client_id = a.client_id
UNION
SELECT c.name, a.appointment_date
FROM Client c
RIGHT JOIN Appointment a ON c.client_id = a.client_id;

SELECT cf.title, cr.rating
FROM CaseFile cf
LEFT JOIN CaseReview cr ON cf.case_id = cr.case_id
UNION
SELECT cf.title, cr.rating
FROM CaseFile cf
RIGHT JOIN CaseReview cr ON cf.case_id = cr.case_id;

SELECT cf.title, ev.type
FROM CaseFile cf
LEFT JOIN Evidence ev ON cf.case_id = ev.case_id
UNION
SELECT cf.title, ev.type
FROM CaseFile cf
RIGHT JOIN Evidence ev ON cf.case_id = ev.case_id;

SELECT co.name, cs.hearing_date
FROM Court co
LEFT JOIN CourtSchedule cs ON co.court_id = cs.court_id
UNION
SELECT co.name, cs.hearing_date
FROM Court co
RIGHT JOIN CourtSchedule cs ON co.court_id = cs.court_id;

SELECT l.name, cn.content
FROM Lawyer l
LEFT JOIN CaseNote cn ON l.lawyer_id = cn.lawyer_id
UNION
SELECT l.name, cn.content
FROM Lawyer l
RIGHT JOIN CaseNote cn ON l.lawyer_id = cn.lawyer_id;

--
SELECT f.name AS firm_name, l.name AS lawyer_name, la.name AS specialization,
       cf.title AS case_title, h.hearing_date, c.name AS client_name,
       i.total_amount, p.amount AS payment_amount, ev.type AS evidence_type,
       cr.rating AS review_rating
FROM LawFirm f
LEFT JOIN Lawyer l ON f.firm_id = l.firm_id
LEFT JOIN LawyerSpecialization ls ON l.lawyer_id = ls.lawyer_id
LEFT JOIN LegalArea la ON ls.area_id = la.area_id
LEFT JOIN LawyerCase lc ON l.lawyer_id = lc.lawyer_id
LEFT JOIN CaseFile cf ON lc.case_id = cf.case_id
LEFT JOIN Hearing h ON cf.case_id = h.case_id
LEFT JOIN ClientCase cc ON cf.case_id = cc.case_id
LEFT JOIN Client c ON cc.client_id = c.client_id
LEFT JOIN Invoice i ON c.client_id = i.client_id
LEFT JOIN Payment p ON i.invoice_id = p.invoice_id
LEFT JOIN Evidence ev ON cf.case_id = ev.case_id
LEFT JOIN CaseReview cr ON cf.case_id = cr.case_id;

--
SELECT c.name AS client_name, SUM(i.total_amount) AS total_invoiced
FROM Client c
INNER JOIN Invoice i ON c.client_id = i.client_id
GROUP BY c.name;

SELECT l.name AS lawyer_name, COUNT(lc.case_id) AS total_cases
FROM Lawyer l
LEFT JOIN LawyerCase lc ON l.lawyer_id = lc.lawyer_id
GROUP BY l.name;

SELECT cf.title AS case_title, AVG(cr.rating) AS avg_rating
FROM CaseFile cf
INNER JOIN CaseReview cr ON cf.case_id = cr.case_id
GROUP BY cf.title;

--
SELECT c.name AS client_name, SUM(i.total_amount) AS total_invoiced
FROM Client c
INNER JOIN Invoice i ON c.client_id = i.client_id
GROUP BY c.name
HAVING SUM(i.total_amount) > 800;

SELECT l.name AS lawyer_name, COUNT(lc.case_id) AS total_cases
FROM Lawyer l
INNER JOIN LawyerCase lc ON l.lawyer_id = lc.lawyer_id
GROUP BY l.name
HAVING COUNT(lc.case_id) > 1;

SELECT cf.title AS case_title, AVG(cr.rating) AS avg_rating
FROM CaseFile cf
INNER JOIN CaseReview cr ON cf.case_id = cr.case_id
GROUP BY cf.title
HAVING AVG(cr.rating) >= 4.5;
