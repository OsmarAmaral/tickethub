CREATE TABLE clientes (
  cliente_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(49) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  senha VARCHAR(255) NOT NULL
);

CREATE TABLE eventos (
  evento_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  local VARCHAR(255) NOT NULL,
  data DATE NOT NULL,
  horario TIME,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE ingressos (
  evento_id INT NOT NULL,
  cliente_id INT NOT NULL,
  PRIMARY KEY (evento_id, cliente_id),
  FOREIGN KEY (evento_id) REFERENCES eventos(evento_id) ON DELETE CASCADE,
  FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id) ON DELETE CASCADE
);

-- Query que cria clientes
INSERT INTO clientes (nome, email, senha)
VALUES ('Teste de Souza', 'teste.souza@email.com', '1234567');

-- Query que cria eventos
INSERT INTO eventos (nome, local, data, horario) 
VALUES ('Show do DJ Música', 'Rua Maranguapi, 123 - Jardim Bosque', '2025-09-30', '10:30:00');

-- Query que liga ingressos
INSERT INTO ingressos (evento_id, cliente_id) 
VALUES (1, 1);

-- Consulta simples
SELECT c.nome AS Cliente, e.nome AS Evento, e.local AS Endereço, e.data AS Data, e.horario AS horario
FROM ingressos AS i
INNER JOIN eventos AS e ON e.evento_id = i.evento_id
INNER JOIN clientes AS c ON c.cliente_id = i.cliente_id;