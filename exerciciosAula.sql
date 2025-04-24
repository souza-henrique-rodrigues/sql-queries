--Consultar quantas tuplas (linhas/registros) estão cadastradas na tabela e_cidade.
SELECT COUNT(codigo_cidade) AS qtd_cidades
    FROM e_cidade;

--Consultar quantos funcionários são do sexo masculino.
SELECT sexo, COUNT(sexo) 
    FROM e_funcionario f
        GROUP BY sexo;

--Consultar a quantidade de funcionários em cada setor
SELECT s.nome, COUNT(s.codigo_setor) AS qtd_funcionarios
FROM e_setor s
INNER JOIN e_funcionario f ON (s.codigo_setor = f.codigo_setor)
GROUP BY s.nome;


--Consultar o total de pagamentos recebidos por cada funcionário.
SELECT f.nome, COUNT(p.codigo_funcionario) AS qtd_pagamamentos_recebidos
FROM e_funcionario f
INNER JOIN e_pagamento p ON (f.codigo_funcionario = p.codigo_funcionario)
GROUP BY f.nome;

--Consultar quantos funcionários moram em cada cidade.
SELECT c.nome, COUNT(f.codigo_funcionario) AS qtd_funcionarios
FROM e_funcionario f
INNER JOIN e_endereco e ON (f.codigo_funcionario = e.codigo_funcionario)
INNER JOIN e_cidade c ON (e.codigo_cidade = c.codigo_cidade)
GROUP BY c.nome;


--Consultar quantas cidades tem cada Unidade Federativa.
SELECT uf.nome_uf, COUNT(c.codigo_cidade) AS qtd_cidades
FROM e_uf uf
INNER JOIN e_cidade c ON (uf.sigla_uf = c.sigla_uf)
GROUP BY uf.nome_uf;



--Consulte os nomes dos funcionários que moram em Porto Alegre. [Faça 2 versões: utilize IN e single-row]
SELECT f.nome
FROM e_funcionario f
INNER JOIN e_endereco e ON f.codigo_funcionario = e.codigo_funcionario
WHERE e.codigo_cidade = (
    SELECT codigo_cidade 
    FROM e_cidade
    WHERE nome = 'Porto Alegre'
);

SELECT f.nome
FROM e_funcionario f
INNER JOIN e_endereco e ON f.codigo_funcionario = e.codigo_funcionario
WHERE codigo_cidade IN (
    SELECT codigo_cidade
    FROM e_cidade
    WHERE nome = 'Porto Alegre'
);



--. Consulte os nomes dos funcionários que NÃO moram no bairro Centro de Porto Alegre. [Faça 2 versões: utilize IN e single-row]
SELECT f.nome
FROM e_funcionario f
INNER JOIN e_endereco e ON f.codigo_funcionario = e.codigo_funcionario
WHERE f.codigo_funcionario NOT IN (
    SELECT codigo_funcionario
    FROM e_endereco e
    INNER JOIN e_cidade c ON e.codigo_cidade = c.codigo_cidade
    WHERE e.bairro = 'Restinga' AND c.nome = 'Porto Alegre'
);

--Consulte os nomes dos funcionários que são chefes de setores ou que são coordenadores de projetos. [Utilize IN]
SELECT DISTINCT f.nome
FROM e_funcionario f
WHERE f.codigo_funcionario IN (
    SELECT f.codigo_funcionario
    FROM e_funcionario f
    INNER JOIN e_funcionariochefiasetor fcs ON f.codigo_funcionario = fcs.codigo_funcionario
    UNION
    SELECT f.codigo_funcionario
    FROM e_funcionario f
    INNER JOIN e_projeto p ON f.codigo_funcionario = p.codigo_coordenador
);


-- Consulte os nomes dos funcionários que tem salário hora inicial maior que o salário hora inicial de qualquer funcionário do setor 2.

SELECT f.nome
FROM e_funcionario f
WHERE salario_hora_inicial > (
    SELECT salario_hora_inicial
    FROM e_funcionario
    WHERE codigo_setor = 2
    AND ROWNUM = 1
);

SELECT f.nome
FROM e_funcionario f
WHERE f.codigo_setor != 2
AND f.salario_hora_inicial >
ANY (
    SELECT f.salario_hora_inicial
    FROM e_funcionario f
    WHERE f.codigo_setor = 2
);


--Consulte os nomes dos funcionários que tem salário hora inicial menor que o salário hora inicial de todos os funcionários do setor 2.
SELECT f.nome, salario_hora_inicial
FROM e_funcionario f
WHERE f.codigo_setor != 1 
AND f.salario_hora_inicial < ALL (
    SELECT salario_hora_inicial
    FROM e_funcionario f
    WHERE f.codigo_setor = 1
)
ORDER BY salario_hora_inicial;






