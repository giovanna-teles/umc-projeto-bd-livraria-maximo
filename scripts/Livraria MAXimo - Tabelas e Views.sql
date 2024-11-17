CREATE DATABASE gestor_livraria;
USE gestor_livraria;

CREATE TABLE Cliente(
CPF 	 	decimal(11) primary key,
Nome 	 	varchar(100) not null,
Telefone 	decimal(11) not null,
Email 		varchar(100) unique not null,
Ativo     	boolean default true not null
);

CREATE TABLE Genero(
ID	int auto_increment primary key,
Nome	varchar(100) unique not null,
Ativo     	boolean default true not null
);

CREATE TABLE Tipo_livro(
ID		int auto_increment primary key,
Nome	varchar(50) unique not null,
Ativo     	boolean default true not null
);

CREATE TABLE Editora(
ID 			int auto_increment primary key,
Nome 	 	varchar(100) unique not null,
Endereco 	varchar(200) not null,
Telefone 	decimal(11) not null,
Ativo     	boolean default true not null
);

CREATE TABLE Autor(
ID 		     	int auto_increment primary key,
Nome 		    varchar(100) unique not null,
Nacionalidade   varchar(100),
Dt_Nascimento   date,
Ativo     	boolean default true not null
);

CREATE TABLE Livro(
ISBN 						decimal(13) primary key,
Titulo						varchar(100) not null,
Valor_un					decimal(5,2) not null,
Ano_Publicacao				year not null,
Classificacao_Indicativa	char(3),
Sinopse						text,
N_Pagina					int not null,
Peso_kg						decimal(4,2) not null,	
Dimensoes					char(20) not null,
Quantidade					int not null,
Localizacao					char(10) unique,
id_editora					int not null,
CONSTRAINT fk_liv_ed FOREIGN KEY (id_editora) REFERENCES Editora(ID),
Ativo     	boolean default true not null
);

CREATE TABLE Endereco(
ID				int auto_increment primary key,
N_Residencial	int not null,
CEP				decimal(8) not null,
id_cliente		decimal(11) not null,
CONSTRAINT fk_id_cli FOREIGN KEY (id_cliente) REFERENCES Cliente(CPF),
Ativo     	boolean default true not null
);

CREATE TABLE Pedido(
ID					int auto_increment primary key,
Data				date not null,
Valor_Total	   		decimal(5,2) not null,
Valor_Frete 	   	decimal(4,2) not null,
Valor_Total_Prod   	decimal(5,2) not null,
cpf_cli 		   	decimal(11) not null,
CONSTRAINT fk_ped_cli FOREIGN KEY (cpf_cli) REFERENCES Cliente(CPF),
Ativo     	boolean default true not null
);

CREATE TABLE Item(
Quantidade		int not null,
Subtotal 		decimal(5,2) not null,
id_ped 			int not null,
ISBN_liv 		decimal(13) not null,
CONSTRAINT pk_item_ped PRIMARY KEY (id_ped, ISBN_liv),
CONSTRAINT fk_itp_ped FOREIGN KEY (id_ped) REFERENCES Pedido(ID),
CONSTRAINT fk_itp_liv FOREIGN KEY (ISBN_liv) REFERENCES Livro(ISBN),
Ativo     	boolean default true not null
);

CREATE TABLE Livro_Genero(
ISBN_l 		decimal(13) not null,
id_gen 		int not null,
CONSTRAINT pk_l_gen PRIMARY KEY (ISBN_l, id_gen),
CONSTRAINT fk_l_ISBN FOREIGN KEY (ISBN_l) REFERENCES Livro(ISBN),
CONSTRAINT fk_l_gen FOREIGN KEY (id_gen) REFERENCES Genero(ID),
Ativo     	boolean default true not null
);

CREATE TABLE Livro_Autor(
ISBN_li		decimal(13) not null,
id_au 		int not null,
CONSTRAINT pk_li_au PRIMARY KEY (ISBN_li, id_au),
CONSTRAINT fk_li_ISBN FOREIGN KEY (ISBN_li) REFERENCES Livro(ISBN),
CONSTRAINT fk_li_au FOREIGN KEY (id_au) REFERENCES Autor(ID),
Ativo     	boolean default true not null
);

CREATE TABLE Versao(
ISBN_lv 		decimal(13) not null,
id_tipo_lv		int not null,
CONSTRAINT pk_lv_tp PRIMARY KEY (ISBN_lv, id_tipo_lv),
CONSTRAINT fk_lv_ISBN FOREIGN KEY (ISBN_lv) REFERENCES Livro(ISBN),
CONSTRAINT fk_tipo_lv FOREIGN KEY (id_tipo_lv) REFERENCES Tipo_livro(ID),
Ativo     	boolean default true not null
);

INSERT INTO Cliente VALUES 
(20973518002, 'Mariana', 11988300099, 'mari01@gmail.com', 1);
INSERT INTO Cliente VALUES 
(12345678901, 'Lucas', 12993807738, 'lu.98@hotmail.com', 1);
INSERT INTO Cliente VALUES 
(34216578905, 'Guilherme', 11945663365, 'jogui@gmail.com', 1);
INSERT INTO Cliente VALUES 
(11893772902, 'Beatriz', 13930222211, 'b.mor20@gmail.com', 1);
INSERT INTO Cliente VALUES 
(88304729949, 'Alice', 11927339090, 'ice.98@gmail.com', 1);

INSERT INTO Genero(Nome) VALUES ('Ficção');
INSERT INTO Genero(Nome) VALUES ('Horror');
INSERT INTO Genero(Nome) VALUES ('Mistério');
INSERT INTO Genero(Nome) VALUES ('Romance');
INSERT INTO Genero(Nome) VALUES ('Literatura Brasileira');

INSERT INTO Tipo_Livro(Nome) VALUES ('Ebook');
INSERT INTO Tipo_Livro(Nome) VALUES ('Capa Dura');
INSERT INTO Tipo_Livro(Nome) VALUES ('Capa Comum');
INSERT INTO Tipo_Livro(Nome) VALUES ('Box');
INSERT INTO Tipo_Livro(Nome) VALUES ('Trilogia');

INSERT INTO Editora(Nome,Endereco,Telefone) VALUES ('Editora Arqueiro', 'R. Funchal, 538 - Vila Olimpia - SP', 113868-4492);
INSERT INTO Editora(Nome,Endereco,Telefone) VALUES ('Intrínseca', 'Av. das Américas, 500 - Barra da Tijuca - RJ', 2132067400);
INSERT INTO Editora(Nome,Endereco,Telefone) VALUES ('Editora Record', 'R. do Paraíso, 139 - Paraíso - SP', 2125852002);
INSERT INTO Editora(Nome,Endereco,Telefone) VALUES ('Companhia das Letras', 'R. Bandeira Paulista, 702 - SP', 1137073500);
INSERT INTO Editora(Nome,Endereco,Telefone) VALUES ('DarkSide Book', 'Av. Portugal, 46 - Itaqui, Itapevi - SP', 2131292481);

INSERT INTO Autor(Nome, Nacionalidade, Dt_Nascimento) VALUES ('Andrew Pyper', 'Canadense', '1968-01-04');
INSERT INTO Autor(Nome, Nacionalidade, Dt_Nascimento) VALUES ('Caio Prado Jr.', 'Brasileiro','1907-02-11');
INSERT INTO Autor(Nome, Nacionalidade, Dt_Nascimento) VALUES ('Joël Dicker', 'Suiço', '1985-06-16');
INSERT INTO Autor(Nome, Nacionalidade, Dt_Nascimento) VALUES ('Hermann Hesse', 'Alemão', '1901-07-02');
INSERT INTO Autor(Nome, Nacionalidade, Dt_Nascimento) VALUES ('Ken Follet', 'Britânico', '1949-06-05');

INSERT INTO Livro(ISBN, Titulo, Sinopse, Valor_un, Ano_Publicacao, Classificacao_Indicativa, N_Pagina, Peso_kg, Dimensoes, Quantidade, Localizacao, id_editora) 
VALUES(7895111877756, 'Box Trindade', 'O sobrenatural, a dor e a criação divina estão...', 159.90, '2020','+16', 960, 1.30, '22.6x15x8.6cm', 100, 'CA-P2-A',
(SELECT ID FROM Editora WHERE Nome='DarkSide Book'));

INSERT INTO Livro (ISBN, Titulo, Sinopse, Valor_un, Ano_Publicacao,  Classificacao_Indicativa, N_Pagina, Peso_kg, Dimensoes, Quantidade, Localizacao, id_editora) 
VALUES (9788535919622, 'Formação do Brasil contemporâneo','Reconhecida como a obra maior de Caio...', 99.90, '2011','+14', 464, 0.72, '23x16x2.8cm', 198, 'CB-P5-C',
(SELECT ID FROM Editora WHERE Nome='Companhia das Letras'));

INSERT INTO Livro (ISBN, Titulo, Sinopse, Valor_un, Ano_Publicacao, Classificacao_Indicativa, N_Pagina, Peso_kg, Dimensoes, Quantidade, Localizacao, id_editora) 
VALUES (9788580579765, 'O Livro dos Baltimore','Marcus Goldman teve uma juventude...', 79.90,'2017','+16', 416, 0.62, '16x23x2cm', 201, 'CD-P2-D',
(SELECT ID FROM Editora WHERE Nome='Intrínseca'));

INSERT INTO Livro (ISBN, Titulo, Sinopse, Valor_un, Ano_Publicacao, Classificacao_Indicativa, N_Pagina, Peso_kg, Dimensoes, Quantidade, Localizacao, id_editora) 
VALUES(9788501020291, 'Demian', 'Emil Sinclair é um jovem atormentado pela...', 59.90, '1982','+12', 196, 0.42,'22.8x15.4x1.4cm', 56, 'CE-P1-B',
(SELECT ID FROM Editora WHERE Nome='Editora Record'));

INSERT INTO Livro (ISBN, Titulo, Sinopse, Valor_un, Ano_Publicacao, Classificacao_Indicativa, N_Pagina, Peso_kg, Dimensoes, Quantidade, Localizacao, id_editora) 
VALUES(9788599296851, 'Queda de Gigantes','Cinco famílias, cinco países e...', 99.90, '2010','+12', 912, 1.09, '22.8x15.8x4.6cm', 362, 'CA-P4-L',
(SELECT ID FROM Editora WHERE Nome='Editora Arqueiro'));

INSERT INTO Endereco(N_Residencial, CEP, id_cliente) VALUES (632, 03297980, (SELECT CPF FROM Cliente WHERE Email='mari01@gmail.com'));
INSERT INTO Endereco(N_Residencial, CEP, id_cliente) VALUES (20, 81099302, (SELECT CPF FROM Cliente WHERE Email='lu.98@hotmail.com'));
INSERT INTO Endereco(N_Residencial, CEP, id_cliente) VALUES (904, 09379213, (SELECT CPF FROM Cliente WHERE Email='jogui@gmail.com'));
INSERT INTO Endereco(N_Residencial, CEP, id_cliente) VALUES (54, 92992010, (SELECT CPF FROM Cliente WHERE Email='b.mor20@gmail.com'));
INSERT INTO Endereco(N_Residencial, CEP, id_cliente) VALUES (408, 37929283, (SELECT CPF FROM Cliente WHERE Email='ice.98@gmail.com'));

INSERT INTO Pedido (Data, Valor_Total, Valor_Frete, Valor_Total_Prod, cpf_cli) 
VALUES ('2023-07-14', 171.90, 12.00, 159.90, (SELECT CPF FROM Cliente WHERE Email='mari01@gmail.com'));
INSERT INTO Pedido (Data, Valor_Total, Valor_Frete, Valor_Total_Prod, cpf_cli) 
VALUES ('2024-02-06', 174.90, 15.00, 159.80, (SELECT CPF FROM Cliente WHERE Email='jogui@gmail.com'));
INSERT INTO Pedido (Data, Valor_Total, Valor_Frete, Valor_Total_Prod, cpf_cli) 
VALUES ('2021-09-29', 269.90, 10.10, 259.80, (SELECT CPF FROM Cliente WHERE Email='lu.98@hotmail.com'));
INSERT INTO Pedido (Data, Valor_Total, Valor_Frete, Valor_Total_Prod, cpf_cli) 
VALUES ('2019-03-18',324.80, 5.00, 324.8, (SELECT CPF FROM Cliente WHERE Email='ice.98@gmail.com'));
INSERT INTO Pedido (Data, Valor_Total, Valor_Frete, Valor_Total_Prod, cpf_cli) 
VALUES ('2020-02-01', 89.90, 10.00, 79.90, (SELECT CPF FROM Cliente WHERE Email='b.mor20@gmail.com'));

INSERT INTO Item VALUES
(1, 159.90, (SELECT ID FROM Pedido WHERE cpf_cli=(SELECT CPF FROM Cliente WHERE Email='mari01@gmail.com')),(SELECT ISBN FROM Livro WHERE Localizacao='CA-P2-A'), 1);
INSERT INTO Item VALUES
(1,99.90,(SELECT ID FROM Pedido WHERE cpf_cli=(SELECT CPF FROM Cliente WHERE Email='jogui@gmail.com')),(SELECT ISBN FROM Livro WHERE Localizacao='CB-P5-C'), 1);
INSERT INTO Item VALUES
(1,59.90,(SELECT ID FROM Pedido WHERE cpf_cli=(SELECT CPF FROM Cliente WHERE Email='jogui@gmail.com')),(SELECT ISBN FROM Livro WHERE Localizacao='CE-P1-B'), 1);
INSERT INTO Item VALUES
(2,319.80,(SELECT ID FROM Pedido WHERE cpf_cli=(SELECT CPF FROM Cliente WHERE Email='ice.98@gmail.com')), (SELECT ISBN FROM Livro WHERE Localizacao='CB-P5-C'), 1);
INSERT INTO Item VALUES
(1,79.90,(SELECT ID FROM Pedido WHERE cpf_cli=(SELECT CPF FROM Cliente WHERE Email='b.mor20@gmail.com')),(SELECT ISBN FROM Livro WHERE Localizacao='CD-P2-D'), 1);

INSERT INTO Livro_Genero VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CE-P1-B'),(SELECT ID FROM genero WHERE Nome='Ficção'), 1);
INSERT INTO Livro_Genero VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CA-P2-A'),(SELECT ID FROM genero WHERE Nome='Horror'), 1);
INSERT INTO Livro_Genero VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CD-P2-D'),(SELECT ID FROM genero WHERE Nome='Mistério'), 1);
INSERT INTO Livro_Genero VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CA-P4-L'),(SELECT ID FROM genero WHERE Nome='Romance'), 1);
INSERT INTO Livro_Genero VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CB-P5-C'),(SELECT ID FROM genero WHERE Nome='Literatura Brasileira'), 1);

INSERT INTO Livro_Autor VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CA-P2-A'),(SELECT ID FROM Autor WHERE Nome='Andrew Pyper'), 1);
INSERT INTO Livro_Autor VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CB-P5-C'),(SELECT ID FROM Autor WHERE Nome='Caio Prado Jr.'), 1);
INSERT INTO Livro_Autor VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CD-P2-D'),(SELECT ID FROM Autor WHERE Nome='Joël Dicker'), 1);
INSERT INTO Livro_Autor VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CE-P1-B'),(SELECT ID FROM Autor WHERE Nome='Hermann Hesse'), 1);
INSERT INTO Livro_Autor VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CA-P4-L'),(SELECT ID FROM Autor WHERE Nome='Ken Follet'), 1);

INSERT INTO Versao VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CB-P5-C'),(SELECT ID FROM Tipo_Livro WHERE Nome='Capa Comum'), 1);
INSERT INTO Versao VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CD-P2-D'),(SELECT ID FROM Tipo_Livro WHERE Nome='Capa Comum'), 1);
INSERT INTO Versao VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CE-P1-B'),(SELECT ID FROM Tipo_Livro WHERE Nome='Capa Dura'), 1);
INSERT INTO Versao VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CA-P4-L'),(SELECT ID FROM Tipo_Livro WHERE Nome='Trilogia'), 1);
INSERT INTO Versao VALUES 
((SELECT ISBN FROM Livro WHERE Localizacao='CA-P2-A'),(SELECT ID FROM Tipo_Livro WHERE Nome='Box'), 1);

/*-------------------------------------------------------------------------------------------*/

/*2 - View's*/

/*1*/
create view Cliente_total_pedido as
select c.Nome, count(p.cpf_cli) as N_de_compras, p.Valor_Total_Prod
from cliente c,  pedido p, item i
where c.cpf = p.cpf_cli and i.id_ped = p.ID
GROUP BY c.CPF, p.ID;

select * from Cliente_total_pedido;

/*2*/
create view Maiores_14 as
select l.titulo, au.nome as autor, l.Classificacao_Indicativa
from autor au, livro l, livro_autor lv
where au.ID = lv.id_au and  lv.ISBN_li = l.ISBN and l.Classificacao_Indicativa >= +14;

select * from Maiores_14;

/*3*/
create view Pedidos_pandemia as
SELECT p.ID AS Numero_Pedido, p.DATA, c.Nome AS Nome_Cliente, p.Valor_Total, i.Subtotal, l.Titulo
FROM Pedido p
INNER JOIN Cliente c ON p.cpf_cli = c.CPF
INNER JOIN Item i ON p.ID = i.id_ped
INNER JOIN Livro l ON i.ISBN_liv = l.ISBN
WHERE p.Data between '2020-01-01' and '2023-12-31';

select * from Pedidos_pandemia;

/*4*/
create view Filtro_livro as
SELECT l.Titulo AS Titulo_Livro, e.Nome AS Nome_Editora, t.Nome AS Tipo_Livro
FROM Livro l
INNER JOIN Editora e ON l.id_editora = e.ID
INNER JOIN Versao v ON l.ISBN = v.ISBN_lv
INNER JOIN Tipo_Livro t ON v.id_tipo_lv = t.ID;

select * from Filtro_livro;

/*5*/
create view Cliente_entregas as
SELECT c.Nome AS Nome_Cliente, c.CPF AS CPF_Cliente, e.N_Residencial AS Numero_Residencial, e.CEP AS Codigo_Postal
FROM Cliente c
INNER JOIN Endereco e ON c.CPF = e.id_cliente;

select * from Cliente_entregas;

/*6*/
create view Controle_estoque as
select l.titulo, g.nome as genero, l.quantidade
from Livro l, genero g, livro_genero lg
where g.id = lg.id_gen and lg.ISBN_l = l.ISBN and l.quantidade > 200;

select * from Controle_estoque;

/*2.1 - Index's */

Create Index idx_id_autor on Livro_Autor(id_au);
Create Index idx_data on Pedido(Data);
Create Index idx_genero_quantidade ON Livro_Genero (id_gen, ISBN_l);

SHOW INDEX from Livro_Autor;
SHOW INDEX from Pedido;
SHOW INDEX from Livro_Genero;

/*-------------------------------------------------------------------------------------------*/