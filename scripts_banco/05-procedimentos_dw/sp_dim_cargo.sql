CREATE OR ALTER PROCEDURE sp_dim_cargo(@data_carga DATETIME)
AS
BEGIN
    DECLARE @NOME VARCHAR(100)

    DECLARE CUR CURSOR FOR
    SELECT CARGO FROM TB_AUX_CARGO 
	WHERE DATA_CARGA = @data_carga;

    OPEN CUR 
    FETCH NEXT FROM CUR INTO @NOME

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT * FROM DIM_CARGO WHERE NOME = @NOME) AND @NOME IS NOT NULL
            BEGIN
                INSERT INTO DIM_CARGO (NOME)
                VALUES (@NOME)
            END
        FETCH NEXT FROM CUR INTO @NOME
    END

    CLOSE CUR;
    DEALLOCATE CUR;
END

-- Teste

exec sp_dim_cargo '20240324'

select * from DIM_CARGO