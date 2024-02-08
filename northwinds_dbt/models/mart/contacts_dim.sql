{{ config(materialized='table') }}

with contacts as (
   select * from {{ ref('int_contacts') }}
),
companies as (
   select * from {{ ref('int_companies') }}
),
 final as (
    select contact_pk, first_name, last_name, phone, company_pk from contacts join companies on 
  companies.rds_company_id = contacts.rds_company_id or companies.hubspot_company_id = contacts.hubspot_company_id
)
select * from final