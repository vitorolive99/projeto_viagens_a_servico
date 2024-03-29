--TODOS AS LINHAS INDICANDO N�O INFORMADO DEVEM TER O ID = 1

DROP TABLE FATO_VIAGEM, DIM_ORGAO_SUPERIOR, DIM_PESSOA, DIM_TRAJETO, DIM_LOCALIDADE, DIM_TIPO, DIM_CARGO, DIM_ENTIDADE_VINCULADA

CREATE TABLE DIM_ORGAO_SUPERIOR (
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	COD_ORGAO_SUPERIOR INT NULL,
	NOME VARCHAR(100) NULL
)

CREATE TABLE DIM_PESSOA (
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	CPF VARCHAR(14) NULL,
	NOME VARCHAR(255) NULL
)

--INSERINDO NO ID 1 O CASO PARA QUANDO O CPF N�O � INFORMADO
INSERT INTO DIM_PESSOA VALUES (NULL, 'N�O INFORMADO')

CREATE TABLE DIM_TRAJETO (
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	UF_ORIGEM VARCHAR(50) NULL,
	CIDADE_ORIGEM VARCHAR(100) NULL,
	UF_DESTINO VARCHAR(50) NULL,
	CIDADE_DESTINO VARCHAR(100) NULL,
)

--INSERINDO NO ID 1 O CASO PARA QUANDO O O TRAJETO N�O � INFORMADO
INSERT INTO DIM_TRAJETO VALUES ('N�O INFORMADO', 'N�O INFORMADO', 'N�O INFORMADO', 'N�O INFORMADO')

CREATE TABLE DIM_LOCALIDADE(
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	UF VARCHAR(50) NULL,	
	CIDADE VARCHAR(100) NULL,
)

--INSERINDO NO ID 1 O CASO PARA QUANDO O TIPO N�O � INFORMADO
INSERT INTO DIM_LOCALIDADE VALUES ('N�O INFORMADO', 'N�O INFORMADO')

CREATE TABLE DIM_TIPO (
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	NOME VARCHAR(15) NULL
)

--INSERINDO NO ID 1 O CASO PARA QUANDO O TIPO N�O � INFORMADO
INSERT INTO DIM_TIPO VALUES ('N�O INFORMADO')

CREATE TABLE DIM_CARGO (
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	NOME VARCHAR(255) NULL
)

--INSERINDO NO ID 1 O CASO PARA QUANDO O CARGO N�O � INFORMADO
INSERT INTO DIM_CARGO VALUES ('N�O INFORMADO')

CREATE TABLE DIM_ENTIDADE_VINCULADA (
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	COD_ENTIDADE_VINCULADA INT NULL,
	NOME VARCHAR(100) NULL
)

CREATE TABLE DIM_TEMPO (
	ID_TEMPO BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	NIVEL VARCHAR(8) NOT NULL CHECK (NIVEL IN ('DIA','MES','ANO')),
	DATA DATETIME NULL,
	DIA INT NULL,
	DIA_SEMANA VARCHAR(50) NULL,
	FIM_SEMANA VARCHAR(3) NULL CHECK (FIM_SEMANA IN ('SIM','NAO')),
	FERIADO VARCHAR(100) NULL,
	FL_FERIADO VARCHAR(3) NULL CHECK (FL_FERIADO IN ('SIM','NAO')),
	MES INT NULL,
	NOME_MES VARCHAR(100) NULL,
	TRIMESTRE INT NULL,
	NOME_TRIMESTRE VARCHAR(100) NULL,
	SEMESTRE INT NULL,
	NOME_SEMESTRE VARCHAR(100) NULL,
	ANO INT NOT NULL
)

CREATE TABLE FATO_VIAGEM(
	ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_DATA_VIAGEM INT NULL,
	ID_PROCESSO_VIAGEM INT NULL,
	ID_ORGAO_SUPERIOR INT REFERENCES DIM_ORGAO_SUPERIOR(ID),
	ID_TRAJETO INT REFERENCES DIM_TRAJETO(ID),
	ID_TIPO INT REFERENCES DIM_TIPO(ID),
	ID_CARGO INT REFERENCES DIM_CARGO(ID),
	ID_ENTIDADE_VINCULADA INT REFERENCES DIM_ENTIDADE_VINCULADA(ID),
	ID_PESSOA INT REFERENCES DIM_PESSOA(ID),
	ID_LOCALIDADE INT REFERENCES DIM_LOCALIDADE(ID),
	QUANTIDADE INT NOT NULL DEFAULT (1),
	VALOR_PASSAGEM NUMERIC(10,2) NULL,
	VALOR_DIARIA NUMERIC(10,2) NULL,
	VALOR_OUTROS NUMERIC(10,2) NULL,
	VALOR_TOTAL NUMERIC(10,2) NULL
)

CREATE INDEX IX_DIM_TEMPO_DATA ON DIM_TEMPO (DATA)
CREATE INDEX IX_FATO_VIAGEM_PROCESSO_VIAGEM ON FATO_VIAGEM (ID_PROCESSO_VIAGEM)
CREATE INDEX IX_FATO_VIAGEM_DATA_VIAGEM ON FATO_VIAGEM (ID_DATA_VIAGEM)
CREATE INDEX IX_FATO_VIAGEM_ORGAO_SUPERIOR ON FATO_VIAGEM (ID_ORGAO_SUPERIOR)
CREATE INDEX IX_FATO_VIAGEM_TRAJETO ON FATO_VIAGEM (ID_TRAJETO)
CREATE INDEX IX_FATO_VIAGEM_TIPO ON FATO_VIAGEM (ID_TIPO)
CREATE INDEX IX_FATO_VIAGEM_CARGO ON FATO_VIAGEM (ID_CARGO)
CREATE INDEX IX_FATO_VIAGEM_ENTIDADE_VINCULADA ON FATO_VIAGEM (ID_ENTIDADE_VINCULADA)
CREATE INDEX IX_FATO_VIAGEM_PESSOA ON FATO_VIAGEM (ID_PESSOA)
CREATE INDEX IX_FATO_VIAGEM_LOCALIDADE ON FATO_VIAGEM (ID_LOCALIDADE)
CREATE INDEX IX_DIM_ENTIDADE_VINCULADA_COD ON DIM_ENTIDADE_VINCULADA (COD_ENTIDADE_VINCULADA)
CREATE INDEX IX_DIM_CARGO_NOME ON DIM_CARGO (NOME)
CREATE INDEX IX_DIM_TIPO_NOME ON DIM_TIPO (NOME)
CREATE INDEX IX_DIM_LOCALIDADE_CIDADE ON DIM_LOCALIDADE (CIDADE)
CREATE INDEX IX_DIM_TRAJETO_CIDADE_ORIGEM ON DIM_TRAJETO (CIDADE_ORIGEM)
CREATE INDEX IX_DIM_TRAJETO_CIDADE_DESTINO ON DIM_TRAJETO (CIDADE_DESTINO)
CREATE INDEX IX_DIM_PESSOA_CPF ON DIM_PESSOA (CPF)
CREATE INDEX IX_DIM_PESSOA_NOME ON DIM_PESSOA (NOME)
CREATE INDEX IX_DIM_ORGAO_SUPERIOR ON DIM_ORGAO_SUPERIOR (COD_ORGAO_SUPERIOR)