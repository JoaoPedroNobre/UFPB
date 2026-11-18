-- Q1. Liste o nome dos produtos com suas respectivas categorias.
SELECT produtos.nome, categorias.nome
FROM produtos
JOIN categorias ON produtos.id_categoria = categorias.id_categoria;

--Q2. Liste o número do pedido, o nome da empresa compradora e o telefone de contato.
SELECT pedidos.numeropedido, clientes.nomedaempresa, clientes.telefone
FROM pedidos
JOIN clientes ON pedidos.id_cliente = clientes.id_cliente;

--Q3. Apresente as categorias e a quantidade total de produtos dessas categorias.
SELECT categorias.nome, COUNT(produtos.id_produto)
FROM categorias
JOIN produtos ON categorias.id_categoria = produtos.id_categoria
GROUP BY categorias.id_categoria, categorias.nome;

--Q4 Apresente uma lista contendo o número do pedido e seus itens de pedido com o nome do produto 
--e o valor vendido. 
SELECT itempedidos.numeropedido, produtos.nome,
       itempedidos.precounitario * itempedidos.quantidade *
       (1 - itempedidos.desconto) AS valor_vendido
FROM itempedidos
JOIN produtos ON itempedidos.id_produto = produtos.id_produto;

--Q5.Apresente os nomes das empresas compradoras e a quantidade de pedidos realizados.  
--Apenas as empresas que realizaram mais de 20 pedidos devem ser mostradas.
SELECT clientes.nomedaempresa, COUNT(*)
FROM clientes
JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.id_cliente, clientes.nomedaempresa
HAVING COUNT(*) > 20;

--Q6.Apresente os nomes das empresas brasileiras e a quantidade de pedidos realizados apenas no mês de junho. 
SELECT clientes.nomedaempresa, COUNT(*)
FROM clientes
JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
WHERE clientes.pais = 'Brasil'
AND EXTRACT(MONTH FROM pedidos.datadopedido) = 6
GROUP BY clientes.id_cliente, clientes.nomedaempresa;

--Q7. Liste os nomes das empresas com maiores valores de frete.
SELECT clientes.nomedaempresa, SUM(pedidos.frete) AS total_frete
FROM clientes
JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.id_cliente, clientes.nomedaempresa
ORDER BY total_frete DESC;

--Q8. Liste os nomes dos produtos mais vendidos.
SELECT produtos.nome, SUM(itempedidos.quantidade) AS total_vendido
FROM produtos
JOIN itempedidos ON produtos.id_produto = itempedidos.id_produto
GROUP BY produtos.id_produto, produtos.nome
ORDER BY total_vendido DESC;

--Q9. Qual a categoria de produtos que mais traz receita para a empresa?
SELECT categorias.nome,
       SUM(itempedidos.precounitario * itempedidos.quantidade *
           (1 - itempedidos.desconto)) AS receita
FROM categorias
JOIN produtos ON categorias.id_categoria = produtos.id_categoria
JOIN itempedidos ON produtos.id_produto = itempedidos.id_produto
GROUP BY categorias.id_categoria, categorias.nome
ORDER BY receita DESC
LIMIT 1;
