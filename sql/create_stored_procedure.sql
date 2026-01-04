-- Now create the stored procedure that will implement the SCD Type 1 logic
-- It will read data from the customer source table stream, create a temporary table
-- and apply the SCD Type 1 logic to the customer table
CREATE OR REPLACE PROCEDURE SCD1_DB.PUBLIC.CUSTOMER_SP()
RETURNS VARCHAR(50)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
try {

    //Create statement BEGIN, Begins a transaction in the current session
    snowflake.execute({sqlText:`BEGIN TRANSACTION;`});

    //load data from Customer Stream to a temp table
    snowflake.execute({sqlText:`CREATE OR REPLACE TEMPORARY TABLE SCD1_DB.PUBLIC.CUSTOMER_TEMP
    AS
    SELECT
    CONTACTFIRSTNAME,
    CONTACTLASTNAME,
    CUSTOMERNAME,
    PHONE,
    ADDRESSLINE1,
    ADDRESSLINE2,
    CITY,
    STATE,
    POSTALCODE,
    COUNTRY,
    TERRITORY,
    CURRENT_TIMESTAMP(6) AS INSERT_DTS,
    CURRENT_TIMESTAMP(6) AS UPDATE_DTS
    FROM 
    SCD1_DB.PUBLIC.SCD1_STREAM;`});

    //Perfom the required SCD1 logic on the Customer Target table based on the primary column
    snowflake.execute({sqlText:`MERGE INTO SCD1_DB.PUBLIC.CUSTOMER TGT
    USING SCD1_DB.PUBLIC.CUSTOMER_TEMP TMP
    ON TGT.CONTACTFIRSTNAME = TMP.CONTACTFIRSTNAME
    AND TGT.CONTACTLASTNAME = TMP.CONTACTLASTNAME

    WHEN MATCHED THEN UPDATE SET
    TGT.CUSTOMERNAME = TMP.CUSTOMERNAME,
    TGT.PHONE = TMP.PHONE,
    TGT.ADDRESSLINE1 = TMP.ADDRESSLINE1,
    TGT.ADDRESSLINE2 = TMP.ADDRESSLINE2,
    TGT.CITY = TMP.CITY,
    TGT.STATE = TMP.STATE,
    TGT.POSTALCODE = TMP.POSTALCODE,
    TGT.COUNTRY = TMP.COUNTRY,
    TGT.TERRITORY = TMP.TERRITORY,
    TGT.UPDATE_DTS = TMP.UPDATE_DTS

    WHEN NOT MATCHED THEN INSERT
    (
    CONTACTFIRSTNAME,
    CONTACTLASTNAME,
    CUSTOMERNAME,
    PHONE,
    ADDRESSLINE1,
    ADDRESSLINE2,
    CITY,
    STATE,
    POSTALCODE,
    COUNTRY,
    TERRITORY,
    INSERT_DTS,
    UPDATE_DTS
    )
    VALUES
    (
    TMP.CONTACTFIRSTNAME,
    TMP.CONTACTLASTNAME,
    TMP.CUSTOMERNAME,
    TMP.PHONE,
    TMP.ADDRESSLINE1,
    TMP.ADDRESSLINE2,
    TMP.CITY,
    TMP.STATE,
    TMP.POSTALCODE,
    TMP.COUNTRY,
    TMP.TERRITORY,
    TMP.INSERT_DTS,
    TMP.UPDATE_DTS
    );`});

    //Create statement COMMIT, Commits an open transaction in the current session
    snowflake.execute({sqlText:`COMMIT;`});

    //Statement returned for info and debuging purposes
    return "Stored Procedure Executed Successfully";
}


catch (err)
{
    result = 'Error: ' + err;
    snowflake.execute({sqlText:`ROLLBACK;`});
    throw result;
}

$$;

SHOW PROCEDURES;
