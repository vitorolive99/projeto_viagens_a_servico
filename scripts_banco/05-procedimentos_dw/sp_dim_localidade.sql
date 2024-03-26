CREATE OR ALTER PROCEDURE sp_dim_localidade(@data_carga DATETIME)
AS
BEGIN
    DECLARE @UF VARCHAR(50)
    DECLARE @CIDADE VARCHAR(100)

    DECLARE CUR CURSOR FOR
    SELECT UF, CIDADE 
	FROM TB_AUX_LOCALIDADE 
	WHERE DATA_CARGA = @data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @UF, @CIDADE

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM DIM_LOCALIDADE WHERE CIDADE=@CIDADE)
        BEGIN
            INSERT INTO DIM_LOCALIDADE (UF,CIDADE)
            VALUES (@UF,@CIDADE)
        END

         FETCH NEXT FROM CUR INTO @UF,@CIDADE
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END

-- Teste

exec sp_dim_localidade '20240324'

select * from DIM_LOCALIDADE
