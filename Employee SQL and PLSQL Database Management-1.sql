--Assignment Module 8--
--Part 2--

DROP TABLE STUDENT CASCADE CONSTRAINTS;
CREATE TABLE STUDENT(
	ID		CHAR(3),
	Name		VARCHAR2(20),
	Midterm	    NUMBER(3,0) CHECK (Midterm>=0 AND Midterm<=100),
	Final		NUMBER(3,0)	CHECK (Final>=0 AND Final<=100),
	Homework	NUMBER(3,0)	CHECK (Homework>=0 AND Homework<=100),
	PRIMARY KEY (ID)
);
INSERT INTO STUDENT VALUES ( '445', 'Seinfeld', 86, 90, 99 );
INSERT INTO STUDENT VALUES ( '909', 'Costanza', 74, 72, 86 );
INSERT INTO STUDENT VALUES ( '123', 'Benes', 93, 89, 91 );
INSERT INTO STUDENT VALUES ( '111', 'Kramer', 99, 91, 93 );
INSERT INTO STUDENT VALUES ( '667', 'Newman', 77, 82, 84 );
INSERT INTO STUDENT VALUES ( '889', 'Banya', 52, 66, 50 );
SELECT * FROM STUDENT;

DROP TABLE WEIGHTS CASCADE CONSTRAINTS;
CREATE TABLE WEIGHTS(
	MidPct	NUMBER(2,0) CHECK (MidPct>=0 AND MidPct<=100),
	FinPct	NUMBER(2,0) CHECK (FinPct>=0 AND FinPct<=100),
	HWPct	NUMBER(2,0) CHECK (HWPct>=0 AND HWPct<=100)
);
INSERT INTO WEIGHTS VALUES ( 30, 30, 40 );
SELECT * FROM WEIGHTS;
COMMIT;

SET SERVEROUTPUT ON;
-- Declare view ouput.
DECLARE
    CURSOR weightSCursor IS (SELECT MidPct, FinPct, HWPct FROM WEIGHTS);
    xPercent WEIGHTS.MidPct%TYPE;
    yPercent WEIGHTS.FinPct%TYPE;
    zPercent WEIGHTS.HWPct%TYPE;
    overallScore NUMBER (4,2);
    letterGrade VARCHAR2(1);
-- Fetch values from WEIGHTS table, assume we have multiple rows.  
BEGIN
    OPEN weightSCursor;
    LOOP
        FETCH weightSCursor INTO xPercent, yPercent, zPercent;
        EXIT WHEN weightSCursor%NOTFOUND;
        -- Print weights.
        DBMS_OUTPUT.PUT_LINE('Weights are ' || xPercent || ', ' || yPercent || ', ' || zPercent);
    END LOOP;
    -- Iterate over each entry of the STUDENT table.
    -- Calculate/get each student's overall score/letter grade. If exist, reset NULL value to 0.
    FOR studentCursor IN (SELECT ID, Name, Midterm, Final, Homework FROM STUDENT) LOOP
        -- Calculate overall score for each student
        overallScore := (COALESCE(studentCursor.Midterm, 0) * COALESCE(xPercent, 0) / 100)
                      + (COALESCE(studentCursor.Final, 0) * COALESCE(yPercent, 0) / 100)
                      + (COALESCE(studentCursor.Homework, 0) * COALESCE(zPercent, 0) / 100);

        IF    overallScore >= 90 THEN letterGrade := 'A';
        ELSIF overallScore >= 80 THEN letterGrade := 'B';
        ELSIF overallScore >= 65 THEN letterGrade := 'C';
        ELSE  letterGrade := 'F';
        END IF;
        -- Print student information, overall score and letter grade.
        DBMS_OUTPUT.PUT_LINE(studentCursor.ID || ' ' || studentCursor.Name || ' ' || overallScore || ' ' || letterGrade);
    END LOOP;
END;
/

