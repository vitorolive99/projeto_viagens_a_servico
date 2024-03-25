create or alter procedure sp_fato_viagem(@data_carga datetime)
as
begin
    DECLARE @ID_DATA_VIAGEM int
    DECLARE @ID_PROCESSO_VIAGEM INT
    DECLARE @ID_ORGAO_SUPERIOR INT
    DECLARE @ID_TRAJETO INT
    DECLARE @ID_TIPO INT
    DECLARE @ID_CARGO INT
    DECLARE @ID_ENTIDADE_VINCULADA INT
    DECLARE @ID_PESSOA INT
    DECLARE @ID_LOCALIDADE INT
    DECLARE @VALOR_PASSAGEM NUMERIC(10,2)
    DECLARE @VALOR_DIARIA NUMERIC(10,2)
    DECLARE @VALOR_OUTROS NUMERIC(10,2)
    DECLARE @VALOR_TOTAL NUMERIC(10,2)
    DECLARE @AUX_DATA_VIAGEM dateTIME
    DECLARE @AUX_COD_ORGAO_SUPERIOR INT
    DECLARE @AUX_CIDADE_ORIGEM VARCHAR(100)
    DECLARE @AUX_CIDADE_DESTINO VARCHAR(100)
    DECLARE @AUX_TIPO VARCHAR(15)
    DECLARE @AUX_CARGO VARCHAR(255)
    DECLARE @AUX_COD_ENTIDADE_VINCULADA INT
    DECLARE @AUX_CPF varchar(14)

    SET @ID_DATA_VIAGEM = NULL

	SET @ID_ORGAO_SUPERIOR = NULL

	SET @ID_PESSOA = NULL

    SET @ID_TRAJETO = NULL

    SET @ID_TIPO = NULL

    SET @ID_CARGO = NULL

    SET @ID_ENTIDADE_VINCULADA = NULL

    SET @ID_LOCALIDADE = NULL

    DECLARE CUR CURSOR FOR
    SELECT DATA_VIAGEM,
	ID_PROCESSO_VIAGEM,
	COD_ORGAO_SUPERIOR,
	CPF,
	CIDADE_ORIGEM,
	CIDADE_DESTINO ,
	TIPO,
	COD_ENTIDADE_VINCULADA ,
	CARGO ,
	VALOR_PASSAGEM ,
	VALOR_DIARIA ,
    VALOR_OUTROS ,
	VALOR_TOTAL FROM TB_AUX_VIAGEM WHERE  DATA_CARGA=@DATA_CARGA

    OPEN CUR 
    FETCH NEXT FROM CUR INTO
	@AUX_DATA_VIAGEM,
	@ID_PROCESSO_VIAGEM,
	@AUX_COD_ORGAO_SUPERIOR,
	@AUX_CPF,
	@AUX_CIDADE_ORIGEM,
	@AUX_CIDADE_DESTINO ,
	@AUX_TIPO,
	@AUX_COD_ENTIDADE_VINCULADA ,
	@AUX_CARGO ,
	@VALOR_PASSAGEM ,
	@VALOR_DIARIA ,
    @VALOR_OUTROS,
	@VALOR_TOTAL 

    WHILE @@FETCH_STATUS = 0
    BEGIN
    SELECT @ID_DATA_VIAGEM = ID_TEMPO FROM DIM_TEMPO WHERE DATA = @AUX_DATA_VIAGEM

	SELECT @ID_ORGAO_SUPERIOR = ID FROM DIM_ORGAO_SUPERIOR WHERE COD_ORGAO_SUPERIOR=@AUX_COD_ORGAO_SUPERIOR

	SELECT @ID_PESSOA = ID FROM DIM_PESSOA WHERE CPF=@AUX_CPF

    SELECT @ID_TRAJETO =ID FROM DIM_TRAJETO WHERE CIDADE_ORIGEM=@AUX_CIDADE_ORIGEM AND CIDADE_DESTINO=@AUX_CIDADE_DESTINO

    SELECT @ID_TIPO = ID FROM DIM_TIPO WHERE NOME = @AUX_TIPO

    SELECT @ID_CARGO = ID FROM DIM_CARGO WHERE NOME = @AUX_CARGO

    SELECT @ID_ENTIDADE_VINCULADA = ID FROM DIM_ENTIDADE_VINCULADA WHERE COD_ENTIDADE_VINCULADA = @AUX_COD_ENTIDADE_VINCULADA

    SELECT @ID_LOCALIDADE = ID FROM DIM_LOCALIDADE WHERE CIDADE = @AUX_CIDADE_ORIGEM

    IF  EXISTS (SELECT * FROM FATO_VIAGEM WHERE ID_PROCESSO_VIAGEM = @ID_PROCESSO_VIAGEM)
        BEGIN
             UPDATE FATO_VIAGEM SET
                ID_DATA_VIAGEM = @ID_DATA_VIAGEM,
                ID_ORGAO_SUPERIOR = @ID_ORGAO_SUPERIOR,
                ID_TRAJETO = @ID_TRAJETO,
                ID_TIPO = @ID_TIPO,
                ID_CARGO = @ID_CARGO,
                ID_ENTIDADE_VINCULADA = @ID_ENTIDADE_VINCULADA,
                ID_PESSOA = @ID_PESSOA,
                ID_LOCALIDADE = @ID_LOCALIDADE,
                QUANTIDADE=1,
                VALOR_PASSAGEM = @VALOR_PASSAGEM,
                VALOR_DIARIA = @VALOR_DIARIA,
                VALOR_OUTROS = @VALOR_OUTROS,
                VALOR_TOTAL = @VALOR_TOTAL
                WHERE ID_PROCESSO_VIAGEM = @ID_PROCESSO_VIAGEM
        END
    ELSE
        BEGIN
            INSERT INTO FATO_VIAGEM (ID_DATA_VIAGEM,
                ID_ORGAO_SUPERIOR,
                ID_TRAJETO,
                ID_TIPO,
                ID_CARGO,
                ID_ENTIDADE_VINCULADA,
                ID_PESSOA,
                ID_LOCALIDADE,
                QUANTIDADE,
                VALOR_PASSAGEM,
                VALOR_DIARIA,
                VALOR_OUTROS,
                VALOR_TOTAL)
            VALUES (@ID_DATA_VIAGEM,
                @ID_ORGAO_SUPERIOR,
                @ID_TRAJETO,
                @ID_TIPO,
                @ID_CARGO,
                @ID_ENTIDADE_VINCULADA,
                @ID_PESSOA,
                @ID_LOCALIDADE,
                1,
                @VALOR_PASSAGEM,
                @VALOR_DIARIA,
                @VALOR_OUTROS,
                @VALOR_TOTAL)
        END

    SET @ID_DATA_VIAGEM = NULL

	SET @ID_ORGAO_SUPERIOR = NULL

	SET @ID_PESSOA = NULL

    SET @ID_TRAJETO = NULL

    SET @ID_TIPO = NULL

    SET @ID_CARGO = NULL

    SET @ID_ENTIDADE_VINCULADA = NULL

    SET @ID_LOCALIDADE = NULL

    FETCH NEXT FROM CUR INTO
	@AUX_DATA_VIAGEM,
	@ID_PROCESSO_VIAGEM,
	@AUX_COD_ORGAO_SUPERIOR,
	@AUX_CPF,
	@AUX_CIDADE_ORIGEM,
	@AUX_CIDADE_DESTINO ,
	@AUX_TIPO,
	@AUX_COD_ENTIDADE_VINCULADA ,
	@AUX_CARGO ,
	@VALOR_PASSAGEM ,
	@VALOR_DIARIA ,
    @VALOR_OUTROS,
	@VALOR_TOTAL 

    END
    CLOSE CUR
    DEALLOCATE CUR
end

delete from FATO_VIAGEM
-- Teste

exec sp_fato_viagem '20240324'

select * from FATO_VIAGEM

select * from TB_AUX_VIAGEM