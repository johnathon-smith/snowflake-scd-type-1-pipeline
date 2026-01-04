-- Before update, customer table should only have 80 records.
-- After update, customer table should have 81 records (one new custoemr was added)
SELECT COUNT(*) FROM SCD1_DB.PUBLIC.CUSTOMER;

-- Before the update, this customer's phone number is 5085552555
-- After the update, this customer's phone number is (171) 555-2282
SELECT * FROM SCD1_DB.PUBLIC.CUSTOMER
WHERE
CONTACTFIRSTNAME = 'Elizabeth' 
AND 
CONTACTLASTNAME ='Yu';

-- Before the update, this customer's city is NYC
-- After the update, this customer's city is Norflox
SELECT * FROM SCD1_DB.PUBLIC.CUSTOMER
WHERE
CONTACTFIRSTNAME = 'Kyung' 
AND 
CONTACTLASTNAME ='Benitez';

-- Before the update, this customer does not exist
-- After the update, this customer now exists
SELECT * FROM SCD1_DB.PUBLIC.CUSTOMER
WHERE
CONTACTFIRSTNAME = 'John' 
AND 
CONTACTLASTNAME ='Wick';
