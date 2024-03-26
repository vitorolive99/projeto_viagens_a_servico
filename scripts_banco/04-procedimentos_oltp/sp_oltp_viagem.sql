create or alter procedure sp_oltp_viagem(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_VIAGEM
	WHERE @data_carga = DATA_CARGA

	--INSERT PARA PEGAR AS CIDADES DO PRIMEIRO PADRAO DE ARMAZENAMENTO DE DADOS DOS ARQUIVOS DE PASSAGENS
	INSERT INTO TB_AUX_VIAGEM
	SELECT DISTINCT @data_carga, V.DATA, V.ID_PROCESSO_VIAGEM, PG.COD_ORGAO_SUPERIOR, V.CPF, PS.CIDADE_ORIGEM_IDA, PS.CIDADE_DESTINO_IDA, PS.TIPO_PASSAGEM, PG.COD_ORGAO_PAGADOR, V.CARGO, ISNULL(PS.VALOR_PASSAGEM,00.0), ISNULL(V.VALOR_DIARIAS, 00.0), ISNULL(V.VALOR_OUTROS,00.0), (ISNULL(PS.VALOR_PASSAGEM,00.0) + ISNULL(V.VALOR_DIARIAS, 00.0) + ISNULL(V.VALOR_OUTROS,00.0)) AS VALOR_TOTAL
	FROM TB_VIAGENS V INNER JOIN (SELECT ID_PROCESSO_VIAGEM, COD_ORGAO_SUPERIOR, COD_ORGAO_PAGADOR FROM TB_PAGAMENTO) PG
	ON (V.ID_PROCESSO_VIAGEM = PG.ID_PROCESSO_VIAGEM) LEFT JOIN TB_PASSAGEM PS
	ON (V.ID_PROCESSO_VIAGEM = PS.ID_PROCESSO_VIAGEM)


	--SEGUNDO INSERT PARA PEGAR AS CIDADES DO SEGUNDO PADRAO DE ARMAZENAMENTO DE DADOS DOS ARQUIVOS DE PASSAGENS
	INSERT INTO TB_AUX_VIAGEM
	SELECT DISTINCT @data_carga, V.DATA, V.ID_PROCESSO_VIAGEM, PG.COD_ORGAO_SUPERIOR, V.CPF, PS.CIDADE_ORIGEM_VOLTA, PS.CIDADE_DESTINO_VOLTA, PS.TIPO_PASSAGEM, PG.COD_ORGAO_PAGADOR, V.CARGO, 00.0, V.VALOR_DIARIAS, V.VALOR_OUTROS, (PS.VALOR_PASSAGEM + V.VALOR_DIARIAS + V.VALOR_OUTROS) AS VALOR_TOTAL
	FROM TB_VIAGENS V INNER JOIN (SELECT ID_PROCESSO_VIAGEM, COD_ORGAO_SUPERIOR, COD_ORGAO_PAGADOR FROM TB_PAGAMENTO) PG
	ON (V.ID_PROCESSO_VIAGEM = PG.ID_PROCESSO_VIAGEM) LEFT JOIN TB_PASSAGEM PS
	ON (V.ID_PROCESSO_VIAGEM = PS.ID_PROCESSO_VIAGEM)
	WHERE PAIS_ORIGEM_VOLTA != 'Sem informação'
end

EXEC sp_oltp_viagem '20240324'

SELECT * FROM TB_AUX_VIAGEM