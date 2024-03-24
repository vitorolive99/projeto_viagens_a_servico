create or alter procedure sp_oltp_tipo(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_TIPO
	WHERE @data_carga = DATA_CARGA

	INSERT INTO TB_AUX_TIPO
	SELECT @data_carga, TIPO_PASSAGEM
	FROM TB_PASSAGEM
end

EXEC sp_oltp_tipo '20240324'

SELECT * FROM TB_AUX_TIPO