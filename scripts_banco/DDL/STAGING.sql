CREATE TABLE TB_AUX_ORGAO_SUPERIOR (
	DATA_CARGA DATETIME NOT NULL,
	COD_ORGAO_SUPERIOR INT NOT NULL,
	NOME_ORGAO_SUPERIOR VARCHAR(100) NOT NULL,
)

CREATE TABLE TB_AUX_PESSOA (
	DATA_CARGA DATETIME NOT NULL,
	CPF VARCHAR(14) NOT NULL,
	NOME VARCHAR(255) NOT NULL
)

CREATE TABLE TB_AUX_TRAJETO (
	DATA_CARGA DATETIME NOT NULL,
	CIDADE_ORIGEM VARCHAR(100) NOT NULL,
	CIDADE_DESTINO VARCHAR(100) NOT NULL,
)

CREATE TABLE TB_AUX_TIPO (
	DATA_CARGA DATETIME NOT NULL,
	TIPO_PASSAGEM VARCHAR(15) NOT NULL,
)

CREATE TABLE TB_AUX_CARGO (
	DATA_CARGA DATETIME NOT NULL,
	CARGO VARCHAR(255) NULL,
)

CREATE TABLE TB_AUX_ENTIDADE_VINCULADA (
	DATA_CARGA DATETIME NOT NULL,
	COD_ENTIDADE_VINCULADA INT NOT NULL,
	NOME VARCHAR(100) NOT NULL
)

CREATE TABLE TB_AUX_VIAGEM(
	DATA_CARGA DATETIME NOT NULL,
	ID_PROCESSO_VIAGEM INT NOT NULL,
	ID_ORGAO_SUPERIOR INT NOT NULL,
	ID_TRAJETO INT NOT NULL,
	ID_TIPO INT NOT NULL ,
	ID_CARGO INT NOT NULL,
	ID_ENTIDADE_VINCULADA NOT NULL 
	ID_PESSOA INT REFERENCES DIM_PESSOA(ID),
	VALOR_PASSAGEM NUMERIC(10,2) NOT NULL,
	VALOR_DIARIA NUMERIC(10,2) NOT NULL,
	VALOR_TOTAL NUMERIC(10,2) NOT NULL
)