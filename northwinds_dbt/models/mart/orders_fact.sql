{{ config(materialized='table') }}

WITH int_orders AS (
    SELECT * FROM {{ref('int_orders')}}
), 
int_contacts AS (
    SELECT * FROM {{ref('int_contacts')}}
),
final AS (
    SELECT 
    int_orders.order_pk, int_contacts.contact_pk, int_orders.order_date, int_orders.product_id,
     int_orders.employee_id, int_orders.quantity, int_orders.discount, int_orders.unit_price
    FROM int_orders
    JOIN int_contacts
        ON int_contacts.rds_contact_id = int_orders.customer_id
        OR int_contacts.hubspot_contact_id = int_orders.customer_id
    ORDER BY order_date 
)

SELECT * FROM final