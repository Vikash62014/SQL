Select * from bank_loan_data

--Q1.Total Loan Application
SELECT COUNT(id) AS Total_Loan_Applications
FROM bank_loan_data;


--Q2.MTD Loan Application
SELECT COUNT(ID) AS MTD_Application
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--Q3.PMTD Loan Application
SELECT COUNT(ID) AS PMTD_Application
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 ;


--Q4.Total Funded amount 
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data

--Q5.Total Funded amount (MTD)
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--Q6.Total Funded amount (Previous MTD)
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


--Total Amount Received 
SELECT SUM(total_payment) As Toatal_Amt_Received 
FROM bank_loan_data;

--Total Amount Received (MTD)
SELECT SUM(total_payment) As Toatal_Amt_Received_MTD
FROM bank_loan_data
WHERE MONTH(issue_date)= 12 AND YEAR(issue_date) = 2021;

--Total Amount Received (PMTD)
SELECT SUM(total_payment) As Toatal_Amt_Received_PMTD
FROM bank_loan_data
WHERE MONTH(issue_date)= 11 AND YEAR(issue_date) = 2021;

-- Average Interest Rate
SELECT ROUND(AVG(int_rate), 4)*100 AS AVG_Interest_Rate
FROM bank_loan_data;

-- Average Interest Rate(MTD)
SELECT ROUND(AVG(int_rate), 4)*100 AS AVG_Interest_Rate_MTD
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Average Interest Rate(PMTD)
SELECT AVG(int_rate)*100 AS AVG_Interest_Rate_PMTD
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


--AVG DTI
SELECT ROUND(AVG(dti), 4)*100 AS Avg_DTI 
FROM bank_loan_data;

--MTD AVG DTI
SELECT ROUND(AVG(dti), 4)*100 AS MTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--PMTD AVG DTI
SELECT ROUND(AVG(dti), 5)*100 AS PMTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--Good Loan Percentage
SELECT 
(COUNT(CASE WHEN loan_status = 'Fully Paid' or loan_status= 'Current' Then id END)*100.0)/
COUNT(id) AS Good_loan_Percentage
FROM bank_loan_data
;

--Good Loan Applications
SELECT 
COUNT(id) As Good_Loan_Application 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' or loan_status= 'Current';

--Good Loan Funded Amount
SELECT SUM(loan_amount) As Good_Loan_funded_Amt
FROM bank_loan_data
where loan_status in ('Fully Paid', 'Current')

--Good Loan Amount Received
SELECT SUM(total_payment) As Good_loan_amt_Received
FROM bank_loan_data
WHERE loan_status in ('Fully Paid', 'Current');


--BAD Loan Percentage
SELECT COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100.0/
COUNT(id) As Bad_loan_Percentage
FROM bank_loan_data;

--Bad Loan Applications
SELECT COUNT(id)  As Bad_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

--Bad Loan Funded Amount
SELECT SUM(loan_amount) As Bad_Loan_Funded_Amounts
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

--Bad Loan Amount Received
SELECT SUM(total_payment) As Bad_Loan_Amt_Received
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

--Loan Status
--Loan Details
SELECT
        loan_status,
        COUNT(id) AS Total_Loan_Application,
        SUM(total_payment) AS Total_Amt_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        ROUND(AVG(int_rate * 100),2) AS Interest_Rate,
        ROUND(AVG(dti * 100),3) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status

--Loan Status Details By MTD
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

----Loan Status Details By PMTD
SELECT 
	loan_status, 
	SUM(total_payment) AS PMTD_Total_Amount_Received, 
	SUM(loan_amount) AS PMTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 
GROUP BY loan_status;

--MONTH
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amt,
	SUM(total_payment) AS Total_Amt_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

--STATE
SELECT 
	address_state As State,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amt,
	SUM(total_payment) AS Total_Amt_Received
FROM bank_loan_data
GROUP BY address_state
ORDER By COUNT(id) DESC;

--TERM
SELECT 
	term,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amt,
	SUM(total_payment) AS Total_Amt_Received
FROM bank_loan_data
GROUP BY term
ORDER By term ;

--EMPLOYEE LENGTH
SELECT 
	emp_length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amt,
	SUM(total_payment) AS Total_Amt_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER By COUNT(id) DESC;


--PURPOSE
SELECT 
	purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amt,
	SUM(total_payment) AS Total_Amt_Received
FROM bank_loan_data
GROUP BY purpose
ORDER By purpose;

--Home Ownership
SELECT 
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amt,
	SUM(total_payment) AS Total_Amt_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER By COUNT(id) DESC;

--Applying Filters on different Column
SELECT 
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amt,
	SUM(total_payment) AS Total_Amt_Received
FROM bank_loan_data
WHERE grade ='A' AND address_state = 'CA'
GROUP BY home_ownership
ORDER By COUNT(id) DESC;

