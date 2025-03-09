------------------------ Criação do Banco de Dados - Academia ------------------------

CREATE TABLE Academia ( 
    ID_Academia VARCHAR(4), 
    Endereco_CEP VARCHAR(8) NOT NULL, 
    Endereco_Descricao VARCHAR(100) NOT NULL, 
    Data_Abertura date, 
    CONSTRAINT PK_Academia PRIMARY KEY (ID_Academia)
);


CREATE TABLE Gratificacao ( 
    ID_Gratificacao VARCHAR(4), 
    Descricao_Gratificacao VARCHAR(100),
    CONSTRAINT PK_Grat PRIMARY KEY (ID_Gratificacao)
);

CREATE TABLE Funcionarios ( 
    CPF_Func VARCHAR(8), 
    Nome VARCHAR(80) NOT NULL, 
    Salario VARCHAR(100), 
    CPF_Chefe VARCHAR(8),
    ID_Academia VARCHAR(4),
    ID_Gratificacao VARCHAR(4),
    CONSTRAINT PK_Func PRIMARY KEY (CPF_Func),
    CONSTRAINT FK_Func_Chefe FOREIGN KEY (CPF_Chefe) REFERENCES Funcionarios (CPF_Func) ON DELETE SET NULL,
    CONSTRAINT FK_Func_Acad FOREIGN KEY (ID_Academia) REFERENCES Academia (ID_Academia) ON DELETE SET NULL,
    CONSTRAINT FK_Func_Grat FOREIGN KEY (ID_Gratificacao) REFERENCES Gratificacao (ID_Gratificacao) ON DELETE SET NULL
);

CREATE TABLE Auxiliar_Geral ( 
    CPF_Func VARCHAR(8), 
    Area_Responsavel VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Func_L PRIMARY KEY (CPF_Func),
    CONSTRAINT FK_Func_Limp FOREIGN KEY (CPF_Func) REFERENCES Funcionarios (CPF_Func) ON DELETE CASCADE
);

CREATE TABLE Balconista ( 
    CPF_Func VARCHAR(8), 
    Turno VARCHAR(10) CHECK (Turno IN ('Manhã', 'Tarde', 'Noite')) NOT NULL,
    CONSTRAINT PK_Func_B PRIMARY KEY (CPF_Func),
    CONSTRAINT FK_Func_Balc FOREIGN KEY (CPF_Func) REFERENCES Funcionarios (CPF_Func) ON DELETE CASCADE
);

CREATE TABLE Personal ( 
    CPF_Func VARCHAR(8), 
    CREF VARCHAR(8) NOT NULL UNIQUE,
    CONSTRAINT PK_Func_P PRIMARY KEY (CPF_Func),
    CONSTRAINT FK_Func_Pers FOREIGN KEY (CPF_Func) REFERENCES Funcionarios (CPF_Func) ON DELETE CASCADE
);

CREATE TABLE Treino(
    ID_Treino VARCHAR(5),
    CONSTRAINT PK_Treino PRIMARY KEY(ID_Treino)
);

CREATE TABLE Exercicios(
    ID_Treino VARCHAR(5),
    Exercicio VARCHAR(100),
    CONSTRAINT PK_EXERCICIOS PRIMARY KEY(ID_Treino, Exercicio),
    CONSTRAINT FK_EXER_TREINO FOREIGN KEY(ID_Treino) REFERENCES Treino(ID_Treino)
);

CREATE TABLE Plano(
    ID_Academia VARCHAR(4),
    Num NUMBER(2,0),
    Preco NUMBER(10,2),
    CONSTRAINT PK_PLANO PRIMARY KEY(ID_Academia, Num),
    CONSTRAINT FK_PLAN_ACAD FOREIGN KEY(ID_Academia) REFERENCES ACADEMIA(ID_Academia)
);

CREATE TABLE Beneficios(
    ID_Academia VARCHAR(4),
    Num NUMBER(2,0),
    Beneficio VARCHAR(100),
    CONSTRAINT PK_Beneficios PRIMARY KEY(ID_Academia, Num, Beneficio),
    CONSTRAINT FK_Ben_Plan FOREIGN KEY(ID_Academia, Num) REFERENCES Plano(ID_Academia, Num)
);

CREATE TABLE Equipamentos_Maquinas ( 
    COD_EQM VARCHAR(8), 
    Tipo VARCHAR(50) NOT NULL, 
    CONSTRAINT PK_Equipamentos PRIMARY KEY (COD_EQM)
);

CREATE TABLE Tem ( 
    COD_EQM VARCHAR(8), 
    ID_Academia VARCHAR(4), 
    CONSTRAINT PK_Tem PRIMARY KEY (COD_EQM, ID_Academia),
    CONSTRAINT FK_Tem_Equip FOREIGN KEY (COD_EQM) REFERENCES Equipamentos_Maquinas (COD_EQM) ON DELETE CASCADE,
    CONSTRAINT FK_Tem_Acad FOREIGN KEY (ID_Academia) REFERENCES Academia (ID_Academia) ON DELETE CASCADE
);

CREATE TABLE Aluno(
    CPF_Aluno VARCHAR(8),
    Nome VARCHAR(80) NOT NULL,
    DataNascimento DATE,
    ID_Academia VARCHAR(4),
    CONSTRAINT PK_Alu PRIMARY KEY(CPF_Aluno),
    CONSTRAINT FK_Alu_Acad FOREIGN KEY(ID_Academia) REFERENCES Academia(ID_Academia) ON DELETE SET NULL
);

CREATE TABLE Contatos(
    CPF_Aluno VARCHAR(8),
    Contato VARCHAR(8),
    CONSTRAINT PK_Cont PRIMARY KEY(CPF_Aluno,Contato),
    CONSTRAINT FK_Cont_Alu FOREIGN KEY(CPF_Aluno) REFERENCES Aluno(CPF_Aluno) ON DELETE CASCADE
);

CREATE TABLE Planotreino(
    ID_Treino VARCHAR(5),
    CPF_Aluno VARCHAR(8),
    DataTP DATE,
    CPF_Personal VARCHAR(8) NOT NULL,
    CONSTRAINT PK_PlaTre PRIMARY KEY(ID_Treino,CPF_Aluno,DataTP),
    CONSTRAINT FK_PlaTre_Tre FOREIGN KEY(ID_Treino) REFERENCES Treino(ID_Treino) ON DELETE CASCADE,
    CONSTRAINT FK_PlaTre_Alu FOREIGN KEY(CPF_Aluno) REFERENCES Aluno(CPF_Aluno) ON DELETE CASCADE,
    CONSTRAINT FK_PlaTre_Pers FOREIGN KEY(CPF_Personal) REFERENCES Personal(CPF_Func) ON DELETE CASCADE
);

CREATE TABLE Nutricionista(
    CRN VARCHAR(8),
    Nome VARCHAR(80) NOT NULL,
    CONSTRAINT PK_Nutri PRIMARY KEY(CRN)
);

CREATE TABLE Dieta(
    Protocolo VARCHAR(5),
    CRN VARCHAR(7),
    CPF_Aluno VARCHAR(8) NOT NULL UNIQUE,
    CONSTRAINT PK_Diet PRIMARY KEY(CRN,Protocolo),
    CONSTRAINT FK_Diet_Nutri FOREIGN KEY(CRN) REFERENCES Nutricionista(CRN) ON DELETE CASCADE,
    CONSTRAINT FK_Diet_Alu FOREIGN KEY(CPF_Aluno) REFERENCES Aluno(CPF_Aluno) ON DELETE CASCADE
);


------------------------ Povoamento do Banco de Dados - Academia ------------------------

INSERT INTO Academia VALUES ('1111', '11111111', 'Avenida Recife', TO_DATE('12/10/2010', 'DD/MM/YYYY'));
INSERT INTO Academia VALUES ('2222', '22222222', 'Avenida Salvador', TO_DATE('25/01/2018', 'DD/MM/YYYY'));
INSERT INTO Academia VALUES ('3333', '33333333', 'Avenida Paraiba', TO_DATE('30/03/2024', 'DD/MM/YYYY'));
INSERT INTO Academia VALUES ('4444', '44444444', 'Avenida Jaboatao', TO_DATE('22/09/2020', 'DD/MM/YYYY'));
INSERT INTO Academia VALUES ('5555', '55555555', 'Avenida Bahia', TO_DATE('27/12/2009', 'DD/MM/YYYY'));
INSERT INTO Academia VALUES ('6666', '66666666', 'Avenida Natal', TO_DATE('14/06/2007', 'DD/MM/YYYY'));
INSERT INTO Academia VALUES ('7777', '77777777', 'Avenida Maceio', TO_DATE('11/11/2015', 'DD/MM/YYYY'));
INSERT INTO Academia VALUES ('8888', '88888888', 'Avenida Tocantins', TO_DATE('02/08/2000', 'DD/MM/YYYY'));
INSERT INTO Academia VALUES ('9999', '99999999', 'Avenida Piaui', TO_DATE('12/06/2011', 'DD/MM/YYYY'));
INSERT INTO Academia VALUES ('1999', '19999999', 'Avenida Maranhao', TO_DATE('05/03/2025', 'DD/MM/YYYY'));

INSERT INTO Gratificacao VALUES ('G001', 'Bônus por desempenho');
INSERT INTO Gratificacao VALUES ('G002', 'Vale-alimentação');
INSERT INTO Gratificacao VALUES ('G003', 'Plano de saúde');
INSERT INTO Gratificacao VALUES ('G004', 'Auxílio transporte');
INSERT INTO Gratificacao VALUES ('G005', 'Comissão por vendas');
INSERT INTO Gratificacao VALUES ('G006', 'Gratificação por tempo de serviço');
INSERT INTO Gratificacao VALUES ('G007', 'Incentivo acadêmico');
INSERT INTO Gratificacao VALUES ('G008', 'Auxílio-creche');
INSERT INTO Gratificacao VALUES ('G009', 'Participação nos lucros');

INSERT INTO Funcionarios VALUES ('11111111', 'Carlos Silva', '3000.00', NULL, '1111', 'G001');
INSERT INTO Funcionarios VALUES ('22222222', 'Mariana Costa', '3200.00', '11111111', '1111', NULL);
INSERT INTO Funcionarios VALUES ('33333333', 'Roberto Lima', '3100.00', '11111111', '3333', 'G003');
INSERT INTO Funcionarios VALUES ('44444444', 'Ana Souza', '2900.00', '22222222', '3333', 'G004');
INSERT INTO Funcionarios VALUES ('55555555', 'Fernanda Rocha', '3050.00', '22222222', '5555', 'G005');
INSERT INTO Funcionarios VALUES ('66666666', 'Gustavo Nunes', '2800.00', '33333333', '6666', NULL);
INSERT INTO Funcionarios VALUES ('77777777', 'Juliana Mendes', '3150.00', '33333333', '7777', 'G007');
INSERT INTO Funcionarios VALUES ('88888888', 'Rafael Oliveira', '2950.00', '44444444', '8888', 'G008');
INSERT INTO Funcionarios VALUES ('99999999', 'Larissa Santos', '3250.00', '55555555', '9999', NULL);
INSERT INTO Funcionarios VALUES ('19999999', 'Joao Junior', NULL, NULL, NULL, NULL);

INSERT INTO Auxiliar_Geral VALUES ('11111111', 'Sala Principal');
INSERT INTO Auxiliar_Geral VALUES ('22222222', 'Banheiros');
INSERT INTO Auxiliar_Geral VALUES ('33333333', 'Recepção');
INSERT INTO Auxiliar_Geral VALUES ('44444444', 'Área de Musculação');
INSERT INTO Auxiliar_Geral VALUES ('55555555', 'Vestiários');
INSERT INTO Auxiliar_Geral VALUES ('66666666', 'Área de Musculação');
INSERT INTO Auxiliar_Geral VALUES ('77777777', 'Corredores');
INSERT INTO Auxiliar_Geral VALUES ('88888888', 'Banheiros');
INSERT INTO Auxiliar_Geral VALUES ('99999999', 'Entrada');

INSERT INTO Balconista VALUES ('11111111', 'Manhã');
INSERT INTO Balconista VALUES ('22222222', 'Tarde');
INSERT INTO Balconista VALUES ('33333333', 'Noite');
INSERT INTO Balconista VALUES ('44444444', 'Manhã');
INSERT INTO Balconista VALUES ('55555555', 'Tarde');
INSERT INTO Balconista VALUES ('66666666', 'Noite');
INSERT INTO Balconista VALUES ('77777777', 'Manhã');
INSERT INTO Balconista VALUES ('88888888', 'Tarde');
INSERT INTO Balconista VALUES ('99999999', 'Noite');

INSERT INTO Personal VALUES ('11111111', 'CREF1111');
INSERT INTO Personal VALUES ('22222222', 'CREF2222');
INSERT INTO Personal VALUES ('33333333', 'CREF3333');
INSERT INTO Personal VALUES ('44444444', 'CREF4444');
INSERT INTO Personal VALUES ('55555555', 'CREF5555');
INSERT INTO Personal VALUES ('66666666', 'CREF6666');
INSERT INTO Personal VALUES ('77777777', 'CREF7777');
INSERT INTO Personal VALUES ('88888888', 'CREF8888');
INSERT INTO Personal VALUES ('99999999', 'CREF9999');
INSERT INTO Personal VALUES ('19999999', 'CREF1999');

INSERT INTO Treino VALUES ('T0001');
INSERT INTO Treino VALUES ('T0002');
INSERT INTO Treino VALUES ('T0003');
INSERT INTO Treino VALUES ('T0004');
INSERT INTO Treino VALUES ('T0005');

INSERT INTO Exercicios VALUES ('T0001', 'Rosca barra W');
INSERT INTO Exercicios VALUES ('T0001', 'Rosca martelo halteres');
INSERT INTO Exercicios VALUES ('T0001', 'Rosca no banco inclinado');
INSERT INTO Exercicios VALUES ('T0001', 'Tríceps na polia com corda');
INSERT INTO Exercicios VALUES ('T0001', 'Tríceps testa');
INSERT INTO Exercicios VALUES ('T0001', 'Tríceps francês com halter');
INSERT INTO Exercicios VALUES ('T0002', 'Elevação lateral com halteres');
INSERT INTO Exercicios VALUES ('T0002', 'Elevação frontal com halteres');
INSERT INTO Exercicios VALUES ('T0002', 'Desenvolvimento com halteres');
INSERT INTO Exercicios VALUES ('T0002', 'Crucifixo inverso na máquina');
INSERT INTO Exercicios VALUES ('T0003', 'Supino reto na máquina');
INSERT INTO Exercicios VALUES ('T0003', 'Supino inclinado com halteres');
INSERT INTO Exercicios VALUES ('T0003', 'Crucifixo máquina');
INSERT INTO Exercicios VALUES ('T0003', 'Supino declinado na máquina');
INSERT INTO Exercicios VALUES ('T0004', 'Puxada alta pegada aberta pronada');
INSERT INTO Exercicios VALUES ('T0004', 'Puxada alta pegada fechada supinada');
INSERT INTO Exercicios VALUES ('T0004', 'Remada baixa no triângulo');
INSERT INTO Exercicios VALUES ('T0004', 'Remada curvada na barra com pegada supinada');
INSERT INTO Exercicios VALUES ('T0004', 'Levantamento Terra');
INSERT INTO Exercicios VALUES ('T0005', 'Agachamento livre');
INSERT INTO Exercicios VALUES ('T0005', 'Flexão de perna em pé máquina');
INSERT INTO Exercicios VALUES ('T0005', 'Levantamento Smith');
INSERT INTO Exercicios VALUES ('T0005', 'Elevação pélvica máquina');
INSERT INTO Exercicios VALUES ('T0005', 'Panturrilha máquina');

INSERT INTO Plano VALUES ('1111', 1, 1199.98);
INSERT INTO Plano VALUES ('1111', 2, 899.94);
INSERT INTO Plano VALUES ('1111', 3, 179.99);
INSERT INTO Plano VALUES ('1111', 4, 1439.88);
INSERT INTO Plano VALUES ('1111', 5, 79.99);
INSERT INTO Plano VALUES ('2222', 1, 1199.98);
INSERT INTO Plano VALUES ('2222', 2, 899.94);
INSERT INTO Plano VALUES ('2222', 3, 179.99);
INSERT INTO Plano VALUES ('2222', 4, 1439.88);
INSERT INTO Plano VALUES ('2222', 5, 79.99);
INSERT INTO Plano VALUES ('3333', 1, 1199.98);
INSERT INTO Plano VALUES ('3333', 2, 899.94);
INSERT INTO Plano VALUES ('3333', 3, 179.99);
INSERT INTO Plano VALUES ('3333', 4, 1439.88);
INSERT INTO Plano VALUES ('3333', 5, 79.99);
INSERT INTO Plano VALUES ('4444', 1, 1199.98);
INSERT INTO Plano VALUES ('4444', 2, 899.94);
INSERT INTO Plano VALUES ('4444', 3, 179.99);
INSERT INTO Plano VALUES ('4444', 4, 1439.88);
INSERT INTO Plano VALUES ('4444', 5, 79.99);
INSERT INTO Plano VALUES ('5555', 1, 1199.98);
INSERT INTO Plano VALUES ('5555', 2, 899.94);
INSERT INTO Plano VALUES ('5555', 3, 179.99);
INSERT INTO Plano VALUES ('5555', 4, 1439.88);
INSERT INTO Plano VALUES ('5555', 5, 79.99);
INSERT INTO Plano VALUES ('6666', 1, 1199.98);
INSERT INTO Plano VALUES ('6666', 2, 899.94);
INSERT INTO Plano VALUES ('6666', 3, 179.99);
INSERT INTO Plano VALUES ('6666', 4, 1439.88);
INSERT INTO Plano VALUES ('6666', 5, 79.99);
INSERT INTO Plano VALUES ('7777', 1, 1199.98);
INSERT INTO Plano VALUES ('7777', 2, 899.94);
INSERT INTO Plano VALUES ('7777', 3, 179.99);
INSERT INTO Plano VALUES ('7777', 4, 1439.88);
INSERT INTO Plano VALUES ('7777', 5, 79.99);
INSERT INTO Plano VALUES ('8888', 1, 1199.98);
INSERT INTO Plano VALUES ('8888', 2, 899.94);
INSERT INTO Plano VALUES ('8888', 3, 179.99);
INSERT INTO Plano VALUES ('8888', 4, 1439.88);
INSERT INTO Plano VALUES ('8888', 5, 79.99);
INSERT INTO Plano VALUES ('9999', 1, 1199.98);
INSERT INTO Plano VALUES ('9999', 2, 899.94);
INSERT INTO Plano VALUES ('9999', 3, 179.99);
INSERT INTO Plano VALUES ('9999', 4, 1439.88);
INSERT INTO Plano VALUES ('9999', 5, 79.99);



INSERT INTO Beneficios VALUES (1111, 1, 'Plano anual com horário livre');
INSERT INTO Beneficios VALUES (1111, 2, 'Plano semestral com horário livre');
INSERT INTO Beneficios VALUES (1111, 3, 'Plano mensal horário livre');
INSERT INTO Beneficios VALUES (1111, 4, 'Plano anual com toda as atividades inclusas com acesso a todas as academias');
INSERT INTO Beneficios VALUES (1111, 5, 'Plano mensal horário restrito');
INSERT INTO Beneficios VALUES (2222, 1, 'Plano anual com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (2222, 2, 'Plano semestral com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (2222, 3, 'Plano mensal com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (2222, 4, 'Plano anual com toda as atividades inclusas com acesso a todas as academias');
INSERT INTO Beneficios VALUES (2222, 5, 'Plano mensal horário restrito');
INSERT INTO Beneficios VALUES (3333, 1, 'Plano anual com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (3333, 2, 'Plano semestral com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (3333, 3, 'Plano mensal com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (3333, 4, 'Plano anual com toda as atividades inclusas com acesso a todas as academias');
INSERT INTO Beneficios VALUES (3333, 5, 'Plano mensal horário restrito');
INSERT INTO Beneficios VALUES (4444, 1, 'Plano anual com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (4444, 2, 'Plano semestral com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (4444, 3, 'Plano mensal com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (4444, 4, 'Plano anual com toda as atividades inclusas com acesso a todas as academias');
INSERT INTO Beneficios VALUES (4444, 5, 'Plano mensal horário restrito');
INSERT INTO Beneficios VALUES (5555, 1, 'Plano anual com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (5555, 2, 'Plano semestral com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (5555, 3, 'Plano mensal com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (5555, 4, 'Plano anual com toda as atividades inclusas com acesso a todas as academias');
INSERT INTO Beneficios VALUES (5555, 5, 'Plano mensal horário restrito');
INSERT INTO Beneficios VALUES (6666, 1, 'Plano anual com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (6666, 2, 'Plano semestral com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (6666, 3, 'Plano mensal com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (6666, 4, 'Plano anual com toda as atividades inclusas com acesso a todas as academias');
INSERT INTO Beneficios VALUES (6666, 5, 'Plano mensal horário restrito');
INSERT INTO Beneficios VALUES (7777, 1, 'Plano anual com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (7777, 2, 'Plano semestral com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (7777, 3, 'Plano mensal com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (7777, 4, 'Plano anual com toda as atividades inclusas com acesso a todas as academias');
INSERT INTO Beneficios VALUES (7777, 5, 'Plano mensal horário restrito');
INSERT INTO Beneficios VALUES (8888, 1, 'Plano anual com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (8888, 2, 'Plano semestral com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (8888, 3, 'Plano mensal com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (8888, 4, 'Plano anual com toda as atividades inclusas com acesso a todas as academias');
INSERT INTO Beneficios VALUES (8888, 5, 'Plano mensal horário restrito');
INSERT INTO Beneficios VALUES (9999, 1, 'Plano anual com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (9999, 2, 'Plano semestral com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (9999, 3, 'Plano mensal com toda as atividades inclusas');
INSERT INTO Beneficios VALUES (9999, 4, 'Plano anual com toda as atividades inclusas com acesso a todas as academias');
INSERT INTO Beneficios VALUES (9999, 5, 'Plano mensal horário restrito');


INSERT INTO Equipamentos_Maquinas VALUES ('EQM0001', 'Supino Reto');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0002', 'Supino declinado');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0003', 'Pec Deck');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0004', 'Banco para supino');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0005', 'Crossover');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0006', 'Pulley Costa');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0007', 'Remada Baixa');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0008', 'Remada Cavalinho');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0009', 'Pulley unilateral');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0010', 'Graviton');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0011', 'Kit de halteres');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0012', 'Kit de barras');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0013', 'Gaiola de agachamento');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0014', 'Smith machine');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0015', 'Hack machine');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0016', 'Squat machine');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0017', 'Cadeira extensora');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0018', 'Leg horizontal');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0019', 'Leg 45°');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0020', 'Cadeira flexora');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0021', 'Mesa flexora');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0022', 'Cadeira abdutora/adutora');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0023', 'Máquina de elevação pélvica');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0024', 'Máquina de panturrilhas');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0025', 'Balança');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0026', 'Kit de anilhas');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0027', 'Kit de kettlebells');
INSERT INTO Equipamentos_Maquinas VALUES ('EQM0028', 'Kit de cordas e elasticos');

INSERT INTO Tem VALUES ('EQM0001', '1111');
INSERT INTO Tem VALUES ('EQM0002', '1111');
INSERT INTO Tem VALUES ('EQM0003', '1111');
INSERT INTO Tem VALUES ('EQM0004', '1111');
INSERT INTO Tem VALUES ('EQM0005', '1111');
INSERT INTO Tem VALUES ('EQM0006', '1111');
INSERT INTO Tem VALUES ('EQM0007', '1111');
INSERT INTO Tem VALUES ('EQM0010', '1111');
INSERT INTO Tem VALUES ('EQM0012', '1111');
INSERT INTO Tem VALUES ('EQM0014', '1111');
INSERT INTO Tem VALUES ('EQM0016', '1111');
INSERT INTO Tem VALUES ('EQM0018', '1111');
INSERT INTO Tem VALUES ('EQM0020', '1111');
INSERT INTO Tem VALUES ('EQM0022', '1111');
INSERT INTO Tem VALUES ('EQM0024', '1111');
INSERT INTO Tem VALUES ('EQM0026', '1111');
INSERT INTO Tem VALUES ('EQM0028', '1111');

INSERT INTO Tem VALUES ('EQM0001', '2222');
INSERT INTO Tem VALUES ('EQM0003', '2222');
INSERT INTO Tem VALUES ('EQM0005', '2222');
INSERT INTO Tem VALUES ('EQM0007', '2222');
INSERT INTO Tem VALUES ('EQM0009', '2222');
INSERT INTO Tem VALUES ('EQM0011', '2222');
INSERT INTO Tem VALUES ('EQM0013', '2222');
INSERT INTO Tem VALUES ('EQM0015', '2222');
INSERT INTO Tem VALUES ('EQM0017', '2222');
INSERT INTO Tem VALUES ('EQM0019', '2222');
INSERT INTO Tem VALUES ('EQM0021', '2222');
INSERT INTO Tem VALUES ('EQM0023', '2222');
INSERT INTO Tem VALUES ('EQM0025', '2222');
INSERT INTO Tem VALUES ('EQM0027', '2222');

INSERT INTO Tem VALUES ('EQM0002', '3333');
INSERT INTO Tem VALUES ('EQM0004', '3333');
INSERT INTO Tem VALUES ('EQM0006', '3333');
INSERT INTO Tem VALUES ('EQM0008', '3333');
INSERT INTO Tem VALUES ('EQM0010', '3333');
INSERT INTO Tem VALUES ('EQM0012', '3333');
INSERT INTO Tem VALUES ('EQM0014', '3333');
INSERT INTO Tem VALUES ('EQM0016', '3333');
INSERT INTO Tem VALUES ('EQM0018', '3333');
INSERT INTO Tem VALUES ('EQM0020', '3333');
INSERT INTO Tem VALUES ('EQM0022', '3333');
INSERT INTO Tem VALUES ('EQM0024', '3333');
INSERT INTO Tem VALUES ('EQM0026', '3333');
INSERT INTO Tem VALUES ('EQM0028', '3333');

INSERT INTO Tem VALUES ('EQM0001', '4444');
INSERT INTO Tem VALUES ('EQM0002', '4444');
INSERT INTO Tem VALUES ('EQM0003', '4444');
INSERT INTO Tem VALUES ('EQM0004', '4444');
INSERT INTO Tem VALUES ('EQM0005', '4444');
INSERT INTO Tem VALUES ('EQM0006', '4444');
INSERT INTO Tem VALUES ('EQM0007', '4444');
INSERT INTO Tem VALUES ('EQM0008', '4444');
INSERT INTO Tem VALUES ('EQM0009', '4444');
INSERT INTO Tem VALUES ('EQM0010', '4444');
INSERT INTO Tem VALUES ('EQM0011', '4444');
INSERT INTO Tem VALUES ('EQM0012', '4444');
INSERT INTO Tem VALUES ('EQM0013', '4444');
INSERT INTO Tem VALUES ('EQM0014', '4444');
INSERT INTO Tem VALUES ('EQM0015', '4444');
INSERT INTO Tem VALUES ('EQM0016', '4444');
INSERT INTO Tem VALUES ('EQM0017', '4444');
INSERT INTO Tem VALUES ('EQM0018', '4444');
INSERT INTO Tem VALUES ('EQM0019', '4444');
INSERT INTO Tem VALUES ('EQM0020', '4444');
INSERT INTO Tem VALUES ('EQM0021', '4444');
INSERT INTO Tem VALUES ('EQM0022', '4444');
INSERT INTO Tem VALUES ('EQM0023', '4444');
INSERT INTO Tem VALUES ('EQM0024', '4444');
INSERT INTO Tem VALUES ('EQM0025', '4444');
INSERT INTO Tem VALUES ('EQM0026', '4444');
INSERT INTO Tem VALUES ('EQM0027', '4444');
INSERT INTO Tem VALUES ('EQM0028', '4444');

INSERT INTO Tem VALUES ('EQM0002', '5555');
INSERT INTO Tem VALUES ('EQM0004', '5555');
INSERT INTO Tem VALUES ('EQM0006', '5555');
INSERT INTO Tem VALUES ('EQM0008', '5555');
INSERT INTO Tem VALUES ('EQM0010', '5555');
INSERT INTO Tem VALUES ('EQM0012', '5555');
INSERT INTO Tem VALUES ('EQM0014', '5555');
INSERT INTO Tem VALUES ('EQM0016', '5555');
INSERT INTO Tem VALUES ('EQM0018', '5555');
INSERT INTO Tem VALUES ('EQM0020', '5555');
INSERT INTO Tem VALUES ('EQM0022', '5555');
INSERT INTO Tem VALUES ('EQM0024', '5555');
INSERT INTO Tem VALUES ('EQM0026', '5555');
INSERT INTO Tem VALUES ('EQM0028', '5555');

INSERT INTO Tem VALUES ('EQM0001', '6666');
INSERT INTO Tem VALUES ('EQM0003', '6666');
INSERT INTO Tem VALUES ('EQM0005', '6666');
INSERT INTO Tem VALUES ('EQM0007', '6666');
INSERT INTO Tem VALUES ('EQM0009', '6666');
INSERT INTO Tem VALUES ('EQM0011', '6666');
INSERT INTO Tem VALUES ('EQM0013', '6666');
INSERT INTO Tem VALUES ('EQM0015', '6666');
INSERT INTO Tem VALUES ('EQM0017', '6666');
INSERT INTO Tem VALUES ('EQM0019', '6666');
INSERT INTO Tem VALUES ('EQM0021', '6666');
INSERT INTO Tem VALUES ('EQM0023', '6666');
INSERT INTO Tem VALUES ('EQM0025', '6666');
INSERT INTO Tem VALUES ('EQM0027', '6666');

INSERT INTO Tem VALUES ('EQM0001', '7777');
INSERT INTO Tem VALUES ('EQM0003', '7777');
INSERT INTO Tem VALUES ('EQM0005', '7777');
INSERT INTO Tem VALUES ('EQM0007', '7777');
INSERT INTO Tem VALUES ('EQM0009', '7777');
INSERT INTO Tem VALUES ('EQM0011', '7777');
INSERT INTO Tem VALUES ('EQM0013', '7777');
INSERT INTO Tem VALUES ('EQM0015', '7777');
INSERT INTO Tem VALUES ('EQM0017', '7777');
INSERT INTO Tem VALUES ('EQM0019', '7777');
INSERT INTO Tem VALUES ('EQM0021', '7777');
INSERT INTO Tem VALUES ('EQM0023', '7777');
INSERT INTO Tem VALUES ('EQM0025', '7777');
INSERT INTO Tem VALUES ('EQM0027', '7777');

INSERT INTO Tem VALUES ('EQM0002', '8888');
INSERT INTO Tem VALUES ('EQM0004', '8888');
INSERT INTO Tem VALUES ('EQM0006', '8888');
INSERT INTO Tem VALUES ('EQM0008', '8888');
INSERT INTO Tem VALUES ('EQM0010', '8888');
INSERT INTO Tem VALUES ('EQM0012', '8888');
INSERT INTO Tem VALUES ('EQM0014', '8888');
INSERT INTO Tem VALUES ('EQM0016', '8888');
INSERT INTO Tem VALUES ('EQM0018', '8888');
INSERT INTO Tem VALUES ('EQM0020', '8888');
INSERT INTO Tem VALUES ('EQM0022', '8888');
INSERT INTO Tem VALUES ('EQM0024', '8888');
INSERT INTO Tem VALUES ('EQM0026', '8888');
INSERT INTO Tem VALUES ('EQM0028', '8888');

INSERT INTO Tem VALUES ('EQM0001', '9999');
INSERT INTO Tem VALUES ('EQM0002', '9999');
INSERT INTO Tem VALUES ('EQM0003', '9999');
INSERT INTO Tem VALUES ('EQM0004', '9999');
INSERT INTO Tem VALUES ('EQM0005', '9999');
INSERT INTO Tem VALUES ('EQM0006', '9999');
INSERT INTO Tem VALUES ('EQM0007', '9999');
INSERT INTO Tem VALUES ('EQM0008', '9999');
INSERT INTO Tem VALUES ('EQM0009', '9999');
INSERT INTO Tem VALUES ('EQM0010', '9999');
INSERT INTO Tem VALUES ('EQM0011', '9999');
INSERT INTO Tem VALUES ('EQM0012', '9999');
INSERT INTO Tem VALUES ('EQM0013', '9999');
INSERT INTO Tem VALUES ('EQM0014', '9999');
INSERT INTO Tem VALUES ('EQM0015', '9999');
INSERT INTO Tem VALUES ('EQM0016', '9999');
INSERT INTO Tem VALUES ('EQM0017', '9999');
INSERT INTO Tem VALUES ('EQM0018', '9999');
INSERT INTO Tem VALUES ('EQM0019', '9999');
INSERT INTO Tem VALUES ('EQM0020', '9999');
INSERT INTO Tem VALUES ('EQM0021', '9999');
INSERT INTO Tem VALUES ('EQM0022', '9999');
INSERT INTO Tem VALUES ('EQM0023', '9999');
INSERT INTO Tem VALUES ('EQM0024', '9999');
INSERT INTO Tem VALUES ('EQM0025', '9999');
INSERT INTO Tem VALUES ('EQM0026', '9999');
INSERT INTO Tem VALUES ('EQM0027', '9999');
INSERT INTO Tem VALUES ('EQM0028', '9999');

INSERT INTO Aluno VALUES ('12345678', 'Lucas Almeida', TO_DATE('15/04/1995', 'DD/MM/YYYY'), '1111');
INSERT INTO Aluno VALUES ('23456789', 'Mariana Costa', TO_DATE('22/08/1998', 'DD/MM/YYYY'), '2222');
INSERT INTO Aluno VALUES ('34567890', 'Fernando Lima', TO_DATE('03/12/1990', 'DD/MM/YYYY'), '3333');
INSERT INTO Aluno VALUES ('45678901', 'Juliana Castro', TO_DATE('07/06/2000', 'DD/MM/YYYY'), '4444');
INSERT INTO Aluno VALUES ('56789012', 'Rafael Oliveira', TO_DATE('29/09/1988', 'DD/MM/YYYY'), '5555');
INSERT INTO Aluno VALUES ('67890123', 'Camila Ferreira', TO_DATE('19/02/1993', 'DD/MM/YYYY'), '6666');
INSERT INTO Aluno VALUES ('78901234', 'Gustavo Oliveira', TO_DATE('11/07/1997', 'DD/MM/YYYY'), '7777');
INSERT INTO Aluno VALUES ('89012345', 'Larissa Santos', TO_DATE('04/05/1994', 'DD/MM/YYYY'), '8888');

INSERT INTO Contatos VALUES ('12345678', '99991111');
INSERT INTO Contatos VALUES ('12345678', '98882222');
INSERT INTO Contatos VALUES ('23456789', '97773333');
INSERT INTO Contatos VALUES ('34567890', '96664444');
INSERT INTO Contatos VALUES ('45678901', '95555555');
INSERT INTO Contatos VALUES ('56789012', '94446666');
INSERT INTO Contatos VALUES ('67890123', '93337777');
INSERT INTO Contatos VALUES ('78901234', '92228888');
INSERT INTO Contatos VALUES ('89012345', '91119999');
INSERT INTO Contatos VALUES ('89012345', '90001234');

INSERT INTO Planotreino VALUES ('T0001', '12345678', TO_DATE('01/02/2024', 'DD/MM/YYYY'), '11111111');
INSERT INTO Planotreino VALUES ('T0002', '23456789', TO_DATE('05/03/2024', 'DD/MM/YYYY'), '22222222');
INSERT INTO Planotreino VALUES ('T0003', '34567890', TO_DATE('10/04/2024', 'DD/MM/YYYY'), '33333333');
INSERT INTO Planotreino VALUES ('T0004', '45678901', TO_DATE('15/05/2024', 'DD/MM/YYYY'), '44444444');
INSERT INTO Planotreino VALUES ('T0005', '56789012', TO_DATE('20/06/2024', 'DD/MM/YYYY'), '55555555');
INSERT INTO Planotreino VALUES ('T0001', '67890123', TO_DATE('25/07/2024', 'DD/MM/YYYY'), '66666666');
INSERT INTO Planotreino VALUES ('T0002', '78901234', TO_DATE('30/08/2024', 'DD/MM/YYYY'), '77777777');
INSERT INTO Planotreino VALUES ('T0003', '89012345', TO_DATE('05/09/2024', 'DD/MM/YYYY'), '88888888');

INSERT INTO Nutricionista VALUES ('CRN0001', 'Patrícia Andrade');
INSERT INTO Nutricionista VALUES ('CRN0002', 'Rodrigo Nascimento');
INSERT INTO Nutricionista VALUES ('CRN0003', 'Fernanda Lopes');
INSERT INTO Nutricionista VALUES ('CRN0004', 'Marcelo Ribeiro');
INSERT INTO Nutricionista VALUES ('CRN0005', 'Tatiane Costa');
INSERT INTO Nutricionista VALUES ('CRN0006', 'Cláudio Silva');
INSERT INTO Nutricionista VALUES ('CRN0007', 'Amanda Martins');
INSERT INTO Nutricionista VALUES ('CRN0008', 'Daniel Souza');

INSERT INTO Dieta VALUES ('D001', 'CRN0001', '12345678');
INSERT INTO Dieta VALUES ('D002', 'CRN0002', '23456789');
INSERT INTO Dieta VALUES ('D003', 'CRN0003', '34567890');
INSERT INTO Dieta VALUES ('D004', 'CRN0004', '45678901');
INSERT INTO Dieta VALUES ('D005', 'CRN0005', '56789012');
INSERT INTO Dieta VALUES ('D006', 'CRN0006', '67890123');
INSERT INTO Dieta VALUES ('D007', 'CRN0007', '78901234');
INSERT INTO Dieta VALUES ('D008', 'CRN0008', '89012345');

