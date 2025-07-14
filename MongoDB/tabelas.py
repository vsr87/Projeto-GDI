from pymongo import MongoClient

# Conexão com o MongoDB local
client = MongoClient("mongodb://localhost:27017/")
db = client["academiaDB"]

for collection in db.list_collection_names():
    db[collection].delete_many({})

# Inserir academias
db.academias.insert_many( [
    {
        "_id": "1111",
        "endereco": {
            "cep": "12345678",
            "descricao": "Rua das Flores, 123"
        },
        "data_abertura": "2023-05-10"
    },

    {
        "_id": "2222",
        "endereco": {
            "cep": "12345777",
            "descricao": "Rua da Alegria, 23"
        },
        "data_abertura": "2021-05-10"
    },

    {
        "_id": "3333",
        "endereco": {
            "cep": "12345888",
            "descricao": "Rua Capaz, 21"
        },
        "data_abertura": "2021-09-12"
    },

    {
        "_id": "4444",
        "endereco": {
            "cep": "12345999",
            "descricao": "Rua Cesar, 10"
        },
        "data_abertura": "2024-01-20"
    }
])

# Inserir gratificações
db.gratificacoes.insert_many([
    {"_id": "G001", "descricao": "Bônus produtividade"},
    {"_id": "G002", "descricao": "Assiduidade"}
])

# Inserir funcionários (com tipo)
db.funcionarios.insert_many([
    {
        "_id": "11111111",
        "nome": "João Silva",
        "salario": "3500",
        "chefe": None,
        "academia_id": "A001",
        "gratificacao_id": "G001",
        "tipo": "balconista",
        "turno": "Tarde"
    },
    {
        "_id": "22222222",
        "nome": "Maria Lima",
        "salario": "4000",
        "chefe": "11111111",
        "academia_id": "A002",
        "gratificacao_id": "G002",
        "tipo": "personal",
        "cref": "CREF1234"
    },
    {
        "_id": "33333333",
        "nome": "Carlos Souza",
        "salario": "2800",
        "chefe": "11111111",
        "academia_id": "A002",
        "gratificacao_id": None,
        "tipo": "auxiliar",
        "area_responsavel": "Limpeza"
    }
])

# Inserir treinos com exercícios embutidos
db.treinos.insert_one(
    {
    "_id": "T001",
    "exercicios": [
        {"nome": "Supino", "series": 3, "repeticoes": 12},
        {"nome": "Agachamento", "series": 4, "repeticoes": 10} ]
    },

    {
    "_id": "T002",
    "exercicios": [
        {"nome": "Puxada", "series": 5, "repeticoes": 8},
        {"nome": "Triceps", "series": 5, "repeticoes": 6} ]
    }
)

db.planos.insert_many([
    {
        "id_academia": "1111",
        "planos": [
            {"num": 1, "preco": 1199.98},
            {"num": 2, "preco": 899.94},
            {"num": 3, "preco": 179.99},
            {"num": 4, "preco": 1439.88},
            {"num": 5, "preco": 79.99}
        ]
    },
    {
        "id_academia": "2222",
        "planos": [
            {"num": 1, "preco": 1199.98},
            {"num": 2, "preco": 899.94},
            {"num": 3, "preco": 179.99},
            {"num": 4, "preco": 1439.88},
            {"num": 5, "preco": 79.99}
        ]
    },
    {
        "id_academia": "3333",
        "planos": [
            {"num": 1, "preco": 1199.98},
            {"num": 2, "preco": 899.94},
            {"num": 3, "preco": 179.99},
            {"num": 4, "preco": 1439.88},
            {"num": 5, "preco": 79.99}
        ]
    }
])

# Inserção dos benefícios
db.beneficios.insert_many([
    {"id_academia": "1111", "num": 1, "descricao": "Plano anual com horário livre"},
    {"id_academia": "1111", "num": 2, "descricao": "Plano semestral com horário livre"},
    {"id_academia": "1111", "num": 3, "descricao": "Plano mensal horário livre"},
    {"id_academia": "1111", "num": 4, "descricao": "Plano anual com toda as atividades inclusas com acesso a todas as academias"},
    {"id_academia": "1111", "num": 5, "descricao": "Plano mensal horário restrito"},

    {"id_academia": "2222", "num": 1, "descricao": "Plano anual com toda as atividades inclusas"},
    {"id_academia": "2222", "num": 2, "descricao": "Plano semestral com toda as atividades inclusas"},
    {"id_academia": "2222", "num": 3, "descricao": "Plano mensal com toda as atividades inclusas"},
    {"id_academia": "2222", "num": 4, "descricao": "Plano anual com toda as atividades inclusas com acesso a todas as academias"},
    {"id_academia": "2222", "num": 5, "descricao": "Plano mensal horário restrito"}
])

# Coleção de equipamentos
db.equipamentos.insert_many([
    {"_id": "EQM0001", "descricao": "Supino Reto"},
    {"_id": "EQM0002", "descricao": "Supino declinado"},
    {"_id": "EQM0003", "descricao": "Pec Deck"},
    {"_id": "EQM0004", "descricao": "Banco para supino"},
    {"_id": "EQM0005", "descricao": "Crossover"}
])

# Relacionamento com academias (coleção tem)
db.tem.insert_many([
    {"cod_eqm": "EQM0001", "id_academia": "1111"},
    {"cod_eqm": "EQM0002", "id_academia": "2222"},
    {"cod_eqm": "EQM0003", "id_academia": "1111"},
    {"cod_eqm": "EQM0004", "id_academia": "2222"},
    {"cod_eqm": "EQM0005", "id_academia": "1111"}
])

# Conjunto de alunos
db.alunos.insert_many([
    {"_id": "12345678", "nome": "Lucas Almeida", "data_nasc": "1995-04-15", "id_academia": "1111"},
    {"_id": "23456789", "nome": "Mariana Costa", "data_nasc": "1998-08-22", "id_academia": "2222"},
    {"_id": "34567890", "nome": "Fernando Lima", "data_nasc": "1990-12-03", "id_academia": "3333"},
    {"_id": "45678901", "nome": "Juliana Castro", "data_nasc": "2000-06-07", "id_academia": "4444"},
    {"_id": "56789012", "nome": "Rafael Oliveira", "data_nasc": "1988-09-29", "id_academia": "1111"},
    {"_id": "67890123", "nome": "Camila Ferreira", "data_nasc": "1993-02-19", "id_academia": "2222"},
    {"_id": "78901234", "nome": "Gustavo Oliveira", "data_nasc": "1997-07-11", "id_academia": "3333"},
    {"_id": "89012345", "nome": "Larissa Santos", "data_nasc": "1994-05-04", "id_academia": "4444"}
])

# Conjunto de contatos
db.contatos.insert_many([
    {"cpf_aluno": "12345678", "telefone": "99991111"},
    {"cpf_aluno": "12345678", "telefone": "98882222"},
    {"cpf_aluno": "23456789", "telefone": "97773333"},
    {"cpf_aluno": "34567890", "telefone": "96664444"},
    {"cpf_aluno": "45678901", "telefone": "95555555"},
    {"cpf_aluno": "56789012", "telefone": "94446666"},
    {"cpf_aluno": "67890123", "telefone": "93337777"},
    {"cpf_aluno": "78901234", "telefone": "92228888"},
    {"cpf_aluno": "89012345", "telefone": "91119999"},
    {"cpf_aluno": "89012345", "telefone": "90001234"}
])

# Conjunto de planos+treino
db.planos_treino.insert_many([
    {"id_treino": "T0001", "cpf_aluno": "12345678", "data_inicio": "2024-02-01", "cpf_func": "11111111"},
    {"id_treino": "T0002", "cpf_aluno": "23456789", "data_inicio": "2024-03-05", "cpf_func": "22222222"},
    {"id_treino": "T0003", "cpf_aluno": "34567890", "data_inicio": "2024-04-10", "cpf_func": "33333333"},
    {"id_treino": "T0004", "cpf_aluno": "45678901", "data_inicio": "2024-05-15", "cpf_func": "33333333"},
    {"id_treino": "T0005", "cpf_aluno": "56789012", "data_inicio": "2024-06-20", "cpf_func": "33333333"},
    {"id_treino": "T0001", "cpf_aluno": "67890123", "data_inicio": "2024-07-25", "cpf_func": "33333333"},
    {"id_treino": "T0002", "cpf_aluno": "78901234", "data_inicio": "2024-08-30", "cpf_func": "22222222"},
    {"id_treino": "T0003", "cpf_aluno": "89012345", "data_inicio": "2024-09-05", "cpf_func": "11111111"}
])

# Conjunto de nutricionistas
db.nutricionistas.insert_many([
    {"_id": "CRN0001", "nome": "Patrícia Andrade"},
    {"_id": "CRN0002", "nome": "Rodrigo Nascimento"},
    {"_id": "CRN0003", "nome": "Fernanda Lopes"},
    {"_id": "CRN0004", "nome": "Marcelo Ribeiro"},
    {"_id": "CRN0005", "nome": "Tatiane Costa"},
    {"_id": "CRN0006", "nome": "Cláudio Silva"},
    {"_id": "CRN0007", "nome": "Amanda Martins"},
    {"_id": "CRN0008", "nome": "Daniel Souza"}
])

# Conjunto de dietas
db.dietas.insert_many([
    {"_id": "D001", "crn": "CRN0001", "cpf_aluno": "12345678"},
    {"_id": "D002", "crn": "CRN0002", "cpf_aluno": "23456789"},
    {"_id": "D003", "crn": "CRN0003", "cpf_aluno": "34567890"},
    {"_id": "D004", "crn": "CRN0004", "cpf_aluno": "45678901"},
    {"_id": "D005", "crn": "CRN0005", "cpf_aluno": "56789012"},
    {"_id": "D006", "crn": "CRN0006", "cpf_aluno": "67890123"},
    {"_id": "D007", "crn": "CRN0007", "cpf_aluno": "78901234"},
    {"_id": "D008", "crn": "CRN0008", "cpf_aluno": "89012345"}
])
