
USE sistema_transporte_eventos;


SELECT * FROM tb_usuario;


SELECT 
    m.id_motorista,
    u.nome,
    u.email,
    u.telefone,
    m.cnh,
    m.placa_veiculo,
    m.modelo_veiculo
FROM tb_motorista m
INNER JOIN tb_usuario u
ON m.id_usuario = u.id_usuario;


SELECT 
    p.id_passageiro,
    u.nome,
    u.email,
    u.telefone
FROM tb_passageiro p
INNER JOIN tb_usuario u
ON p.id_usuario = u.id_usuario;


SELECT * FROM tb_evento;


SELECT
    v.id_viagem,
    u.nome AS motorista,
    e.nome AS evento,
    v.origem,
    v.destino,
    v.data_hora,
    v.vagas_disponiveis,
    v.preco_vaga
FROM tb_viagem v

INNER JOIN tb_motorista m
ON v.id_motorista = m.id_motorista

INNER JOIN tb_usuario u
ON m.id_usuario = u.id_usuario

INNER JOIN tb_evento e
ON v.id_evento = e.id_evento;


SELECT
    r.id_reserva,
    u.nome AS passageiro,
    v.origem,
    v.destino,
    r.data_reserva,
    r.status
FROM tb_reserva r

INNER JOIN tb_passageiro p
ON r.id_passageiro = p.id_passageiro

INNER JOIN tb_usuario u
ON p.id_usuario = u.id_usuario

INNER JOIN tb_viagem v
ON r.id_viagem = v.id_viagem;

SELECT
    a.id_avaliacao,
    u.nome AS passageiro,
    a.nota,
    a.comentario,
    a.data_avaliacao
FROM tb_avaliacao a

INNER JOIN tb_reserva r
ON a.id_reserva = r.id_reserva

INNER JOIN tb_passageiro p
ON r.id_passageiro = p.id_passageiro

INNER JOIN tb_usuario u
ON p.id_usuario = u.id_usuario;


SELECT
    v.id_viagem,
    COUNT(r.id_reserva) AS total_reservas
FROM tb_viagem v

LEFT JOIN tb_reserva r
ON v.id_viagem = r.id_viagem

GROUP BY v.id_viagem;


SELECT
    AVG(nota) AS media_avaliacoes
FROM tb_avaliacao;


SELECT
    u.nome,
    COUNT(v.id_viagem) AS total_viagens
FROM tb_viagem v

INNER JOIN tb_motorista m
ON v.id_motorista = m.id_motorista

INNER JOIN tb_usuario u
ON m.id_usuario = u.id_usuario

GROUP BY u.nome

ORDER BY total_viagens DESC;


SELECT
    u.nome,
    COUNT(r.id_reserva) AS total_reservas
FROM tb_reserva r

INNER JOIN tb_passageiro p
ON r.id_passageiro = p.id_passageiro

INNER JOIN tb_usuario u
ON p.id_usuario = u.id_usuario

GROUP BY u.nome

ORDER BY total_reservas DESC;


SELECT *
FROM tb_viagem
WHERE vagas_disponiveis > 0;


SELECT
    v.id_viagem,
    e.nome AS evento,
    v.origem,
    v.destino
FROM tb_viagem v

INNER JOIN tb_evento e
ON v.id_evento = e.id_evento

WHERE e.nome = 'Show de Rock';


SELECT COUNT(*) AS total_usuarios
FROM tb_usuario;


SELECT
    SUM(v.preco_vaga) AS faturamento_total
FROM tb_reserva r

INNER JOIN tb_viagem v
ON r.id_viagem = v.id_viagem;
