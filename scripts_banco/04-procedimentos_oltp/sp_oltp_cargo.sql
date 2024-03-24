create or alter procedure sp_oltp_cargo(@data_carga datetime)
as
begin
	DELETE FROM TB_AUX_CARGO
	WHERE @data_carga = DATA_CARGA

	INSERT INTO TB_AUX_CARGO
	SELECT @data_carga, CARGO
	FROM TB_VIAGENS
end

EXEC sp_oltp_cargo '20240324'

SELECT * FROM TB_AUX_CARGO