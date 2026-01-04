-- Create a task to run the stored procedure created in the other worksheet
CREATE OR REPLACE TASK SCD1_DB.PUBLIC.CUSTOMER_TASK
WAREHOUSE = COMPUTE_WH
SCHEDULE = '1 MINUTE'
WHEN SYSTEM$STREAM_HAS_DATA('SCD1_DB.PUBLIC.SCD1_STREAM')
AS CALL SCD1_DB.PUBLIC.CUSTOMER_SP();

-- Now start the task by altering it
ALTER TASK SCD1_DB.PUBLIC.CUSTOMER_TASK RESUME;

-- Now verify that the task is in the started state
SHOW TASKS;
