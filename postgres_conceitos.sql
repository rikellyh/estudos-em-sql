---Criando o banco de dados

create database teste;

--Criando uma tabela

CREATE TABLE IF NOT EXISTS usuarios(
      id BIGSERIAL CONSTRAINT pk_usuarios PRIMARY KEY,
      nome VARCHAR(100) NOT NULL,
      idade INTEGER
    );	

    ---Inserindo valores

   INSERT INTO
        usuarios(nome, idade)
      VALUES
        ('Patrick Nekel', 23),
        ('Eduardo', 26),
        ('Ivan', 26),
        ('Darnley', 31);
       	
   ALTER TABLE
  usuarios

  ---Adicionando uma nova coluna

ADD
  COLUMN comprimento VARCHAR(50);
 
  --Excluindo essa coluna

ALTER TABLE usuarios DROP COLUMN IF EXISTS comprimento;

---Verificando o comprimento de caracteres estabelecendo uma condição

SELECT nome, length(nome)
	as comprimento
from
	usuarios
where length(nome)>1;
 
 ALTER TABLE
  usuarios
ALTER COLUMN
  idade
SET
  NOT NULL;
 
  ---Renomeando a coluna 'email' para 'apelido'

 ALTER TABLE usuarios RENAME email TO apelido;

ALTER TABLE usuarios DROP COLUMN IF EXISTS apelido;

ALTER TABLE
  usuarios
ADD
  COLUMN email VARCHAR(50);
 
  ---Atualizando dados na tabela

UPDATE
  usuarios
SET
  email = 'patrick@kenzie.com.br'
WHERE
  id = 1
RETURNING *;

---Deletando dados na tabela

DELETE FROM
  usuarios
WHERE
  id = 3
RETURNING *;

DELETE FROM
  usuarios
WHERE
  email = 'adm@kenzie.com'
RETURNING *;

---Contando o número de usuários com a letra P

SELECT
  COUNT(*)
FROM
  usuarios
WHERE
  nome LIKE 'P%';
 
 SELECT
    SUM(idade)
FROM
    usuarios;
   
   SELECT * FROM usuarios ORDER BY idade;
  
  CREATE TABLE IF NOT EXISTS products (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price FLOAT,
  CHECK (price > 0),
  category VARCHAR(50) NOT NULL
);

INSERT INTO
  products(name, price, category)
VALUES
  ('Chá Verde', 8.45, 'Bebidas'),
  ('Energético Monster', 7.50, 'Bebidas'),
  ('Lava-Roupas Refil', 25.99, 'Limpeza'),
  ('Amaciante', 22.99, 'Limpeza'),
  ('Chocolate Amargo Premium', 33.49, 'Confeitaria'),
  ('Barra de Chocolate', 4.49, 'Confeitaria');
 
 SELECT
    category, COUNT(*)
FROM
    products
GROUP BY
    category;
   
   SELECT
    category, AVG(price)
FROM
    products
GROUP BY
    category
HAVING avg(price) > 20.00;

select 
	avg(price)	
as valor_medio from products;

CREATE TABLE IF NOT EXISTS usuario (
  id BIGSERIAL PRIMARY KEY,
  nome VARCHAR(128) NOT NULL,
  idade INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS smartphone (
  id BIGSERIAL PRIMARY KEY,
  modelo VARCHAR(64) NOT NULL,
  numero VARCHAR(64) NULL,
  usuario_id INTEGER,
  FOREIGN KEY (usuario_id) REFERENCES usuario (id)
);

INSERT INTO
  usuario (nome, idade)
VALUES
  ('Pedro', 26),
  ('João', 23),
  ('Gabriela', 22),
  ('Márcia', 30);

INSERT INTO
  smartphone (modelo, numero, usuario_id)
VALUES
  ('Iphone 13', '', 3),
  ('Galaxy S21', '81234567', 3),
  ('Iphone 6', '81234578', 3),
  ('Edge 20', null, 1),
  ('Pixel 4', '91234567', 2),
  ('Galaxy S22 Ultra', '91238929', 4),
  ('Motorola V3', '95623482', null);
 
 SELECT
  *
FROM
  smartphone s
WHERE
  s.usuario_id = 3;
 
 SELECT
  *
FROM
  smartphone s
WHERE s.usuario_id IS NULL;

SELECT
  s.modelo
FROM
  smartphone s
WHERE s.numero LIKE '%9';

CREATE TABLE IF NOT EXISTS endereco(
  id BIGSERIAL PRIMARY KEY,
  pais VARCHAR(100) NOT NULL,
  estado VARCHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS pessoa(
  id BIGSERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  idade INTEGER NOT NULL,
  endereco_id INTEGER UNIQUE,
  CONSTRAINT fk_enderecos FOREIGN KEY (endereco_id) REFERENCES endereco(id)
);

INSERT INTO
  endereco (pais, estado)
VALUES
  ('Brasil', 'SP'),
  ('Brasil', 'PR'),
  ('Brasil', 'MG'),
  ('Brasil', 'BH');

INSERT INTO
  pessoa (nome, idade, endereco_id)
VALUES
  ('Joana', 22, 1),
  ('Carlos', 25, 2),
  ('Louise', 27, 3),
  ('Charlie', 21, null);
  
SELECT
  pessoa.nome,
  pessoa.idade,
  endereco.pais,
  endereco.estado
FROM
  pessoa

  ---Utilização do Join para relacionar os dados de duas tabelas, neste caso

  JOIN endereco
  ON endereco.id = pessoa.endereco_id;
  
 SELECT
  p.nome,
  p.idade,
  e.pais,
  e.estado

  --- AS para 'apelidar' a propriedade

FROM
  pessoa AS p
  
  ---Retorna todos os dados encontrados na tabela à esquerda de JOIN

LEFT JOIN endereco AS e
  ON e.id = p.endereco_id;
  
 SELECT
  p.nome,
  p.idade,
  e.pais,
  e.estado
FROM
  pessoa p

  ---Retorna todos os dados encontrados na tabela à direita de JOIN

RIGHT JOIN endereco e
  ON p.endereco_id = e.id;
  
 SELECT
  p.nome,
  p.idade,
  e.pais,
  e.estado
FROM

  ---Todas as linhas de dados da tabela à esquerda de JOIN e da tabela à direita 
  ---serão retornadas 

  pessoa p FULL OUTER
  JOIN endereco e ON p.endereco_id = e.id;
  
 CREATE TABLE IF NOT EXISTS pet (
  id BIGSERIAL PRIMARY KEY,
  nome VARCHAR(128) NOT NULL,
  especie VARCHAR(64) NOT NULL,
  raca VARCHAR(128) NOT NULL,
  dono_id INTEGER,
  FOREIGN KEY (dono_id) REFERENCES pessoa (id)
);

INSERT INTO
  pet (nome, especie, raca, dono_id)
VALUES
  ('Bob', 'Cachorro', 'Poodle', 1),
  ('Nyx', 'Gato', 'Persa', 2),
  ('Luna', 'Gato', 'Siamês', 3),
  ('Luigi', 'Cachorro', 'Desconhecida', 1),
  ('Mel', 'Gato', 'Sphynx', 4),
  ('Kiara', 'Gato', 'Angorá', 2);
  
 SELECT
  pessoa.nome,
  endereco.estado,
  endereco.pais,
  pet.nome,
  pet.raca
FROM
  pessoa

  ---Para obtermos os dados relacionados das duas tabelas:

  INNER JOIN endereco
  ON pessoa.endereco_id = endereco.id
  INNER JOIN pet
  ON pet.dono_id = pessoa.id;