WITH customers as (
  SELECT * FROM {{ source('rds', 'customers') }}
), companies as (
    select * from {{ ref('stg_rds_companies') }}
),
renamed as (
    SELECT 
    concat('rds-', customer_id) as customer_id, 
    SPLIT_PART(contact_name, ' ', 1) as first_name,
    SPLIT_PART(contact_name, ' ', -1) as last_name,
    REPLACE(TRANSLATE(phone, '(,),-,.', ''), ' ', '') as updated_phone,
    company_id
    FROM customers 
    join companies on customers.company_name = companies.name
)
SELECT * FROM renamed


