{{
    config(
        materialized='incremental'
    )
}}

select
    id_pedido,
    data_criacao,
    data_entrega,
    valor
from pedidos
{% if is_incremental() %}
    where data_criacao >= (select max(data_criacao) from {{ this }})
{% endif %}