create database intellisense;
use intellisense;

create table tipo_usuario (
  id_tipo_usuario int primary key auto_increment,
  categoria varchar(40),
  descricao varchar(250)
);

create table localidades (
  id_localidade int primary key auto_increment,
  regiao varchar(40),
  municipio varchar(40),
  populacao float
);

create table usuarios (
  id_usuario int primary key auto_increment,
  cim char,
  nome varchar(40),
  cpf char(14),
  email varchar(250),
  senha varchar(40),
  token char(4),
  telefone char(11),
  fk_tipo_usuario integer,
  foreign key (fk_tipo_usuario) references tipo_usuario(id_tipo_usuario)
);

create table crimes (
  id_crime int primary key auto_increment,
  especificacao varchar(255),
  qtd_casos int,
  ano int,
  mes int,
  fk_localidade int,
  foreign key (fk_localidade) references localidades(id_localidade)
);

create table contatos (
  id_contato int primary key auto_increment,
  email varchar(250),
  mensagem varchar(400)
);

create table relatos (
  id_relato int primary key auto_increment,
  fk_usuario int,
  descricao varchar(400),
  data date,
  foreign key (fk_usuario) references usuarios(id_usuario)
);

create table avaliacoes (
  id_avaliacao int primary key auto_increment,
  fk_usuario int,
  nota int,
  mensagem varchar(400),
  foreign key (fk_usuario) references usuarios(id_usuario)
);
