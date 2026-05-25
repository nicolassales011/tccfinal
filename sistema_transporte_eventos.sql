
CREATE DATABASE sistema_transporte_eventos;
USE sistema_transporte_eventos;

-- =====================================
-- TABELA USUARIO
-- =====================================

CREATE TABLE tb_usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATETIME,
    tipo VARCHAR(20)
);

-- =====================================
-- TABELA MOTORISTA
-- =====================================

CREATE TABLE tb_motorista (
    id_motorista INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    cnh VARCHAR(20) NOT NULL,
    placa_veiculo VARCHAR(10),
    modelo_veiculo VARCHAR(50),
    cor_veiculo VARCHAR(30),

    CONSTRAINT fk_motorista_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES tb_usuario(id_usuario)
);

-- =====================================
-- TABELA PASSAGEIRO
-- =====================================

CREATE TABLE tb_passageiro (
    id_passageiro INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,

    CONSTRAINT fk_passageiro_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES tb_usuario(id_usuario)
);

-- =====================================
-- TABELA EVENTO
-- =====================================

CREATE TABLE tb_evento (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    local VARCHAR(100),
    data_evento DATETIME,
    descricao TEXT
);

-- =====================================
-- TABELA VIAGEM
-- =====================================

CREATE TABLE tb_viagem (
    id_viagem INT PRIMARY KEY AUTO_INCREMENT,
    id_motorista INT NOT NULL,
    id_evento INT NOT NULL,

    origem VARCHAR(100),
    destino VARCHAR(100),
    data_hora DATETIME,
    vagas_disponiveis INT,
    preco_vaga DECIMAL(10,2),
    observacao TEXT,

    CONSTRAINT fk_viagem_motorista
    FOREIGN KEY (id_motorista)
    REFERENCES tb_motorista(id_motorista),

    CONSTRAINT fk_viagem_evento
    FOREIGN KEY (id_evento)
    REFERENCES tb_evento(id_evento)
);

-- =====================================
-- TABELA RESERVA
-- =====================================

CREATE TABLE tb_reserva (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_viagem INT NOT NULL,
    id_passageiro INT NOT NULL,

    data_reserva DATETIME,
    status VARCHAR(30),

    CONSTRAINT fk_reserva_viagem
    FOREIGN KEY (id_viagem)
    REFERENCES tb_viagem(id_viagem),

    CONSTRAINT fk_reserva_passageiro
    FOREIGN KEY (id_passageiro)
    REFERENCES tb_passageiro(id_passageiro)
);

-- =====================================
-- TABELA AVALIACAO
-- =====================================

CREATE TABLE tb_avaliacao (
    id_avaliacao INT PRIMARY KEY AUTO_INCREMENT,
    id_reserva INT NOT NULL,

    nota INT,
    comentario TEXT,
    data_avaliacao DATETIME,

    CONSTRAINT fk_avaliacao_reserva
    FOREIGN KEY (id_reserva)
    REFERENCES tb_reserva(id_reserva)
);

-- =====================================
-- EXEMPLOS DE INSERT
-- =====================================

INSERT INTO tb_usuario
(nome, email, senha, telefone, data_cadastro, tipo)
VALUES
('João Silva', 'joao@email.com', '123456', '13999999999', NOW(), 'motorista');

INSERT INTO tb_evento
(nome, local, data_evento, descricao)
VALUES
('Show de Rock', 'São Paulo', '2026-07-15 20:00:00', 'Evento musical');
