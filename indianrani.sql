-- Query 1: Find the top 5 customers with the highest point balances.
SELECT TOP 5 ID, Name, Point_Balance
FROM [dbo].[indianrani.com]
ORDER BY Point_Balance DESC;

-- Query 2: Calculate the average point balance for each gender.
SELECT Gender, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Gender;

-- Query 3: Identify the countries with the most confirmed email addresses.
SELECT Country, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Country
ORDER BY ConfirmedEmailCount DESC;

-- Query 4: Calculate the total number of customers in each account creation source.
SELECT Account_Created_in, COUNT(*) AS CustomerCount
FROM [dbo].[indianrani.com]
GROUP BY Account_Created_in;

-- Query 5: Find the customers who have both billing and shipping addresses in the same city.
SELECT ID, Name
FROM [dbo].[indianrani.com]
WHERE Billing_Address LIKE '%' + City + '%' AND Shipping_Address LIKE '%' + City + '%';

-- Query 6: Calculate the average age of customers based on their provided birth dates.
SELECT Gender, AVG(DATEDIFF(YEAR, CONVERT(DATE, Date_of_Birth), GETDATE())) AS AvgAge
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1
GROUP BY Gender;

-- Query 7: Find the customers who have provided both VAT and Tax numbers.
SELECT ID, Name, VAT_Number, Tax_VAT_Number
FROM [dbo].[indianrani.com]
WHERE VAT_Number IS NOT NULL AND Tax_VAT_Number IS NOT NULL;

-- Query 8: Calculate the total number of customers in each state/province.
SELECT State_province, COUNT(*) AS CustomerCount
FROM [dbo].[indianrani.com]
GROUP BY State_province
ORDER BY CustomerCount DESC;

-- Query 9: Identify the groups with the highest number of customers who have confirmed emails.
SELECT Group, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Group
ORDER BY ConfirmedEmailCount DESC;

-- Query 10: Calculate the percentage of customers who have locked accounts in each country.
SELECT Country, AVG(CASE WHEN Account_Lock = 'Locked' THEN 1 ELSE 0 END) * 100 AS LockedAccountPercentage
FROM [dbo].[indianrani.com]
GROUP BY Country;

-- Query 11: Calculate the total number of customers in each city.
SELECT City, COUNT(*) AS CustomerCount
FROM [dbo].[indianrani.com]
GROUP BY City
ORDER BY CustomerCount DESC;

-- Query 12: Find the customers who have the same billing and shipping addresses.
SELECT ID, Name
FROM [dbo].[indianrani.com]
WHERE Billing_Address = Shipping_Address;

-- Query 13: Identify the top 3 states/provinces with the highest average point balances.
SELECT TOP 3 State_province, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY State_province
ORDER BY AvgPointBalance DESC;

-- Query 14: Calculate the average point balance for each customer group.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Group;

-- Query 15: Find the customers who were born on a leap day.
SELECT ID, Name, Date_of_Birth
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1
      AND DATEPART(DAYOFYEAR, CONVERT(DATE, Date_of_Birth)) = 60;

-- Query 16: Calculate the percentage of customers with confirmed emails in each country.
SELECT Country, AVG(CASE WHEN Confirmed_email = 'Yes' THEN 1 ELSE 0 END) * 100 AS ConfirmedEmailPercentage
FROM [dbo].[indianrani.com]
GROUP BY Country;

-- Query 17: Identify the customers with the highest point balances in each state/province.
WITH RankedCustomers AS (
  SELECT *, RANK() OVER(PARTITION BY State_province ORDER BY Point_Balance DESC) AS RankPointBalance
  FROM [dbo].[indianrani.com]
)
SELECT ID, Name, State_province, Point_Balance
FROM RankedCustomers
WHERE RankPointBalance = 1;

-- Query 18: Calculate the average point balance for each customer's confirmed email status.
SELECT Confirmed_email, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Confirmed_email;

-- Query 19: Find customers who have both VAT numbers and Tax numbers provided.
SELECT ID, Name, VAT_Number, Tax_VAT_Number
FROM [dbo].[indianrani.com]
WHERE VAT_Number IS NOT NULL AND Tax_VAT_Number IS NOT NULL;

-- Query 20: Calculate the median point balance for each gender.
SELECT Gender,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Point_Balance) AS MedianPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Gender;

-- Query 21: Identify the cities with the highest number of customers who have locked accounts.
SELECT City, COUNT(*) AS LockedAccountCount
FROM [dbo].[indianrani.com]
WHERE Account_Lock = 'Locked'
GROUP BY City
ORDER BY LockedAccountCount DESC;

-- Query 22: Calculate the average point balance for customers in each account creation source.
SELECT Account_Created_in, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Account_Created_in;

-- Query 23: Find the customers who have created accounts using email addresses from a specific website.
SELECT ID, Name, Account_Created_in
FROM [dbo].[indianrani.com]
WHERE Account_Created_in LIKE '%gmail.com';

-- Query 24: Calculate the average point balance for customers who have provided their date of birth.
SELECT AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1;

-- Query 25: Identify the top 5 customer groups with the highest average point balances.
SELECT TOP 5 Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Group
ORDER BY AvgPointBalance DESC;

-- Query 26: Calculate the average point balance for customers in each state/province.
SELECT State_province, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY State_province;

-- Query 27: Find customers who have provided either VAT numbers or Tax numbers.
SELECT ID, Name, VAT_Number, Tax_VAT_Number
FROM [dbo].[indianrani.com]
WHERE VAT_Number IS NOT NULL OR Tax_VAT_Number IS NOT NULL;

-- Query 28: Calculate the number of customers with confirmed emails in each account creation source.
SELECT Account_Created_in, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Account_Created_in;

-- Query 29: Identify the customers with the highest point balances for each gender.
SELECT Gender, ID, Name, Point_Balance
FROM (
  SELECT Gender, ID, Name, Point_Balance,
         RANK() OVER(PARTITION BY Gender ORDER BY Point_Balance DESC) AS RankPointBalance
  FROM [dbo].[indianrani.com]
) RankedCustomers
WHERE RankPointBalance = 1;

-- Query 30: Calculate the average point balance for customers in each customer group.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Group;

-- Query 31: Find customers who have provided a valid date of birth (ignoring placeholders).
SELECT ID, Name, Date_of_Birth
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1
      AND Date_of_Birth NOT IN ('0', '9');

-- Query 32: Calculate the total number of customers with confirmed emails in each gender.
SELECT Gender, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Gender;

-- Query 33: Identify the states/provinces with the highest average point balances for male customers.
SELECT State_province, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Gender = 'Male'
GROUP BY State_province
ORDER BY AvgPointBalance DESC;

-- Query 34: Calculate the percentage of customers with locked accounts in each country.
SELECT Country, AVG(CASE WHEN Account_Lock = 'Locked' THEN 1 ELSE 0 END) * 100 AS LockedAccountPercentage
FROM [dbo].[indianrani.com]
GROUP BY Country;

-- Query 35: Find the customers who have the same billing and shipping addresses in a specific country.
SELECT ID, Name, Country
FROM [dbo].[indianrani.com]
WHERE Billing_Address = Shipping_Address AND Country = 'India';

-- Query 36: Calculate the average point balance for each customer group.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Group;

-- Query 37: Identify the top 3 customer groups with the highest total point balances.
SELECT TOP 3 Group, SUM(Point_Balance) AS TotalPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Group
ORDER BY TotalPointBalance DESC;

-- Query 38: Calculate the average point balance for customers with confirmed emails in each city.
SELECT City, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY City;

-- Query 39: Find the customers with the lowest point balances in each state/province.
WITH RankedCustomers AS (
  SELECT *, RANK() OVER(PARTITION BY State_province ORDER BY Point_Balance) AS RankPointBalance
  FROM [dbo].[indianrani.com]
)
SELECT ID, Name, State_province, Point_Balance
FROM RankedCustomers
WHERE RankPointBalance = 1;

-- Query 40: Calculate the average point balance for each state/province in a specific country.
SELECT State_province, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Country = 'India'
GROUP BY State_province;

-- Query 41: Identify the cities with the highest number of customers who provided their tax information.
SELECT City, COUNT(*) AS TaxInformationCount
FROM [dbo].[indianrani.com]
WHERE Tax_VAT_Number = '1'
GROUP BY City
ORDER BY TaxInformationCount DESC;

-- Query 42: Calculate the average point balance for customers who have confirmed emails in each customer group.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Group;

-- Query 43: Find the customers who have the lowest point balances in a specific country.
SELECT ID, Name, Country, Point_Balance
FROM [dbo].[indianrani.com]
WHERE Country = 'India'
ORDER BY Point_Balance ASC;

-- Query 44: Calculate the average point balance for each city where customers have locked accounts.
SELECT City, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Account_Lock = 'Locked'
GROUP BY City;

-- Query 45: Identify the customer groups with the highest average point balances for female customers.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Gender = 'Female'
GROUP BY Group
ORDER BY AvgPointBalance DESC;

-- Query 46: Calculate the percentage of customers with confirmed emails in each state/province.
SELECT State_province, AVG(CASE WHEN Confirmed_email = 'Yes' THEN 1 ELSE 0 END) * 100 AS ConfirmedEmailPercentage
FROM [dbo].[indianrani.com]
GROUP BY State_province;

-- Query 47: Find customers who have provided both their VAT numbers and Tax numbers.
SELECT ID, Name, VAT_Number, Tax_VAT_Number
FROM [dbo].[indianrani.com]
WHERE VAT_Number = '1' AND Tax_VAT_Number = '1';

-- Query 48: Calculate the average point balance for customers who were born in each month.
SELECT MONTH(Date_of_Birth) AS BirthMonth, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1
GROUP BY MONTH(Date_of_Birth);

-- Query 49: Identify the top 5 cities with the highest number of customers who have confirmed emails.
SELECT TOP 5 City, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY City
ORDER BY ConfirmedEmailCount DESC;

-- Query 50: Calculate the average point balance for customers with locked accounts in each customer group.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Account_Lock = 'Locked'
GROUP BY Group;

-- Query 51: Find customers who have created accounts using a specific website.
SELECT ID, Name, Account_Created_in
FROM [dbo].[indianrani.com]
WHERE Account_Created_in LIKE '%amazon.com';

-- Query 52: Calculate the average point balance for customers who have provided their date of birth and confirmed emails.
SELECT AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1 AND Confirmed_email = 'Yes';

-- Query 53: Identify the cities with the highest average point balances for male customers.
SELECT City, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Gender = 'Male'
GROUP BY City
ORDER BY AvgPointBalance DESC;

-- Query 54: Calculate the average point balance for customers who have both VAT numbers and Tax numbers.
SELECT AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE VAT_Number = '1' AND Tax_VAT_Number = '1';

-- Query 55: Find the customers with the highest point balances in a specific country.
SELECT ID, Name, Country, Point_Balance
FROM [dbo].[indianrani.com]
WHERE Country = 'India'
ORDER BY Point_Balance DESC;

-- Query 56: Calculate the average point balance for each customer group in a specific state/province.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE State_province = 'California'
GROUP BY Group;

-- Query 57: Identify the states/provinces with the highest percentage of locked accounts.
SELECT State_province, AVG(CASE WHEN Account_Lock = 'Locked' THEN 1 ELSE 0 END) * 100 AS LockedAccountPercentage
FROM [dbo].[indianrani.com]
GROUP BY State_province;

-- Query 58: Calculate the total number of customers with confirmed emails in each state/province.
SELECT State_province, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY State_province
ORDER BY ConfirmedEmailCount DESC;

-- Query 59: Find the customers who were born in each month and have confirmed emails.
SELECT MONTH(Date_of_Birth) AS BirthMonth, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1 AND Confirmed_email = 'Yes'
GROUP BY MONTH(Date_of_Birth)
ORDER BY BirthMonth;

-- Query 60: Calculate the average point balance for customers with locked accounts in each city.
SELECT City, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Account_Lock = 'Locked'
GROUP BY City;

-- Query 61: Identify the customer groups with the highest total point balances for male customers.
SELECT Group, SUM(Point_Balance) AS TotalPointBalance
FROM [dbo].[indianrani.com]
WHERE Gender = 'Male'
GROUP BY Group
ORDER BY TotalPointBalance DESC;

-- Query 62: Calculate the average point balance for customers with confirmed emails in each country.
SELECT Country, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Country;

-- Query 63: Find customers who have both VAT numbers and Tax numbers provided.
SELECT ID, Name, VAT_Number, Tax_VAT_Number
FROM [dbo].[indianrani.com]
WHERE VAT_Number IS NOT NULL AND Tax_VAT_Number IS NOT NULL;

-- Query 64: Calculate the average point balance for each state/province in a specific country.
SELECT State_province, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Country = 'India'
GROUP BY State_province;

-- Query 65: Identify the cities with the highest number of customers who have locked accounts.
SELECT City, COUNT(*) AS LockedAccountCount
FROM [dbo].[indianrani.com]
WHERE Account_Lock = 'Locked'
GROUP BY City
ORDER BY LockedAccountCount DESC;

-- Query 66: Calculate the average point balance for customers who have confirmed emails in each customer group.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Group;

-- Query 67: Find the customers who have created accounts using email addresses from a specific website.
SELECT ID, Name, Account_Created_in
FROM [dbo].[indianrani.com]
WHERE Account_Created_in LIKE '%yahoo.com';

-- Query 68: Calculate the average point balance for customers who provided a valid date of birth (ignoring placeholders).
SELECT AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1 AND Date_of_Birth NOT IN ('0', '9');

-- Query 69: Identify the top 5 customer groups with the highest average point balances.
SELECT TOP 5 Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Group
ORDER BY AvgPointBalance DESC;

-- Query 70: Calculate the average point balance for customers in each state/province.
SELECT State_province, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY State_province;

-- Query 71: Find customers who have provided either VAT numbers or Tax numbers.
SELECT ID, Name, VAT_Number, Tax_VAT_Number
FROM [dbo].[indianrani.com]
WHERE VAT_Number IS NOT NULL OR Tax_VAT_Number IS NOT NULL;

-- Query 72: Calculate the number of customers with confirmed emails in each gender.
SELECT Gender, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Gender;

-- Query 73: Identify the states/provinces with the highest average point balances for female customers.
SELECT State_province, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Gender = 'Female'
GROUP BY State_province
ORDER BY AvgPointBalance DESC;

-- Query 74: Calculate the percentage of customers with locked accounts in each country.
SELECT Country, AVG(CASE WHEN Account_Lock = 'Locked' THEN 1 ELSE 0 END) * 100 AS LockedAccountPercentage
FROM [dbo].[indianrani.com]
GROUP BY Country;

-- Query 75: Find the customers who have the same billing and shipping addresses in a specific country.
SELECT ID, Name, Country
FROM [dbo].[indianrani.com]
WHERE Billing_Address = Shipping_Address AND Country = 'India';

-- Query 76: Calculate the average point balance for customers with locked accounts in each customer group.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Account_Lock = 'Locked'
GROUP BY Group;

-- Query 77: Identify the top 3 customer groups with the highest total point balances.
SELECT TOP 3 Group, SUM(Point_Balance) AS TotalPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Group
ORDER BY TotalPointBalance DESC;

-- Query 78: Calculate the average point balance for customers with confirmed emails in each city.
SELECT City, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY City;

-- Query 79: Find customers who have created accounts using a specific website.
SELECT ID, Name, Account_Created_in
FROM [dbo].[indianrani.com]
WHERE Account_Created_in LIKE '%hotmail.com';

-- Query 80: Calculate the average point balance for customers who have provided their date of birth and confirmed emails.
SELECT AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1 AND Confirmed_email = 'Yes';

-- Query 81: Identify the cities with the highest average point balances for male customers.
SELECT City, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Gender = 'Male'
GROUP BY City
ORDER BY AvgPointBalance DESC;

-- Query 82: Calculate the average point balance for customers who have both VAT numbers and Tax numbers.
SELECT AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE VAT_Number = '1' AND Tax_VAT_Number = '1';

-- Query 83: Find the customers with the highest point balances in a specific country.
SELECT ID, Name, Country, Point_Balance
FROM [dbo].[indianrani.com]
WHERE Country = 'India'
ORDER BY Point_Balance DESC;

-- Query 84: Calculate the average point balance for each customer group in a specific state/province.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE State_province = 'California'
GROUP BY Group;

-- Query 85: Identify the states/provinces with the highest percentage of locked accounts.
SELECT State_province, AVG(CASE WHEN Account_Lock = 'Locked' THEN 1 ELSE 0 END) * 100 AS LockedAccountPercentage
FROM [dbo].[indianrani.com]
GROUP BY State_province;

-- Query 86: Calculate the total number of customers with confirmed emails in each state/province.
SELECT State_province, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY State_province
ORDER BY ConfirmedEmailCount DESC;

-- Query 87: Find the customers who were born in each month and have confirmed emails.
SELECT MONTH(Date_of_Birth) AS BirthMonth, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1 AND Confirmed_email = 'Yes'
GROUP BY MONTH(Date_of_Birth)
ORDER BY BirthMonth;

-- Query 88: Calculate the average point balance for customers with locked accounts in each city.
SELECT City, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Account_Lock = 'Locked'
GROUP BY City;

-- Query 89: Identify the customer groups with the highest total point balances for male customers.
SELECT Group, SUM(Point_Balance) AS TotalPointBalance
FROM [dbo].[indianrani.com]
WHERE Gender = 'Male'
GROUP BY Group
ORDER BY TotalPointBalance DESC;

-- Query 90: Calculate the average point balance for customers with confirmed emails in each country.
SELECT Country, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Country;

-- Query 91: Find customers who have both VAT numbers and Tax numbers provided.
SELECT ID, Name, VAT_Number, Tax_VAT_Number
FROM [dbo].[indianrani.com]
WHERE VAT_Number IS NOT NULL AND Tax_VAT_Number IS NOT NULL;

-- Query 92: Calculate the average point balance for each state/province in a specific country.
SELECT State_province, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Country = 'India'
GROUP BY State_province;

-- Query 93: Identify the cities with the highest number of customers who have locked accounts.
SELECT City, COUNT(*) AS LockedAccountCount
FROM [dbo].[indianrani.com]
WHERE Account_Lock = 'Locked'
GROUP BY City
ORDER BY LockedAccountCount DESC;

-- Query 94: Calculate the average point balance for customers who have confirmed emails in each customer group.
SELECT Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Group;

-- Query 95: Find the customers who have created accounts using email addresses from a specific website.
SELECT ID, Name, Account_Created_in
FROM [dbo].[indianrani.com]
WHERE Account_Created_in LIKE '%outlook.com';

-- Query 96: Calculate the average point balance for customers who provided a valid date of birth (ignoring placeholders).
SELECT AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
WHERE ISDATE(Date_of_Birth) = 1 AND Date_of_Birth NOT IN ('0', '9');

-- Query 97: Identify the top 5 customer groups with the highest average point balances.
SELECT TOP 5 Group, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY Group
ORDER BY AvgPointBalance DESC;

-- Query 98: Calculate the average point balance for customers in each state/province.
SELECT State_province, AVG(Point_Balance) AS AvgPointBalance
FROM [dbo].[indianrani.com]
GROUP BY State_province;

-- Query 99: Find customers who have provided either VAT numbers or Tax numbers.
SELECT ID, Name, VAT_Number, Tax_VAT_Number
FROM [dbo].[indianrani.com]
WHERE VAT_Number IS NOT NULL OR Tax_VAT_Number IS NOT NULL;

-- Query 100: Calculate the number of customers with confirmed emails in each gender.
SELECT Gender, COUNT(*) AS ConfirmedEmailCount
FROM [dbo].[indianrani.com]
WHERE Confirmed_email = 'Yes'
GROUP BY Gender;
