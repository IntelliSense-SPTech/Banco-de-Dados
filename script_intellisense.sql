create database intellisense;
use intellisense;

create table usuarios (
  id_usuario int primary key auto_increment,
  cim char(9),
  nome varchar(40),
  cpf char(14),
  email varchar(250),
  senha varchar(40),
  token char(6),
  telefone char(11),
  tipo_usuario varchar(20)
);

create table crimes (
  id_crime int primary key auto_increment,
  especificacao varchar(255),
  qtd_casos int,
  ano int,
  mes int,
  localidade varchar(55)
);

create table relatos (
  id_relato int primary key auto_increment,
  fk_usuario int,
  descricao varchar(2500),
  data date,
  foreign key (fk_usuario) references usuarios(id_usuario)
);

CREATE TABLE Mensagem (
idMensagem INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(250),
email VARCHAR(250),
telefone CHAR(11),
mensagem VARCHAR(500)
);

-- NOTIFICAÇÃO MAIOR AUMENTO
WITH dados_recentes AS (
    SELECT 
        c.localidade,
        c.especificacao,
        c.qtd_casos,
        c.ano,
        c.mes,
        ROW_NUMBER() OVER (PARTITION BY c.localidade, c.especificacao ORDER BY c.ano DESC, c.mes DESC) AS ordem_mes
    FROM crimes c
),
comparacao AS (
    SELECT 
        atual.localidade,
        atual.especificacao,
        atual.qtd_casos AS casos_mes_atual,
        anterior.qtd_casos AS casos_mes_anterior,
        ROUND(((atual.qtd_casos - anterior.qtd_casos) / NULLIF(anterior.qtd_casos, 0)) * 100, 2) AS aumento_percentual
    FROM 
        dados_recentes atual
    LEFT JOIN 
        dados_recentes anterior
    ON 
        atual.localidade = anterior.localidade
        AND atual.especificacao = anterior.especificacao
        AND atual.ordem_mes = 1
        AND anterior.ordem_mes = 2
    WHERE 
        anterior.qtd_casos IS NOT NULL
        AND atual.qtd_casos > anterior.qtd_casos
)
SELECT 
    localidade,
    especificacao AS crime,
    aumento_percentual
FROM 
    comparacao
ORDER BY 
    aumento_percentual DESC
LIMIT 1;



-- NOTIFICAÇÃO MAIOR REDUÇÃO
WITH dados_recentes AS (
    SELECT 
        c.localidade,
        c.especificacao,
        c.qtd_casos,
        c.ano,
        c.mes,
        ROW_NUMBER() OVER (PARTITION BY c.localidade, c.especificacao ORDER BY c.ano DESC, c.mes DESC) AS ordem_mes
    FROM crimes c
),
comparacao AS (
    SELECT 
        atual.localidade,
        atual.especificacao,
        atual.qtd_casos AS casos_mes_atual,
        anterior.qtd_casos AS casos_mes_anterior,
        ROUND(((anterior.qtd_casos - atual.qtd_casos) / NULLIF(anterior.qtd_casos, 0)) * 100, 2) AS reducao_percentual
    FROM 
        dados_recentes atual
    LEFT JOIN 
        dados_recentes anterior
    ON 
        atual.localidade = anterior.localidade
        AND atual.especificacao = anterior.especificacao
        AND atual.ordem_mes = 1
        AND anterior.ordem_mes = 2
    WHERE 
        anterior.qtd_casos IS NOT NULL
        AND atual.qtd_casos < anterior.qtd_casos
)
SELECT 
    localidade,
    especificacao AS crime,
    reducao_percentual
FROM 
    comparacao
ORDER BY 
    reducao_percentual DESC
LIMIT 1;







