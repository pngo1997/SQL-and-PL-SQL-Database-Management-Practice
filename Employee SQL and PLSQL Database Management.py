#!/usr/bin/env python
# coding: utf-8

# ## Part 1

# Use a DataFrame in python to define the following queries using the Employee data (employee.csv is attached). You can read it using pandas.read_csv('Employee.txt'). Adding optional parameter names=[] will allow you to rename the columns. 

# In[21]:


import pandas as pd
pdEmployee = pd.read_csv("Employee.txt", header = None) 
pdEmployee.shape
#Read data as Pandas dataframe and get number of rows and columns. 


# In[22]:


pdEmployee


# Rename columns

# In[23]:


pdEmployee = pdEmployee.set_axis(['First Name', 'Middle Initial', 'Last Name', 'EmployeeID', 'DOB',
                                  'Address', 'City', 'State', 'Gender', 'Salary', 'ManagerID', 'ProjectID'], axis=1)
pdEmployee


# a. Find all male employees.

# In[24]:


maleEmployee = pdEmployee[pdEmployee['Gender']=="M"]
maleEmployee


# b. Find the highest salary for female employees.

# In[17]:


femaleEmployee = pdEmployee[pdEmployee['Gender']=="F"]
highhestPaid_femaleEmployee = femaleEmployee['Salary'].max()
print(f"Highest salary for female employees: {highhestPaid_femaleEmployee}.")


# c. Print out salary groups (individual list of values without applying the final aggregation) grouped by middle initial. That is, for each unique middle initial, print all of the salaries in that group.

# In[19]:


salaryGroups = pdEmployee.groupby('Middle Initial')['Salary'].apply(list)
for middleInitial, Salary in salaryGroups.items():
    print(f"Middle Initial: {middleInitial}, Salaries: {Salary}")


# In[ ]:




