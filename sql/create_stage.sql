-- Now create a new stage that utilizes the S3 integration
CREATE OR REPLACE STAGE SCD1_DB.PUBLIC.SCD1_STAGE
STORAGE_INTEGRATION = SCD1_INT
URL = 's3://dea-scd1project-data-bucket-001/data/';

-- Verify connection established by reading the contents of the S3 bucket
ls @SCD1_DB.PUBLIC.SCD1_STAGE;
