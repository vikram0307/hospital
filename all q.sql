-- Q1. Select all columns from the patients table.
select * from patientes;

-- Q2. Display the names and specializations of all doctors.
select doctor_name, specialization from doctors;

-- Q3. Find all patients who are older than 60 years
select * from patientes
where age > 60;

-- Q4. List all doctors who are 'Cardiologist'.
select * from doctors
where specialization = 'cardiologist';

-- Q5. Show all appointments where the status is 'Cancelled'.
select * from appointments
where status = 'cancelled';

-- Q6. Display all unique types of medicines from the medicines table.
select distinct medicine_name from medicines;

-- Q7. List the names of patients who are 'Female'.
select name from patientes
where gender = 'female';

-- Q8. Show all doctors whose salary is greater than 3,00,000
select * from doctors
where salary > 300000;

-- Q9. Display medicine details ordered by price from cheapest to most expensive
select * from medicines
order by price ;

-- Q10. Get the top 5 highest-paid doctors
select * from doctors
order by salary desc
limit 5;

-- Q11. Find all bills where the payment_status is 'Unpaid'
select * from bills
where payment_status = 'unpaid';

-- Q12. List the unique specializations available in the doctors table.
select distinct specialization  from doctors;

-- Q13 Show the name and age of patients sorted by age from youngest to oldest
select name, age from patients
order by age ;

-- Q14. Find all medicines manufactured by 'Cipla'
select * from medicines
where manufacturer = 'cipla';


-- Q15. Display all appointments scheduled for room number 552.
select * from appointments
where room_number = 552;

-- Q16. Find doctors who have between 10 and 20 years of experience.
select * from doctors
where experience_years between 10 and 20;

-- Q17. List all patients whose name starts with the letter 'A'.
select name from patients
where name like 'a%';

-- Q18. Find all bills where total_amount is greater than 5000 and status is 'Paid'
select * from bills 
where total_amount > 5000 and payment_status = 'paid';

-- Q19. Count the total number of patients in the hospital database
select count(*) from patients;

-- Q20. Calculate the average salary of all doctors.
select avg(salary) from doctors;

-- Q21. Find the maximum and minimum price of a medicine.
select min(medicine_charges) , max(medicine_charges) from bills;

-- Q22. Get the total sum of all medicine charges from the bills table
select sum(medicine_charges) from bills;

-- Q23. Count the number of appointments for each status
select status ,count(status) from appointments
group by status;

-- Q24. Find the average doctor fee charged in bills.
select avg(doctor_fee) from bills;

-- Q25. Show specializations that have an average doctor salary greater than 2,00,000
 select specialization from doctors
 group by specialization 
 having avg(salary) >200000;

select specialization , doctor_name , salary from doctors
where specialization in (select specialization from doctors
group by specialization 
having avg(salary) > 200000);

-- Q26. Count how many doctors belong to each city (with name)
select city, count(city), group_concat(doctor_name) from doctors
group by city;

-- Q27. Find the total amount collected from each payment status
select payment_status , sum(total_amount) from bills
group by payment_status;

-- Q28. Display all doctors whose email contains 'yahoo.com'
select * from doctors
where email like '%yahoo.com';

-- Q29. List all patients whose address contains 'Delhi'.
select * from patients
where address like '%delhi%';

-- Q30. Find all appointments that occurred in the year 2025
SELECT appointment_id, appointment_date 
FROM appointments
WHERE YEAR(appointment_date) = 2025;

-- Q31. Fetch patient name, age, and their appointment date using INNER JOIN
select p.name , p.age, a.appointment_date
from patients p
inner join appointments a
on a.appointment_id = p.patient_id;

-- Q32. Display doctor name, specialization, and appointment date for all appointments.
select d.doctor_name,d.specialization, a.appointment_date
from appointments a
left join doctors d
on d.doctor_id = a.doctor_id;

-- Q33. Get patient name, doctor name, and appointment status together.
select p.name,d.doctor_name,a.status
from doctors d
join appointments a
on d.doctor_id = a.doctor_id
join patients p
on p.patient_id = a.patient_id;

-- Q34. Show patient name and their total bill amount.
select p.name as patient_name ,b.total_amount
from patients p
left join bills b
on p.patient_id = b.patient_id ;

-- Q35. Find the total number of appointments handled by each doctor name
select d.doctor_name ,count(a.appointment_id)
from appointments a
left join doctors d
on d.doctor_id = a.doctor_id
group by d.doctor_id;

-- Q36. List all patients who have paid bills along with their bill ID
select p.name as patients_name, b.payment_status, b.bill_id
from patients p
join bills b
on p.patient_id = b.patient_id
where b.payment_status = 'paid';

-- Q37. Display doctor name and the total room charges collected from their appointments
select d.doctor_name ,sum(b.room_charges) as total_RoomCharges
from doctors d
join appointments a
on d.doctor_id = a.doctor_id
join bills b
on a.appointment_id = b.appointment_id
group by d.doctor_name;

-- Q38. Find patients who had appointments with 'Cardiologist' doctors
select p.name as patient_names ,d.doctor_name, d.specialization as Cardiologist_doctors  
from appointments a
join doctors d
on a.doctor_id = d.doctor_id
join patients p
on a.patient_id = p.patient_id
where d.specialization = 'cardiologist';

-- Q39. Show appointment details along with patient name for all cancelled appointments
select a.*, p.name patiant_name
from appointments a
join patients p
on a.patient_id = p.patient_id
where a.status = 'cancelled';

/* Q40. Display medicine names and their prices that have a price higher than the overall average
medicine price */
select medicine_name , price from medicines
where price < (select avg(price) from medicines );

-- Q41. Find patients who have never scheduled any appointment (using Subquery)
SELECT name FROM patients 
WHERE patient_id NOT IN (SELECT DISTINCT patient_id FROM appointments);

-- Q42. Find the doctor(s) who earn the absolute maximum salary (using Subquery).
select doctor_name from doctors
where salary = 
(select max(salary)from doctors);

-- Q43. Select patient names who have a total bill amount greater than the average total bill amount.
select p.name , total_amount from patients p
join bills b
on p.patient_id = b.patient_id
where b.total_amount >
(select avg(total_amount) from bills);

-- Q44. Create a VIEW named 'PaidBills' that contains all records from bills table with 'Paid' status.
create view paidbills as
select bill_id,appointment_id,patient_id,doctor_fee,room_charges,medicine_charges,total_amount,payment_status as paid , medicine_id from bills
where payment_status = 'paid';

-- Q45. Write a query to drop the view 'PaidBills'
drop view paidbills;

-- Q46. Find the specialization that has the highest number of appointments.
SELECT d.specialization, COUNT(a.appointment_id) AS total_apps 
FROM appointments a 
JOIN doctors d ON a.doctor_id = d.doctor_id 
GROUP BY d.specialization 
ORDER BY total_apps DESC LIMIT 1;

-- Q47. List the details of the most expensive medicine under each medicine type
SELECT * FROM medicines
WHERE (type, price) IN (
    SELECT type, MAX(price) 
    FROM medicines
    GROUP BY type
);



-- Q48. Find the second highest doctor salary from the doctors table.
select distinct * from doctors
order by salary desc
limit 1 offset 1;

-- Q49. Display patients who have visited more than 2 different doctors
SELECT p.patient_id, p.name, COUNT(DISTINCT a.doctor_id) AS distinct_doctors
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.name
HAVING COUNT(DISTINCT a.doctor_id) > 2;

-- Q50. Calculate the percentage of 'Paid' bills out of all bills generated.
SELECT (COUNT(CASE WHEN payment_status = 'Paid' THEN 1 END) * 100.0) / COUNT(*) AS paid_percentage
FROM bills;



