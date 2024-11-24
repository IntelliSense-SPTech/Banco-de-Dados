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
  descricao varchar(400),
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

select * from crimes;
select * from usuarios;
select * from mensagem;