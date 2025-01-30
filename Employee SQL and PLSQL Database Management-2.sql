--Part 3--

DROP TABLE ENROLLMENT CASCADE CONSTRAINTS;
DROP TABLE SECTION CASCADE CONSTRAINTS;

CREATE TABLE SECTION(
 SectionID 	CHAR(5),
 Course	VARCHAR2(7),
 Students	NUMBER DEFAULT 0,
 CONSTRAINT PK_SECTION 
		PRIMARY KEY (SectionID)
);

CREATE TABLE ENROLLMENT(
 SectionID	CHAR(5),
 StudentID	CHAR(7),
 CONSTRAINT PK_ENROLLMENT 
		PRIMARY KEY (SectionID, StudentID),
 CONSTRAINT FK_ENROLLMENT_SECTION 
		FOREIGN KEY (SectionID)
		REFERENCES SECTION (SectionID)
);
 
INSERT INTO SECTION (SectionID, Course) VALUES ( '12345', 'CSC 355' );
INSERT INTO SECTION (SectionID, Course) VALUES ( '22109', 'CSC 309' );
INSERT INTO SECTION (SectionID, Course) VALUES ( '99113', 'CSC 300' );
INSERT INTO SECTION (SectionID, Course) VALUES ( '99114', 'CSC 300' );
COMMIT;
SELECT * FROM SECTION;

--a.
CREATE OR REPLACE TRIGGER insertEnrollment
-- Use BEFORE trigger to check for insert statament.
BEFORE INSERT ON ENROLLMENT
FOR EACH ROW
-- Obtain current SECTION.students value. 
DECLARE
    studentCount NUMBER(1);
BEGIN
    SELECT Students INTO studentCount FROM SECTION WHERE SectionID = :NEW.SectionID;
    -- If current SECTION.students value less than 5, allow to make update.
    -- Increase current SECTION.students by 1.
    IF studentCount < 5 THEN UPDATE SECTION 
        SET Students = studentCount + 1
        WHERE SECTION.SectionID = :NEW.SectionID;
    -- Otherwise print error statement.
    ELSE raise_application_error(-20102, '[Section is full, not able to enroll.]');
    END IF;
END;
/
    
-- Test.
INSERT INTO ENROLLMENT VALUES ('12345', '1234567');
INSERT INTO ENROLLMENT VALUES ('12345', '2234567');
INSERT INTO ENROLLMENT VALUES ('12345', '3234567');
INSERT INTO ENROLLMENT VALUES ('12345', '4234567');
INSERT INTO ENROLLMENT VALUES ('12345', '5234567');
INSERT INTO ENROLLMENT VALUES ('12345', '6234567');
SELECT * FROM Section;
SELECT * FROM Enrollment;


--b.
CREATE OR REPLACE TRIGGER deleteEnrollment
-- Use AFTER trigger for further action after deletion committed.
AFTER DELETE ON ENROLLMENT
FOR EACH ROW
BEGIN 
    -- Decrease current SECTION.students by 1.
    -- Reference with sectionID from delete statement for computational efficiency.
    UPDATE SECTION
    SET Students = Students - 1
    WHERE SectionID = :OLD.SectionID;
END;
/

-- Test.
DELETE FROM ENROLLMENT WHERE StudentID = '1234567';
SELECT * FROM Section;
SELECT * FROM Enrollment;
