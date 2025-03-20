
#Seleciona todos os estados + cidade de cada estado
SELECT nome_uf, nome
FROM E_UF, E_Cidade
WHERE
E_UF.sigla_uf = E_Cidade.sigla_uf;


#Seleciona todos os funcionarios pelo nome
SELECT nome
FROM E_Funcionario;


#Seleciona todos os funcionarios + cidade onde moram
SELECT 
    E_Funcionario.nome AS nome_funcionario,
    E_Cidade.nome AS nome_cidade
FROM
    E_Funcionario,
    E_Cidade,
    E_Endereco
WHERE
   E_Funcionario.codigo_funcionario = E_Endereco.codigo_funcionario
AND
   E_Endereco.codigo_cidade = E_Cidade.codigo_cidade;


#Seleciona a descrição do projeto e o cordenador do projeto
SELECT 
    E_Projeto.descricao AS descricao_projeto,
    E_Funcionario.nome AS cordenador_projeto
FROM
    E_Projeto,
    E_Funcionario
WHERE
    E_Projeto.codigo_coordenador = E_Funcionario.codigo_funcionario;


# Seleciona todos os funcionarios e todos projetos que participam
SELECT 
    E_Funcionario.nome AS nome_funcionario,
    E_Projeto.descricao AS descricao_projeto
FROM
    E_Funcionario,
    E_Projeto;



#Usando JOINS

#Exercicio 1 Consultar os nomes de todos os estados (UF) e das suas cidades
SELECT
    UF.nome_uf,
    C.nome
FROM
    E_UF UF 
    INNER JOIN E_Cidade C ON(UF.sigla_uf = C.sigla_uf);



#Exercicio 2 Consultar os nomes dos funcionários.
SELECT 
    F.nome
FROM
    E_Funcionario F;


#Exercicio 3 Consultar os nomes de todos os funcionários e o nome da cidade em que mora.
SELECT
    F.nome,
    C.nome
FROM 
    E_Funcionario F
    INNER JOIN E_Endereco E ON (F.codigo_funcionario = E.codigo_funcionario)
    INNER JOIN E_Cidade C ON (C.codigo_cidade = E.codigo_cidade);


#Exercicio 4 Consultar as descrições dos projetos e o nome do coordenador do projeto
SELECT
    P.descricao,
    F.nome AS "Cordenador do Projeto"
FROM
    E_Projeto P
    INNER JOIN E_Funcionario F ON (F.codigo_funcionario = P.codigo_coordenador);























