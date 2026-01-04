-- Create the storage integration with S3
CREATE OR REPLACE STORAGE INTEGRATION SCD1_INT
TYPE = EXTERNAL_STAGE
ENABLED = TRUE
STORAGE_PROVIDER = 'S3'
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::778277577883:role/dea-scd1project-snowflake-role'
STORAGE_ALLOWED_LOCATIONS = ('s3://dea-scd1project-data-bucket-001/data/');

-- Describe new integration to get the AWS User ARN and External ID
DESC INTEGRATION SCD1_INT;
