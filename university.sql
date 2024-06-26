



-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) = 1990;

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * FROM `courses` WHERE cfu > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * FROM `students` WHERE TIMESTAMPDIFF (YEAR, date_of_birth, CURRENT_DATE()) > 30;

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea

-- RISULTATO FALLITO
SELECT * FROM courses WHERE period = 1 AND year = 1;

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020

SELECT * FROM exams WHERE date = '2020-06-20' AND TIME(hour) > '14:00:00';

-- 6. Selezionare tutti i corsi di laurea magistrale
SELECT * FROM degree WHERE level = 'magistrale';

-- 7. Da quanti dipartimenti è composta l'università?
SELECT COUNT(*) AS number_of_departments FROM departments;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono?
SELECT COUNT(*) AS number_of_teachers_without_phone FROM teachers WHERE phone IS NULL;

-- 9. Inserire nella tabella degli studenti un nuovo record con i propri dati

-- RISULTATO FALLITO
INSERT INTO students (degree_id, name, surname, date_of_birth, fiscal_code, enrolment_date, registration_number, email)
VALUES (89, 'Matteo', 'Cenci', '2001-03-13', 'CNCMTT01C13D451W', '2022-11-11', 620058, 'matticnc@gmail.com' );

-- 10. Cambiare il numero dell’ufficio del professor Pietro Rizzo in 126
UPDATE teachers SET office_address = 126 WHERE name = 'Pietro' AND surname = 'Rizzo';












-- QUERY CHE UTILIZZANO GROUP BY 
-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(enrolment_date) AS enrolment_year, COUNT(*) AS number_of_students
FROM students
GROUP BY YEAR(enrolment_date);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT office_address, COUNT(*) AS number_of_teachers
FROM teachers
GROUP BY office_address;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT exam_id, AVG(vote) AS average_grade
FROM exam_student
GROUP BY exam_id;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT department_id, COUNT(*) AS number_of_degree_programs
FROM degrees
GROUP BY department_id;






-- QUERY CON JOIN
-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT s.*
FROM students s
JOIN degrees dp ON s.degree_id = dp.department_id
WHERE dp.name = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT dp.*
FROM degrees dp
JOIN departments d ON dp.department_id = d.id
WHERE dp.level = 'magistrale' AND d.name = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT c.*
FROM course_teacher c
JOIN teachers t ON c.teacher_id = t.id
WHERE t.id = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
