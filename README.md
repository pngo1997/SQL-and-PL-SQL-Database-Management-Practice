# 🏗️ SQL and PL/SQL Database Management

## 📜 Overview  
This project focuses on SQL and PL/SQL for database management, data querying, and trigger implementation. It consists of **three parts**, covering **data handling using Pandas, PL/SQL procedural logic, and database triggers** for automatic constraint enforcement.  

## 🎯 Problem Explanation  

### **Part 1: Employee Data Analysis Using Pandas**  
The task involves working with **employee data (`employee.csv`)** using **Pandas in Python**. The objectives include:  
1. **Read and explore the dataset** (dimensions, column names).  
2. **Rename columns** for clarity.  
3. **Filter employees by gender** (e.g., all male employees).  
4. **Find the highest salary among female employees**.  
5. **Group salaries by middle initial** and print out all salaries in each group.  

### **Part 2: Student Score Computation Using PL/SQL**  
This part involves working with the **`STUDENT`** and **`WEIGHTS`** tables to compute student grades dynamically.  
- **Tables Defined:**  
  - `STUDENT` (ID, Name, Midterm, Final, Homework).  
  - `WEIGHTS` (MidPct, FinPct, HWPct).  
- **PL/SQL Program Requirements:**  
  - Extract the grading weights from `WEIGHTS`.  
  - Compute the **overall score** using the formula:  
    ```
    Overall Score = (Midterm * MidPct/100) + (Final * FinPct/100) + (Homework * HWPct/100)
    ```
  - Assign letter grades based on computed scores:  
    ```
    90-100 = A  
    80-89.99 = B  
    65-79.99 = C  
    0-64.99 = F  
    ```
  - Output **each student's overall score and corresponding letter grade**.
