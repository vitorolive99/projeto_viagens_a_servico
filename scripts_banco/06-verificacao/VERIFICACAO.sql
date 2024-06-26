
--Gastos por orgao superior
SELECT O.COD_ORGAO_SUPERIOR, O.NOME, SUM(V.VALOR_PASSAGEM) AS GASTOS_COM_PASSAGEM, SUM(V.VALOR_DIARIA) AS GASTOS_COM_DIARIAS, SUM(V.VALOR_OUTROS) AS OUTROS, SUM(V.VALOR_TOTAL) AS TOTAL
FROM FATO_VIAGEM V INNER JOIN DIM_ORGAO_SUPERIOR O
ON (V.ID_ORGAO_SUPERIOR = O.ID)
GROUP BY O.NOME, O.COD_ORGAO_SUPERIOR
ORDER BY O.NOME, O.COD_ORGAO_SUPERIOR

--Gastos por entidade vinculada
SELECT E.COD_ENTIDADE_VINCULADA, E.NOME, SUM(V.VALOR_PASSAGEM) AS GASTOS_COM_PASSAGEM, SUM(V.VALOR_DIARIA) AS GASTOS_COM_DIARIAS, SUM(V.VALOR_OUTROS) AS OUTROS, SUM(V.VALOR_TOTAL) AS TOTAL
FROM FATO_VIAGEM V INNER JOIN DIM_ENTIDADE_VINCULADA E
ON (V.ID_ORGAO_SUPERIOR = E.ID)
GROUP BY E.NOME, E.COD_ENTIDADE_VINCULADA
ORDER BY E.NOME, E.COD_ENTIDADE_VINCULADA

--Gastos por destino
SELECT T.CIDADE_DESTINO, SUM(V.VALOR_PASSAGEM) AS GASTOS_COM_PASSAGEM, SUM(V.VALOR_DIARIA) AS GASTOS_COM_DIARIAS, SUM(V.VALOR_OUTROS) AS OUTROS, SUM(V.VALOR_TOTAL) AS TOTAL
FROM FATO_VIAGEM V INNER JOIN DIM_TRAJETO T
ON (V.ID_ORGAO_SUPERIOR = T.ID)
GROUP BY T.CIDADE_DESTINO
ORDER BY T.CIDADE_DESTINO

--Trajetos mais realizados e a media de gastos
SELECT T.UF_ORIGEM, T.CIDADE_ORIGEM, T.UF_DESTINO, T.CIDADE_DESTINO, COUNT(V.QUANTIDADE) AS QUANTIDADE, ROUND(AVG(V.VALOR_PASSAGEM),2) AS MEDIA_DO_VALOR_DAS_PASSAGENS, ROUND(AVG(V.VALOR_DIARIA),2) AS MEDIA_DO_VALOR_DAS_DIARIAS, ROUND(AVG(V.VALOR_TOTAL),2) AS MEDIA_DOS_GASTOS_TOTAIS
FROM FATO_VIAGEM V INNER JOIN DIM_TRAJETO T
ON (V.ID_ORGAO_SUPERIOR = T.ID)
GROUP BY  T.UF_ORIGEM, T.CIDADE_ORIGEM, T.UF_DESTINO, T.CIDADE_DESTINO
ORDER BY QUANTIDADE DESC

--Gastos por pessoa
SELECT P.CPF, P.NOME, SUM(V.VALOR_PASSAGEM) AS GASTOS_COM_PASSAGENS, SUM(V.VALOR_DIARIA) AS GASTOS_COM_DIARIAS, SUM(V.VALOR_OUTROS) AS OUTROS, SUM(V.VALOR_TOTAL) AS TOTAL
FROM FATO_VIAGEM V INNER JOIN DIM_PESSOA P
ON (V.ID_PESSOA = P.ID)
GROUP BY P.CPF, P.NOME
ORDER BY TOTAL DESC, P.NOME, P.CPF

--Viagens realizadas por localidade (NACIONAL) 
SELECT L.UF, L.CIDADE, COUNT(V.QUANTIDADE) AS NUMERO_DE_VIAGENS
FROM FATO_VIAGEM V INNER JOIN DIM_LOCALIDADE L
ON (V.ID_LOCALIDADE = L.ID) -- Corrigido o alias de DIM_LOCALIDADE
WHERE L.UF IS NOT NULL
GROUP BY L.UF, L.CIDADE -- Ordem alterada para corresponder � cl�usula ORDER BY
ORDER BY NUMERO_DE_VIAGENS DESC, L.UF, L.CIDADE

--Distribuicao de gastos por tipo de viagem
SELECT T.NOME, SUM(V.VALOR_PASSAGEM) AS GASTOS_COM_PASSAGENS, SUM(V.VALOR_DIARIA) AS GASTOS_COM_DIARIAS, SUM(V.VALOR_OUTROS) AS OUTROS, SUM(V.VALOR_TOTAL) AS TOTAL
FROM FATO_VIAGEM V INNER JOIN DIM_TIPO T
ON (V.ID_TIPO = T.ID)
GROUP BY T.NOME
ORDER BY TOTAL DESC, T.NOME

--Distribuicao de gastos por cargo
SELECT C.NOME, SUM(V.VALOR_PASSAGEM) AS GASTOS_COM_PASSAGENS, SUM(V.VALOR_DIARIA) AS GASTOS_COM_DIARIAS, SUM(V.VALOR_OUTROS) AS OUTROS, SUM(V.VALOR_TOTAL) AS TOTAL
FROM FATO_VIAGEM V INNER JOIN DIM_CARGO C
ON (V.ID_CARGO = C.ID)
GROUP BY C.NOME
ORDER BY TOTAL DESC, C.NOME