CREATE OR ALTER PROCEDURE sp_dim_tipo(@data_carga DATETIME)
AS
BEGIN
    DECLARE @NOME VARCHAR(100)

    DECLARE CUR CURSOR FOR
    SELECT TIPO_PASSAGEM FROM TB_AUX_TIPO WHERE DATA_CARGA=@data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @NOME

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DIM_TIPO WHERE TIPO_PASSAGEM = @NOME)
        BEGIN
            INSERT INTO DIM_TIPO (NOME)
            VALUES (@NOME)
        END
        FETCH NEXT FROM CUR INTO @NOME
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END

-- Teste

exec sp_dim_tipo '20230321'

select * from DIM_TIPO