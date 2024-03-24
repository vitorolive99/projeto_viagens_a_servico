create or alter procedure sp_oltp_entidade_vinculada(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_ENTIDADE_VINCULADA
	WHERE @data_carga = DATA_CARGA

	INSERT INTO TB_AUX_ENTIDADE_VINCULADA
	SELECT @data_carga, COD_ORGAO_PAGADOR, NOME_ORGAO_PAGADOR
	FROM TB_PAGAMENTO
end

EXEC sp_oltp_entidade_vinculada '20240324'

SELECT * FROM TB_AUX_ENTIDADE_VINCULADA