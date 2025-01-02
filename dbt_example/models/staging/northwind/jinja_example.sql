-- query comum
select *
from vendas
where data_venda >= '2023-09-01'

-- query com jinja
select *
from vendas
where data_venda >= '{{ var("data_venda") }}'

-- query com jinja e execute_at 
-- execute_at é uma variável que retorna a data de execução do dbt
-- as_timestamp é uma função que converte a data para o formato timestamp
-- strftime é uma função que formata a data
select *
from vendas
where data_venda >= '{{ (execute_at | as_timestamp).strftime("%Y-%m-01") }}'

-- loop com jinja
SELECT 
    cliente_id,
    {% for mes in range(1, 13) %}
        SUM(CASE WHEN EXTRACT(MONTH FROM data_venda) = {{ mes }} THEN valor END) AS valor_mes_{{ mes }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM vendas
GROUP BY cliente_id

-- condição com jinja

SELECT *
FROM vendas
WHERE 
    {% if flag_ativo == true %}
        data_venda >= CURRENT_DATE - INTERVAL '30' DAY
    {% else %}
        data_venda IS NOT NULL
    {% endif %}