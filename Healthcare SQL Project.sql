SELECT * FROM healthcare.doctors;
SELECT COUNT(doctor_name) as doctor_count
FROM healthcare.doctors;
SELECT specialization, COUNT(doctor_name) AS doctor_count
FROM healthcare.doctors
GROUP BY specialization;
select specialization, avg(experience_years) as avg_experience
from healthcare.doctors
group by specialization;
select * from healthcare.doctors
where experience_years>10;
select doctor_id,doctor_name,specialization
from healthcare.doctors;
select * from healthcare.doctors
order by experience_years desc
limit 1;
select * from healthcare.doctors
order by experience_years asc
limit 1;
select * from healthcare.doctors
order by experience_years desc
limit 3;
SELECT  CASE 
    WHEN experience_years BETWEEN 0 AND 5 THEN '0-5 years'
    WHEN experience_years BETWEEN 6 AND 10 THEN '6-10 years'
    WHEN experience_years > 10 THEN '10+ years'
END AS experience_range,
COUNT(*) AS doctor_count FROM healthcare.doctors
GROUP BY experience_range;
SELECT d.* FROM healthcare.doctors d
LEFT JOIN healthcare.appointments a 
ON d.doctor_id = a.doctor_id
WHERE a.doctor_id IS NULL;
SELECT * FROM healthcare.patients;
SELECT COUNT(patient_name) as patient_count
FROM healthcare.patients;
select gender, count(patient_name) as patient_count
from healthcare.patients
group by gender;
select city, count(patient_name) as patient_count
from healthcare.patients
group by city;
select avg(age) as averge_age
from healthcare.patients;
select count(*) as senior_citizens_count
from healthcare.patients
where age > 60;
SELECT city, COUNT(*) AS total_patients
FROM healthcare.patients
GROUP BY city
ORDER BY total_patients DESC
LIMIT 5;
select * from healthcare.patients
where city = 'Chennai' 
and registration_date > '2023-12-31';
select patient_id,patient_name,registration_date,
DATE_FORMAT(registration_date, '%Y-%m') AS month
FROM healthcare.patients
ORDER BY month, registration_date;
SELECT *
FROM healthcare.patients
WHERE registration_date > '2024-01-01';
SELECT CASE
    WHEN age BETWEEN 20 AND 30 THEN '20-30'
    WHEN age BETWEEN 31 AND 40 THEN '31-40'
    WHEN age BETWEEN 41 AND 50 THEN '41-50'
    WHEN age BETWEEN 51 AND 60 THEN '51-60'
    ELSE '60+'
  END AS age_group,
  COUNT(*) AS patient_count FROM healthcare.patients
GROUP BY age_group;
SELECT * FROM healthcare.appointments;
select count(*) as total_appointments
from healthcare.appointments;
select doctor_id, count(appointment_id) as appointment_count
from healthcare.appointments
group by doctor_id;
select patient_id, count(appointment_id) as visit_count
from healthcare.appointments
group by patient_id;
SELECT 
    YEAR(visit_date) AS year,
    MONTH(visit_date) AS month,
    COUNT(*) AS appointment_count
FROM healthcare.appointments
GROUP BY YEAR(visit_date), MONTH(visit_date)
ORDER BY year, month;
SELECT disease, COUNT(*) AS appointment_count
FROM healthcare.appointments
GROUP BY disease;
SELECT disease, COUNT(*) AS treatment_count
FROM healthcare.appointments
GROUP BY disease
ORDER BY treatment_count DESC
LIMIT 1;
SELECT patient_id, COUNT(*) AS visit_count
FROM healthcare.appointments
GROUP BY patient_id
HAVING COUNT(*) > 3;
SELECT doctor_id, COUNT(DISTINCT patient_id) AS patient_count
FROM healthcare.appointments
GROUP BY doctor_id
HAVING COUNT(DISTINCT patient_id) > 50;
SELECT DISTINCT patient_id
FROM healthcare.appointments
WHERE visit_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
SELECT patient_id,
    MIN(visit_date) AS first_visit,
    MAX(visit_date) AS last_visit
FROM healthcare.appointments
GROUP BY patient_id;
SELECT * FROM healthcare.billing;
select sum(bill_amount) as total_revenue 
from healthcare.billing;
select avg(bill_amount) as avgerage_bill_amount
from healthcare.billing;
select payment_mode, sum(bill_amount) as total_revenue
from healthcare.billing
group by payment_mode;
select payment_mode, count(*) as transaction_count
from healthcare.billing
group by payment_mode;
select 
     max(bill_amount) as highest_bill,
	 min(bill_amount) as lowest_bill
from healthcare.billing;
SELECT 
    DATE(payment_date) AS payment_day,
    SUM(bill_amount) AS daily_revenue
FROM billing
GROUP BY DATE(payment_date)
ORDER BY payment_day;
SELECT 
    YEAR(payment_date) AS year,
    MONTH(payment_date) AS month,
    SUM(bill_amount) AS monthly_revenue
FROM healthcare.billing
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY year, month;
select *
from healthcare.billing
where bill_amount > (select avg(bill_amount) from billing);
SELECT 
    a.patient_id,
    SUM(b.bill_amount) AS total_bill
FROM healthcare.billing b
JOIN healthcare.appointments a
    ON b.appointment_id = a.appointment_id
GROUP BY a.patient_id
HAVING SUM(b.bill_amount) > 50000;
select * from healthcare.billing
order by bill_amount desc
limit 10;
SELECT * FROM healthcare.billing;
SELECT p.city,
       SUM(b.bill_amount) AS total_revenue,
       COUNT(DISTINCT a.patient_id) AS total_patients,
       COUNT(a.appointment_id) AS total_appointments
FROM healthcare.billing b
JOIN healthcare.appointments a ON b.appointment_id = a.appointment_id
JOIN healthcare.patients p ON a.patient_id = p.patient_id
GROUP BY p.city
ORDER BY total_revenue DESC;
SELECT d.doctor_name, SUM(b.bill_amount) AS total_revenue
FROM healthcare.billing b
JOIN healthcare.appointments a ON b.appointment_id = a.appointment_id
JOIN healthcare.doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_name
ORDER BY total_revenue DESC;
SELECT d.specialization, SUM(b.bill_amount) AS total_revenue
FROM billing b
JOIN healthcare.appointments a ON b.appointment_id = a.appointment_id
JOIN healthcare.doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.specialization
ORDER BY total_revenue DESC;
SELECT p.patient_name, SUM(b.bill_amount) AS total_spent
FROM billing b
JOIN healthcare.appointments a ON b.appointment_id = a.appointment_id
JOIN healthcare.patients p ON a.patient_id = p.patient_id
GROUP BY p.patient_name
ORDER BY total_spent DESC;
SELECT d.doctor_name, SUM(b.bill_amount) AS total_revenue
FROM healthcare.billing b
JOIN healthcare.appointments a ON b.appointment_id = a.appointment_id
JOIN healthcare.doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_name
ORDER BY total_revenue DESC
LIMIT 3;
SELECT  CASE 
WHEN COUNT(a.appointment_id) > 1 THEN 'Repeat Patient'
ELSE 'New Patient' END AS patient_type,
COUNT(DISTINCT p.patient_id) AS total_patients
FROM healthcare.patients p
JOIN healthcare.appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id;
SELECT p.patient_name, COUNT(DISTINCT a.doctor_id) AS doctor_count
FROM healthcare.appointments a
JOIN healthcare.patients p ON a.patient_id = p.patient_id
GROUP BY p.patient_name
HAVING COUNT(DISTINCT a.doctor_id) > 1;
select a.disease, sum(b.bill_amount) as total_revenue
from healthcare.billing b
join healthcare.appointments a on b.appointment_id=a.appointment_id
group by a.disease
order by total_revenue desc;
SELECT d.doctor_name,
       COUNT(a.appointment_id) AS total_appointments,
       SUM(b.bill_amount) AS total_revenue,
AVG(b.bill_amount) AS avg_revenue_per_visit
FROM healthcare.doctors d
JOIN healthcare.appointments a ON d.doctor_id = a.doctor_id
JOIN billing b ON a.appointment_id = b.appointment_id
GROUP BY d.doctor_name
ORDER BY total_revenue DESC;
SELECT p.patient_name, SUM(b.bill_amount) AS total_spent
FROM healthcare.billing b
JOIN healthcare.appointments a ON b.appointment_id = a.appointment_id
JOIN healthcare.patients p ON a.patient_id = p.patient_id
GROUP BY p.patient_name
HAVING SUM(b.bill_amount) > (SELECT AVG(total_spent)
FROM (SELECT SUM(b2.bill_amount) AS total_spent
FROM healthcare.billing b2
JOIN healthcare.appointments a2 ON b2.appointment_id = a2.appointment_id
GROUP BY a2.patient_id) sub) ORDER BY total_spent DESC;