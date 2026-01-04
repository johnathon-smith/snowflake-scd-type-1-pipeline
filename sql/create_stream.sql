-- Now create the stream on the customer_source table
CREATE OR REPLACE STREAM SCD1_DB.PUBLIC.SCD1_STREAM
ON TABLE SCD1_DB.PUBLIC.CUSTOMER_SOURCE
APPEND_ONLY = TRUE;

-- Verify stream exists
SHOW STREAMS;

-- Verify stream exists
SELECT * FROM SCD1_DB.PUBLIC.SCD1_STREAM;
