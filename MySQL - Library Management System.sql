# Library Management System
#Topic : Library Management System You are going to build a project based on Library Management System. 
#It keeps track of all information about books in the library, their cost, status and total number of books available in the library. 
#Create a database named library and following TABLES in the database: 
#1. Branch #2. Employee 3. Books 4. Customer 5. IssueStatus 6. ReturnStatus Attributes for the tables: 
#1. Branch Branch_no - Set as PRIMARY KEY Manager_Id Branch_address Contact_no 


CREATE DATABASE library;
USE library;


CREATE TABLE Branch (
Branch_no INT PRIMARY KEY,
Manager_Id INT,
Branch_address VARCHAR(255),
Contact_no VARCHAR(15)
);


INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES 
(101, 1, 'Downtown Library, New York', '1234567890'),
(102, 2, 'City Central Library, Los Angeles', '9876543210'),
(103, 3, 'Metro Library, Chicago', '4567891230');


#2. Employee Emp_Id – Set as PRIMARY KEY Emp_name Position Salary Branch_no - Set as FOREIGN KEY and it refer Branch_no in Branch table 

CREATE TABLE Employee (
Emp_Id INT PRIMARY KEY,
Emp_name VARCHAR(255),
Position VARCHAR(100),
Salary DECIMAL(10,2),
Branch_no INT,
FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES 
(1, 'John Doe', 'Manager', 85000, 101),
(2, 'Sarah Smith', 'Manager', 78000, 102),
(3, 'Michael Brown', 'Manager', 82000, 103),
(4, 'Emily White', 'Librarian', 48000, 101),
(5, 'Robert Green', 'Assistant Librarian', 42000, 102),
(6, 'Anna Taylor', 'Librarian', 50000, 103);


#3. Books ISBN - Set as PRIMARY KEY Book_title Category Rental_Price Status [Give yes if book available and no if book not available] Author Publisher 



CREATE TABLE Books (
ISBN VARCHAR(20) PRIMARY KEY,
Book_title VARCHAR(255),
Category VARCHAR(100),
Rental_Price DECIMAL(10,2),
Status ENUM('Yes', 'No'),
Author VARCHAR(255),
Publisher VARCHAR(255)
);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES 
('978-0451524935', '1984', 'Fiction', 20, 'Yes', 'George Orwell', 'Penguin Classics'),
('978-0140449136', 'Crime and Punishment', 'Classics', 18, 'Yes', 'Fyodor Dostoevsky', 'Oxford University Press'),
('978-0061120084', 'To Kill a Mockingbird', 'Fiction', 25, 'No', 'Harper Lee', 'Harper Perennial'),
('978-0307949486', 'The Art of War', 'History', 15, 'Yes', 'Sun Tzu', 'Random House'),
('978-0321356680', 'Introduction to Algorithms', 'Science', 35, 'Yes', 'Thomas Cormen', 'MIT Press');
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES 
('978-0767908184', 'A Short History of Nearly Everything', 'Science', 30, 'Yes', 'Bill Bryson', 'Broadway Books');


#4. Customer Customer_Id - Set as PRIMARY KEY Customer_name Customer_address Reg_date

CREATE TABLE Customer (
Customer_Id INT PRIMARY KEY,
Customer_name VARCHAR(255),
Customer_address VARCHAR(255),
Reg_date DATE
);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES 
(1001, 'Alice Johnson', '45 Main St, New York', '2021-12-15'),
(1002, 'David Lee', '78 Grand Ave, Los Angeles', '2022-04-10'),
(1003, 'Sophia Martinez', '12 Elm St, Chicago', '2023-03-20'),
(1004, 'James Wilson', '90 Pine St, San Francisco', '2021-05-05');
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES 
(1005, 'Christopher', '50 Main St, New York', '2021-12-15');


 #5. IssueStatus Issue_Id - Set as PRIMARY KEY Issued_cust – Set as FOREIGN KEY and it refer customer_id in CUSTOMER table Issued_book_name Issue_date Isbn_book – Set as FOREIGN KEY and it should refer isbn in BOOKS table 

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);


INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES 
(201, 1001, '1984', '2023-06-10', '978-0451524935'),
(202, 1003, 'Crime and Punishment', '2023-06-12', '978-0140449136'),
(203, 1004, 'The Art of War', '2023-06-15', '978-0307949486');



#6. ReturnStatus Return_Id - Set as PRIMARY KEY Return_cust Return_book_name Return_date Isbn_book2 - Set as FOREIGN KEY and it should refer isbn in BOOKS table Display all the tables

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES 
(301, 1001, '1984', '2023-06-30', '978-0451524935'),
(302, 1003, 'Crime and Punishment', '2023-07-05', '978-0140449136');


#Write the queries for the following : 


#1. Retrieve the book title, category, and rental price of all available books. 
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'Yes';



#2. List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;



#3. Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT IssueStatus.Issued_book_name, Customer.Customer_name 
FROM IssueStatus 
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;


#4. Display the total count of books in each category. 

SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;



#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;


#6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01' 
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);



#7. Display the branch numbers and the total count of employees in each branch. 

SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no;




#8. Display the names of customers who have issued books in the month of June 2023. 
SELECT Customer.Customer_name 
FROM IssueStatus 
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id 
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';



#9. Retrieve book_title from book table containing history. 
SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%History%';




#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees 
#Adding more employees
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES 
(7, 'Christopher Adams', 'Assistant Librarian', 45000, 101),
(8, 'Jessica Roberts', 'Librarian', 52000, 102),
(9, 'Daniel Hernandez', 'Library Clerk', 38000, 103),
(10, 'Laura Peterson', 'Senior Librarian', 60000, 101),
(11, 'Matthew Brooks', 'Library Assistant', 41000, 102),
(12, 'Olivia Evans', 'Librarian', 55000, 103),
(13, 'William Scott', 'Library Technician', 47000, 101),
(14, 'Sophia Mitchell', 'Library Coordinator', 63000, 102),
(15, 'Benjamin Carter', 'Archivist', 59000, 103),
(16, 'Emma Collins', 'Library Catalog Specialist', 49000, 101);

SELECT Branch_no, COUNT(*) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(*) > 5;



#11. Retrieve the names of employees who manage branches and their respective branch addresses. 
SELECT Employee.Emp_name, Branch.Branch_address 
FROM Employee 
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;



#12. Display the names of customers who have issued books with a rental price higher than Rs. 25.
#Adding more data
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES 
(204, 1002, 'Introduction to Algorithms', '2023-07-10', '978-0321356680'); 

SELECT Customer.Customer_name 
FROM IssueStatus 
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN 
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id 
WHERE Books.Rental_Price > 25;



