CREATE DATABASE db_viagens_a_servico

CREATE TABLE TB_VIAGENS(
	ID_PROCESSO_VIAGEM INT PRIMARY KEY NOT NULL,
	NUM_PROPOSTA VARCHAR(15) NOT NULL,
	SITUACAO VARCHAR(13) NOT NULL,
	URGENTE VARCHAR(3) NOT NULL,
	JUSTIFICATIVA_URGENCIA VARCHAR(300) NOT NULL,
	CPF VARCHAR(14) NOT NULL,
	NOME VARCHAR(50) NOT NULL,
	CARGO VARCHAR(40) NULL,
	MOTIVO VARCHAR(500) NOT NULL,
	VALOR_DEVOLUCAO NUMERIC (10,2) NOT NULL,
	VALOR_OUTROS NUMERIC (10,2) NOT NULL
)


CREATE TABLE TB_PASSAGEM (
	ID INT PRIMARY KEY IDENTITY(1,1),
	TIPO_PASSAGEM VARCHAR(15) NOT NULL,
	PAIS_ORIGEM_IDA VARCHAR(30) NOT NULL,
	UF_ORIGEM_IDA VARCHAR(30) NULL,
	CIDADE_ORIGEM_IDA VARCHAR(30) NOT NULL,
	PAIS_DESTINO_IDA VARCHAR(30) NOT NULL,
	UF_DESTINO_IDA VARCHAR(30) NULL,
	CIDADE_DESTINO_IDA VARCHAR(30) NOT NULL,
	PAIS_ORIGEM_VOLTA VARCHAR(30) NOT NULL,
	UF_ORIGEM_VOLTA VARCHAR(30) NULL,
	CIDADE_ORIGEM_VOLTA VARCHAR(30) NOT NULL,
	PAIS_DESTINO_VOLTA VARCHAR(30) NOT NULL,
	UF_DESTINO_VOLTA VARCHAR(30) NULL,
	CIDADE_DESTINO_VOLTA VARCHAR(30) NOT NULL,
	VALOR_PASSAGEM NUMERIC (10,2) NOT NULL,
	VALOR_TAXA_SERVICO NUMERIC (10,2) NOT NULL,
	DT_COMPRA DATE NULL,
	HR_COMPRA TIME NULL,
	ID_PROCESSO_VIAGEM INT REFERENCES TB_VIAGENS(ID_PROCESSO_VIAGEM)
)

CREATE TABLE TB_PAGAMENTO (
	ID INT PRIMARY KEY IDENTITY(1,1),
	COD_ORGAO_SUPERIOR INT NOT NULL,
	NOME_ORGAO_SUPERIOR VARCHAR(50) NOT NULL,
	COD_ORGAO_PAGADOR INT NOT NULL,
	NOME_ORGAO_PAGADOR VARCHAR(50) NOT NULL,
	COD_UNIDADE_GESTORA_PAGADORA INT NOT NULL,
	NOME_UNIDADE_GESTORA_PAGADORA VARCHAR(50) NOT NULL,
	TIPO VARCHAR(30) NOT NULL,
	VALOR NUMERIC(10,2) NOT NULL,
	ID_PROCESSO_VIAGEM INT REFERENCES TB_VIAGENS(ID_PROCESSO_VIAGEM)
)

CREATE TABLE TB_TRECHO(
	ID INT PRIMARY KEY IDENTITY(1,1),
	SEQUENCIA_VIAGEM INT NOT NULL,
	DT_ORIGEM DATE NOT NULL,
	PAIS_ORIGEM VARCHAR(30) NOT NULL,
	UF_ORIGEM VARCHAR(30) NULL,
	CIDADE_ORIGEM VARCHAR(30) NOT NULL,
	DT_DESTINO DATE NOT NULL,
	PAIS_DESTINO VARCHAR(30) NOT NULL,
	UF_DESTINO VARCHAR(30) NULL,
	CIDADE_DESTINO VARCHAR(30) NOT NULL,
	MEIO_TRANSPORTE VARCHAR(20) NOT NULL,
	NUM_DIARIAS FLOAT NOT NULL,
	MISSAO VARCHAR(3) NOT NULL,
	ID_PROCESSO_VIAGEM INT REFERENCES TB_VIAGENS(ID_PROCESSO_VIAGEM)
)