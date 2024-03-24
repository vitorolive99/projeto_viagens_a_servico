create or alter procedure sp_oltp_localidade(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_LOCALIDADE
	WHERE @data_carga = DATA_CARGA

	INSERT INTO TB_AUX_LOCALIDADE
	SELECT @data_carga, UF_ORIGEM, CIDADE_ORIGEM
	FROM TB_TRECHO
	WHERE SEQUENCIA_VIAGEM = 1
end