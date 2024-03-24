CREATE TABLE TB_AUX_ORGAO_SUPERIOR (
	DATA_CARGA DATETIME NOT NULL,
	COD_ORGAO_SUPERIOR INT NULL,
	NOME_ORGAO_SUPERIOR VARCHAR(100) NULL
)

CREATE TABLE TB_AUX_PESSOA (
	DATA_CARGA DATETIME NOT NULL,
	CPF VARCHAR(14) NULL,
	NOME VARCHAR(255) NULL
)

CREATE TABLE TB_AUX_TRAJETO (
    DATA_CARGA DATETIME NOT NULL,
    UF_ORIGEM VARCHAR(50) NULL,
    CIDADE_ORIGEM VARCHAR(100) NULL,
    UF_DESTINO VARCHAR(50) NULL,
    CIDADE_DESTINO VARCHAR(100) NULL,
)

CREATE TABLE TB_AUX_LOCALIDADE (
    DATA_CARGA DATETIME NOT NULL,
	UF VARCHAR(50) NULL,
    CIDADE VARCHAR(100) NULL
)

CREATE TABLE TB_AUX_TIPO (
	DATA_CARGA DATETIME NOT NULL,
	TIPO_PASSAGEM VARCHAR(15) NULL,
)

CREATE TABLE TB_AUX_CARGO (
	DATA_CARGA DATETIME NOT NULL,
	CARGO VARCHAR(255) NULL
)

CREATE TABLE TB_AUX_ENTIDADE_VINCULADA (
	DATA_CARGA DATETIME NOT NULL,
	COD_ENTIDADE_VINCULADA INT NULL,
	NOME VARCHAR(100) NULL
)

CREATE TABLE TB_AUX_VIAGEM(
	DATA_CARGA DATETIME NOT NULL,
    DATA_VIAGEM DATETIME NULL,
    ID_PROCESSO_VIAGEM INT NULL,
    COD_ORGAO_SUPERIOR INT NULL,
    CPF VARCHAR(20) NULL,
    CIDADE_ORIGEM VARCHAR(100) NULL,
    CIDADE_DESTINO VARCHAR(100) NULL,
    TIPO VARCHAR(15) NULL,
    COD_ENTIDADE_VINCULADA INT NULL,
    CARGO VARCHAR(255) NULL,
    VALOR_PASSAGEM NUMERIC(10,2) NULL,
    VALOR_DIARIA NUMERIC(10,2) NULL,
	VALOR_OUTROS NUMERIC(10,2) NULL,
    VALOR_TOTAL NUMERIC(10,2) NULL
)