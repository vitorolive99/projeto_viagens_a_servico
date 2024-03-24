create or alter procedure sp_oltp_viagem(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_VIAGEM
	WHERE @data_carga = DATA_CARGA

	INSERT INTO TB_AUX_VIAGEM
	SELECT DISTINCT @data_carga, V.DATA, V.ID_PROCESSO_VIAGEM, PG.COD_ORGAO_SUPERIOR, V.CPF, PS.CIDADE_ORIGEM_IDA, PS.CIDADE_DESTINO_IDA, PS.TIPO_PASSAGEM, PG.COD_ORGAO_PAGADOR, V.CARGO, V.VALOR_PASSAGENS, V.VALOR_DIARIAS, V.VALOR_OUTROS, (V.VALOR_PASSAGENS + V.VALOR_DIARIAS + V.VALOR_OUTROS) AS VALOR_TOTAL
	FROM TB_VIAGENS V INNER JOIN (SELECT ID_PROCESSO_VIAGEM, COD_ORGAO_SUPERIOR, COD_ORGAO_PAGADOR FROM TB_PAGAMENTO) PG
	ON (V.ID_PROCESSO_VIAGEM = PG.ID_PROCESSO_VIAGEM) LEFT JOIN TB_PASSAGEM PS
	ON (V.ID_PROCESSO_VIAGEM = PS.ID_PROCESSO_VIAGEM)
end

EXEC sp_oltp_viagem '20240324'

SELECT * FROM TB_AUX_VIAGEM