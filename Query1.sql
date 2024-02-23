---------------------Venda Por Categoria------------------------------
SELECT
    c.category_name,
    SUM(ROUND(od.unit_price * (1 - od.discount) * od.quantity)) AS order_price
FROM
    categories c
    INNER JOIN products p ON c.category_id = p.category_id
    INNER JOIN order_details od ON p.product_id = od.product_id
    INNER JOIN orders o ON od.order_id = o.order_id
GROUP BY
    c.category_name
ORDER BY
    c.category_name
LIMIT 5000;

---------------------Venda Por empregado------------------------------
select 
	e.first_name,
	SUM(ROUND(od.unit_price * (1 - od.discount) * od.quantity)) AS order_price
from
	employees e
	inner join orders o on e.employee_id = o.employee_id
	inner join order_details od on o.order_id = od.order_id
group by
	e.first_name
order by order_price desc;

---------------------Fornecedores mais frequentes------------------------------
select *
from suppliers;

select
	s.company_name,
	sum(p.units_on_order) as units_on_order,
	sum(p.units_in_stock) as units_in_stock
from suppliers s
	inner join products p on s.supplier_id = p.supplier_id
group by
	s.company_name
order by
	units_on_order desc;
	
---------------------Clientes mais valiosos------------------------------

select *
from customers;

select 
	c.company_name,
	count(o.order_id) as frequency,
	ROUND(SUM(CAST(od.unit_price * (1 - od.discount) * od.quantity AS numeric)), 2) AS order_price --Aqui o resultado da multriplicação foi convertido para numeric a fim de que o round funcione corretamente
from customers c
	inner join orders o on c.customer_id = o.customer_id
	inner join order_details od on o.order_id = od.order_id
group by
	c.company_name
order by
	order_price desc,
	frequency desc,
	c.company_name;
	
---------------------Inventário e reabastecimento------------------------------
select *
from products;

select
	product_name,
	units_in_stock
from products
where units_in_stock <= 25
order by units_in_stock desc;

---------------------Produtos mais vendidos------------------------------
SELECT
    p.Product_Name,
    SUM(od.Quantity) as TotalVendido
FROM
    Products p
    INNER JOIN order_Details od ON p.Product_ID = od.Product_ID
    INNER JOIN Orders o ON od.Order_ID = o.Order_ID
GROUP BY
    p.Product_Name
ORDER BY
    TotalVendido DESC
limit 10;