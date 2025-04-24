--Consultar os nomes de todos os estados (UF) e das suas cidades
SELECT E_UF.nome_uf , E_Cidade.nome
FROM E_UF 
INNER JOIN E_Cidade ON E_UF.sigla_uf = E_Cidade.sigla_uf;

--Consultar os nomes dos funcionários.
SELECT nome
FROM E_Funcionario;

--Consultar os nomes de todos os funcionários e o nome da cidade em que mora
SELECT E_Funcionario.nome, E_Cidade.nome
FROM E_Funcionario
INNER JOIN E_Endereco ON (E_Funcionario.codigo_funcionario = E_Endereco.codigo_funcionario)
INNER JOIN E_Cidade ON (E_Endereco.codigo_cidade = E_Cidade.codigo_cidade);


--Consultar as descrições dos projetos e o nome do coordenador do projeto
SELECT descricao, nome
FROM E_Projeto
INNER JOIN E_Funcionario ON (E_Projeto.codigo_coordenador = E_Funcionario.codigo_funcionario);


--Consultar os nomes de todos os funcionários e as descrições dos projetos em que participa
SELECT nome , descricao
FROM E_Funcionario
LEFT JOIN  E_FuncionarioParticipaProjeto ON (E_Funcionario.codigo_funcionario = E_FuncionarioParticipaProjeto.codigo_funcionario)
LEFT JOIN E_Projeto ON (E_Projeto.codigo_projeto = E_FuncionarioParticipaProjeto.codigo_projeto);


--Consultar as descrições de todos os setores e os nomes dos funcionários que trabalham no setor
SELECT E_Setor.nome, E_Funcionario.nome
FROM E_Setor
LEFT JOIN E_Funcionario ON (E_Funcionario.codigo_setor = E_Setor.codigo_setor);


--Consultar as descrições dos setores e o nome do chefe de cada setor.
SELECT E_Setor.nome, E_Funcionario.nome
FROM E_Setor
INNER JOIN E_FuncionarioChefiaSetor ON (E_FuncionarioChefiaSetor.codigo_setor = E_Setor.codigo_setor) AND (E_FuncionarioChefiaSetor.data_fim IS NULL)
INNER JOIN E_Funcionario ON (E_FuncionarioChefiaSetor.codigo_funcionario = E_Funcionario.codigo_funcionario);



--BANCO DE DADOS LIVROS 5 FÁCEIS
-- Liste o nome das cidades e seus respectivos estados (UF).
SELECT descricao, nome
FROM b_cidade c
    INNER JOIN b_uf uf ON (c.siglauf = uf.siglauf);


-- Mostre o nome das editoras e a cidade onde estão localizadas.
SELECT e.nome, c.nome
FROM b_editora e
     INNER JOIN b_cidade c ON (e.codcidade = c.codcidade);


-- Mostre o nome das editoras e o estado onde estão localizadas.
SELECT e.nome, uf.descricao 
FROM b_editora e
    INNER JOIN b_cidade c ON (e.codcidade = c.codcidade)
        INNER JOIN b_uf uf ON (c.siglauf = uf.siglauf);


-- Liste os livros com o nome da editora correspondente.
SELECT titulo, nome
FROM b_livro l
    INNER JOIN b_editora e ON (l.codeditora = e.codeditora);


-- Liste os livros com a cidade e estado da editora.
SELECT l.titulo, e.nome AS Editora , c.nome AS Cidade, uf.descricao AS Estado 
FROM b_livro l
    INNER JOIN b_editora e ON (l.codeditora = e.codeditora)
        INNER JOIN b_cidade c ON (e.codcidade = c.codcidade)
            INNER JOIN b_uf uf ON (c.siglauf = uf.siglauf);








--Conte quantas cidades estão cadastradas no banco
SELECT COUNT(codcidade) AS qtd_cidades_cadastradas
FROM b_cidade;


--Conte quantas editoras existem por estado (UF).
SELECT uf.siglauf, COUNT(e.codeditora) AS total_editoras
FROM b_editora e
    INNER JOIN b_cidade c ON (e.codcidade = c.codcidade)
        INNER JOIN b_uf uf ON (c.siglauf = uf.siglauf)
            GROUP BY uf.siglauf;


--Mostre o número total de livros cadastrados
SELECT COUNT(codlivro) AS qtd_livros_cadastrados
FROM b_livro;

--Exiba a média de páginas de todos os livros.
SELECT AVG(paginas) AS media_paginas
FROM b_livro;


--Mostre o maior e o menor número de páginas entre os livros cadastrados.
SELECT MIN(paginas) AS menor_qtd_paginas, MAX(paginas) AS maior_qtd_paginas
FROM b_livro;


--Mostre a quantidade de editoras por cidade.
SELECT c.nome, COUNT(e.codcidade) AS qtd_editoras_na_cidade
FROM b_cidade c
    INNER JOIN b_editora e ON (c.codcidade = e.codcidade)
        GROUP BY c.nome;

Calcule a média de edições dos livros publicados por cada editora.
SELECT e.nome, AVG(l.edicao) AS media_edicões
FROM b_editora e 
    INNER JOIN b_livro l ON (e.codeditora = l.codeditora)
        GROUP BY e.nome;



--Liste o total de livros publicados por cada editora.
SELECT e.nome, COUNT(l.codeditora) AS qtd_livros_editora
FROM b_editora e
    INNER JOIN b_livro l ON (e.codeditora = l.codeditora)
        GROUP BY e.nome;



--Mostre a quantidade de livros escritos por cada autor.
SELECT a.nome, COUNT(lv.codautor) AS qtd_livros_autor
FROM b_autor a
    INNER JOIN b_livroautor lv ON (a.codautor = lv.codautor)
        GROUP BY a.nome;




--Mostre o total de páginas publicadas por cada editora.
SELECT e.nome, SUM(l.paginas) AS qtd_paginas_publicada_editora
FROM b_editora e
    INNER JOIN b_livro l ON (e.codeditora = l.codeditora)
        GROUP BY e.nome;


--Exiba a média de páginas dos livros de cada autor.
SELECT a.nome, AVG(l.paginas) AS media_paginas_por_autor
FROM b_autor a
    INNER JOIN b_livroautor lv ON (a.codautor = lv.codautor)
        INNER JOIN b_livro l ON (lv.codlivro = l.codlivro)
            GROUP BY a.nome;



--Liste as cidades e o número de editoras em cada uma, exibindo apenas as cidades com mais de uma editora.
SELECT c.nome, COUNT(e.codeditora)
FROM b_cidade c
    INNER JOIN b_editora e ON (c.codcidade = e.codeditora)
        HAVING COUNT(e.codeditora) = 1
            GROUP by c.nome;

--Mostre quais autores têm mais de dois livros cadastrados.
SELECT a.nome, COUNT(lv.codautor)
FROM b_autor a
    INNER JOIN b_livroautor lv ON (a.codautor = lv.codautor )
        GROUP BY a.nome
            HAVING COUNT(lv.codautor) = 1;