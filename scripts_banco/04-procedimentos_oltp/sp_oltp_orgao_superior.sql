create or alter procedure sp_oltp_orgao_superior(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_ORGAO_SUPERIOR
	WHERE @data_carga = DATA_CARGA

	INSERT INTO TB_AUX_ORGAO_SUPERIOR
	SELECT @data_carga, COD_ORGAO_SUPERIOR, NOME_ORGAO_SUPERIOR
	FROM TB_PAGAMENTO
end

EXEC sp_oltp_orgao_superior '20240324'

SELECT * FROM TB_AUX_ORGAO_SUPERIOR