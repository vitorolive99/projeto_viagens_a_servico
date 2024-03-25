CREATE OR ALTER PROCEDURE sp_dim_orgao_superior(@data_carga DATETIME)
AS
BEGIN
    DECLARE @COD_ORGAO_SUPERIOR INT
    DECLARE @ORGAO_SUPERIOR VARCHAR(100)

    DECLARE CUR CURSOR FOR
    SELECT COD_ORGAO_SUPERIOR,NOME_ORGAO_SUPERIOR FROM TB_AUX_ORGAO_SUPERIOR WHERE DATA_CARGA=@data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @COD_ORGAO_SUPERIOR, @ORGAO_SUPERIOR

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DIM_ORGAO_SUPERIOR WHERE COD_ORGAO_SUPERIOR = @COD_ORGAO_SUPERIOR)
        BEGIN
            INSERT INTO DIM_ORGAO_SUPERIOR (COD_ORGAO_SUPERIOR,NOME)
            VALUES (@COD_ORGAO_SUPERIOR,@ORGAO_SUPERIOR)
        END
        FETCH NEXT FROM CUR INTO @COD_ORGAO_SUPERIOR, @ORGAO_SUPERIOR
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END

-- Teste
DELETE FROM DIM_ORGAO_SUPERIOR
exec sp_dim_orgao_superior '20240324'

select * from DIM_ORGAO_SUPERIOR