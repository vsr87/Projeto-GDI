----- CONSULTAS -----


-- Consulta GROUP BY/HAVING -- Projetar o ID das academias com mais de 14 equipamentos/maquinas
SELECT ID_Academia, COUNT(COD_EQM) AS qtd_Equipamentos
FROM tem
GROUP BY ID_Academia
HAVING COUNT(COD_EQM) > 14;


-- Consulta JUNÇÃO INTERNA -- Projetar o ID e Endereço das academias com seus respectivos números dos planos (Num) e os preços de cada um
SELECT P.ID_Academia, A.Endereco_Descricao, P.Num, P.Preco
FROM Plano P
INNER JOIN Academia A ON P.ID_Academia = A.ID_Academia;


-- Consulta JUNÇÃO EXTERNA -- Projetar o CEP das academias sem funcionários trabalhando
SELECT A.ENDERECO_CEP
FROM FUNCIONARIOS F RIGHT OUTER JOIN ACADEMIA A ON (A.ID_ACADEMIA = F.ID_ACADEMIA)
WHERE F.ID_ACADEMIA IS NULL;


-- Consulta SEMI-JOIN -- Projetar o CEP das academias com alunos matriculados
SELECT A.ENDERECO_CEP
FROM ACADEMIA A 
WHERE A.ID_ACADEMIA IN 
	(SELECT ALUNO.ID_ACADEMIA
    FROM ALUNO
    WHERE ALUNO.ID_ACADEMIA IS NOT NULL);


-- Consulta ANTI-JOIN -- Projetar o CEP das academias sem alunos matriculados
SELECT A.ENDERECO_CEP
FROM ACADEMIA A 
WHERE A.ID_ACADEMIA NOT IN 
	(SELECT ALUNO.ID_ACADEMIA
    FROM ALUNO
    WHERE ALUNO.ID_ACADEMIA IS NOT NULL);


-- Subconsulta do tipo escalar -- Projetar o nome do funcionário com maior salario 
SELECT Nome
FROM Funcionarios
WHERE Salario = (SELECT MAX(Salario) FROM Funcionarios);


-- Subconsulta do tipo linha -- Projetar o funcionário que trabalha na mesma academia e recebe o mesmo que o funcionário de CPF "11111111"
SELECT F.Nome
FROM Funcionarios F
WHERE (F.ID_Academia,F.Salario) = 
        (SELECT F.ID_Academia,F.Salario FROM Funcionarios F
        WHERE F.CPF_Func ='11111111');


-- Subconsulta do tipo tabela -- Projetar os nomes e respectivos salários dos funcionários que ganham mais que a média salarial da empresa
SELECT Nome, Salario
FROM Funcionarios
WHERE Salario > (
    SELECT AVG(Salario) 
    FROM Funcionarios
);


-- Operação de conjunto INTERSECT -- Projetar o nome dos funcionários que também são alunos
SELECT Nome FROM Funcionarios
INTERSECT
SELECT Nome FROM Aluno;







