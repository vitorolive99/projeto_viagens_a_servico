create or alter procedure sp_oltp_pessoa(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_PESSOA
	WHERE @data_carga = DATA_CARGA

	INSERT INTO TB_AUX_PESSOA
	SELECT @data_carga, CPF, NOME
	FROM TB_VIAGENS
end