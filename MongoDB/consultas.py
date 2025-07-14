from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client["academiaDB"]

print("1. Academias com mais de 14 equipamentos:")
resultado1 = db.tem.aggregate([
    {
        "$group": {
            "_id": "$id_academia",
            "qtd_Equipamentos": { "$sum": 1 }
        }
    },
    {
        "$match": {
            "qtd_Equipamentos": { "$gt": 14 }
        }
    },
    {
        "$project": {
            "_id": 0,
            "id_academia": "$_id",
            "qtd_Equipamentos": 1
        }
    }
])
for doc in resultado1:
    print(doc)

print("\n2. Planos com endereço da academia (INNER JOIN):")
resultado2 = db.planos.aggregate([
    {
        "$lookup": {
            "from": "academias",
            "localField": "id_academia",
            "foreignField": "_id",
            "as": "academia"
        }
    },
    { "$unwind": "$academia" },
    {
        "$project": {
            "_id": 0,
            "id_academia": 1,
            "endereco": "$academia.endereco.descricao",
            "planos": 1
        }
    }
])
for doc in resultado2:
    print(doc)

print("\n3. Academias sem funcionários (RIGHT OUTER JOIN):")
resultado3 = db.academias.aggregate([
    {
        "$lookup": {
            "from": "funcionarios",
            "localField": "_id",
            "foreignField": "id_academia",
            "as": "funcionarios"
        }
    },
    {
        "$match": { "funcionarios": { "$eq": [] } }
    },
    {
        "$project": {
            "_id": 0,
            "endereco_cep": "$endereco.cep"
        }
    }
])
for doc in resultado3:
    print(doc)

print("\n4. Academias com alunos (SEMI-JOIN):")
resultado4 = db.academias.aggregate([
    {
        "$lookup": {
            "from": "alunos",
            "localField": "_id",
            "foreignField": "id_academia",
            "as": "alunos"
        }
    },
    {
        "$match": { "alunos.0": { "$exists": True } }
    },
    {
        "$project": {
            "_id": 0,
            "endereco_cep": "$endereco.cep"
        }
    }
])
for doc in resultado4:
    print(doc)

print("\n5. Academias sem alunos (ANTI-JOIN):")
resultado5 = db.academias.aggregate([
    {
        "$lookup": {
            "from": "alunos",
            "localField": "_id",
            "foreignField": "id_academia",
            "as": "alunos"
        }
    },
    {
        "$match": { "alunos": { "$eq": [] } }
    },
    {
        "$project": {
            "_id": 0,
            "endereco_cep": "$endereco.cep"
        }
    }
])
for doc in resultado5:
    print(doc)

print("\n6. Funcionário com maior salário:")
max_salario = db.funcionarios.aggregate([
    { "$group": { "_id": None, "max": { "$max": "$salario" } } }
])
max_salario = list(max_salario)[0]["max"]
resultado6 = db.funcionarios.find(
    { "salario": max_salario },
    { "_id": 0, "nome": 1 }
)
for doc in resultado6:
    print(doc)

print("\n7. Funcionário que trabalha na mesma academia e recebe o mesmo que CPF 11111111:")
f = db.funcionarios.find_one({ "_id": "11111111" })
resultado7 = db.funcionarios.find(
    {
        "id_academia": f["id_academia"],
        "salario": f["salario"]
    },
    { "_id": 0, "nome": 1 }
)
for doc in resultado7:
    print(doc)

print("\n8. Funcionários que ganham acima da média:")
media = db.funcionarios.aggregate([
    { "$group": { "_id": None, "media": { "$avg": "$salario" } } }
])
media = list(media)[0]["media"]
resultado8 = db.funcionarios.find(
    { "salario": { "$gt": media } },
    { "_id": 0, "nome": 1, "salario": 1 }
)
for doc in resultado8:
    print(doc)

print("\n9. Funcionários que também são alunos (INTERSECT):")
nomes_alunos = db.alunos.distinct("nome")
resultado9 = db.funcionarios.find(
    { "nome": { "$in": nomes_alunos } },
    { "_id": 0, "nome": 1 }
)
for doc in resultado9:
    print(doc)
