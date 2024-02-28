USE db;

-- ---------
-- Part 1 SQL Updates

-- Update the course name
SELECT * FROM course;
UPDATE course SET coursename='Multimedia and Communications' WHERE coursename='Multimedia';

-- Select tauserid based on firstname
SELECT * FROM hasworkedon WHERE tauserid IN (SELECT tauserid FROM ta WHERE firstname LIKE 'R%');

-- Update hours for matching tas
UPDATE hasworkedon SET hours=200 WHERE EXISTS (SELECT * FROM ta WHERE hasworkedon.tauserid=ta.tauserid AND ta.firstname LIKE 'R%');

-- Verify the updates
SELECT course.*, hasworkedon.* FROM course LEFT JOIN hasworkedon ON course.coid = hasworkedon.coid;

-- ---------
-- Part 2 SQL Inserts

-- Insert into the Course Offering Table
SELECT * FROM course;
INSERT INTO course VALUES ('CS3331','Foundations of CompSci', 3, 2000);

-- Insert into the Course Offering Table
SELECT * FROM courseoffer;
INSERT INTO courseoffer VALUES ('RD11',400, 'Fall',2021, 'CS3331');
INSERT INTO courseoffer VALUES ('RD22',380, 'Fall',2022, 'CS3331');
INSERT INTO courseoffer VALUES ('RD33',430, 'Fall',2023, 'CS3331');

-- Insert into the ta table
SELECT * FROM ta;
INSERT INTO ta VALUES ('srogen','Seth','Rogen','251000777','PhD');

-- Insert into the loves table
SELECT * FROM loves;
INSERT INTO loves VALUES ('srogen','CS3331');

-- Statements to prove the INSERT commands worked:

SELECT * FROM course WHERE coursenum='CS3331';
SELECT * FROM courseoffer WHERE whichcourse='CS3331';
SELECT * FROM ta WHERE tauserid='srogen';
SELECT * FROM loves WHERE ltauserid='srogen' AND lcoursenum='CS3331';

-- ---------
-- Part 3 SQL Queries

-- Query 1
SELECT lastname FROM ta;

-- Query 2
SELECT DISTINCT lastname FROM ta;

-- Query 3
SELECT * FROM ta ORDER BY firstname ASC;

-- Query 4
SELECT firstname, lastname, tauserid FROM ta WHERE degreetype='Masters';

-- Query 5
SELECT coid, term, year, whichcourse FROM courseoffer WHERE whichcourse IN (SELECT coursenum FROM course WHERE coursename LIKE '%Databases%');

-- Query 6
SELECT courseoffer.*, course.* FROM courseoffer LEFT JOIN course ON courseoffer.whichcourse=course.coursenum WHERE courseoffer.year<course.year;

-- Query 7
SELECT course.coursename, course.coursenum FROM course JOIN loves ON course.coursenum=loves.lcoursenum JOIN ta ON loves.ltauserid=ta.tauserid WHERE ta.lastname='Geller';

-- Query 8
SELECT COUNT(courseoffer.numstudent), course.coursename, course.coursenum FROM course JOIN courseoffer ON course.coursenum=courseoffer.whichcourse WHERE course.coursenum='CS1033';

-- Query 9
SELECT DISTINCT ta.firstname, ta.lastname, courseoffer.whichcourse FROM ta JOIN hasworkedon ON ta.tauserid=hasworkedon.tauserid JOIN courseoffer ON hasworkedon.coid=courseoffer.coid JOIN course ON courseoffer.whichcourse=course.coursenum WHERE course.level=1;

-- Query 10
CREATE VIEW MaxHoursPerOffering AS SELECT hasworkedon.coid AS CourseOfferingID, MAX(hasworkedon.hours) AS MaxHours FROM hasworkedon GROUP BY hasworkedon.coid;

CREATE VIEW MaxHoursTAs AS SELECT MaxHoursPerOffering.CourseOfferingID, hasworkedon.tauserid, hasworkedon.hours FROM MaxHoursPerOffering JOIN hasworkedon ON MaxHoursPerOffering.CourseOfferingID=hasworkedon.coid AND MaxHoursPerOffering.MaxHours=hasworkedon.hours;

SELECT MaxHoursTAs.CourseOfferingID, ta.firstname, ta.lastname, MaxHoursTAs.hours FROM MaxHoursTAs JOIN ta ON MaxHoursTAs.tauserid=ta.tauserid;

-- Query 11
SELECT course.coursenum, course.coursename FROM course WHERE course.coursenum NOT IN (SELECT lcoursenum FROM loves) AND course.coursenum NOT IN (SELECT hcoursenum FROM hates);

-- Query 12
SELECT ta.lastname, ta.firstname, COUNT(hasworkedon.coid) AS NumCourseOfferings FROM ta JOIN hasworkedon ON ta.tauserid = hasworkedon.tauserid GROUP BY ta.lastname, ta.firstname HAVING COUNT(hasworkedon.coid)>1;

-- Query 13
SELECT ta.firstname, ta.lastname, course.coursenum, course.coursename FROM ta JOIN hasworkedon ON ta.tauserid=hasworkedon.tauserid JOIN courseoffer ON hasworkedon.coid=courseoffer.coid JOIN course ON courseoffer.whichcourse=course.coursenum WHERE (ta.tauserid, course.coursenum) IN (SELECT ta.tauserid, loves.lcoursenum FROM ta JOIN loves ON ta.tauserid=loves.ltauserid);

-- Query 14
CREATE VIEW FallCourseOfferCount AS SELECT courseoffer.whichcourse AS CourseNumber, course.coursename AS CourseName, COUNT(*) AS OfferCount FROM courseoffer JOIN course ON courseoffer.whichcourse=course.coursenum WHERE courseoffer.term='Fall' GROUP BY courseoffer.whichcourse, course.coursename;

SELECT CourseNumber, CourseName, OfferCount FROM FallCourseOfferCount WHERE OfferCount=(SELECT MAX(OfferCount) FROM FallCourseOfferCount);

-- Query 15
-- This query shows the most loved course at each level
WITH RankedCourses AS (SELECT c.level, c.coursenum AS CourseNumber, c.coursename AS CourseName, COUNT(l.ltauserid) AS LoveCount, ROW_NUMBER() OVER (PARTITION BY c.level ORDER BY COUNT(l.ltauserid) DESC) AS LoveRank FROM course AS c LEFT JOIN loves AS l ON c.coursenum=l.lcoursenum GROUP BY c.level, c.coursenum, c.coursename) SELECT r.level, r.CourseNumber AS MostLovedCourseNumber, r.CourseName AS MostLovedCourseName, r.LoveCount AS LoveCount FROM RankedCourses AS r WHERE r.LoveRank=1;

-- ---------
-- Part 4 SQL Views/Deletes

CREATE VIEW TaHates AS SELECT ta.firstname, ta.lastname, ta.tauserid, course.coursenum, course.coursename FROM ta JOIN hates ON ta.tauserid=hates.htauserid JOIN course ON hates.hcoursenum=course.coursenum ORDER BY course.level, course.coursenum;

SELECT * FROM TaHates;

SELECT DISTINCT ta.firstname, ta.lastname, hates.hcoursenum AS course_number FROM (SELECT tauserid, hcoursenum FROM hates) AS hates JOIN ta ON hates.tauserid=ta.tauserid LEFT JOIN hasworkedon ON hates.tauserid=hasworkedon.tauserid AND hates.hcoursenum=hasworkedon.coid WHERE hasworkedon.coid IS NULL;

SELECT * FROM ta;

SELECT * FROM hates;

DELETE FROM ta WHERE tauserid='pbing';

-- This should be empty
SELECT * FROM ta WHERE tauserid='pbing';

SELECT * FROM hates;

DELETE FROM ta WHERE tauserid = 'mgeller';
-- It didn't work since mgeller has an association in another table

ALTER TABLE ta ADD image VARCHAR(200);

SELECT * FROM ta;

UPDATE ta
SET image='https://i.pinimg.com/originals/bf/85/8d/bf858d262ce992754e2b78042c9e0fe8.gif' WHERE tauserid = 'mgeller';

SELECT * FROM ta;
