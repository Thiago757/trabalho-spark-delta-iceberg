# Apache Spark com Delta Lake e Apache Iceberg

> Trabalho acadêmico — Disciplina: Engenharia de Dados  
> Curso: Engenharia de Software — 5ª Fase — SATC  
> Professor: Jorge Luiz da Silva

---

## Sobre o Projeto

Este projeto demonstra um ambiente local com **Apache Spark (PySpark)** processando dados com dois formatos modernos de tabela para Data Lakes:

- **Delta Lake** — criado pela Databricks, com Transaction Log, ACID e Time Travel por versão
- **Apache Iceberg** — criado pela Netflix, com snapshots, hidden partitioning e forte interoperabilidade

**Cenário:** sistema fictício de gestão de vendas da **TechStore**, com tabelas de clientes, produtos e pedidos.

```
Dados (TechStore) → Apache Spark (PySpark) → Delta Lake  → INSERT / UPDATE / DELETE / Time Travel
                                           → Apache Iceberg → INSERT / UPDATE / DELETE / Snapshots
```

---

## Pré-requisitos

| Ferramenta | Versão |
|---|---|
| Ubuntu (WSL 2) | recomendado |
| Python | 3.12+ |
| Java | 17 (OpenJDK) |
| uv | latest |

### Instalar Java 17

```bash
sudo apt update && sudo apt install -y openjdk-17-jdk
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
```

### Instalar uv

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc
```

---

## Instalação

```bash
# Clonar o repositório
git clone https://github.com/SEU_USUARIO/SEU_REPO.git
cd SEU_REPO

# Instalar dependências
uv sync
```

---

## Como Executar

### Notebooks (demonstração principal)

```bash
uv run jupyter lab notebooks/
```

Acesse `http://localhost:8888` e abra:

- `notebooks/spark-delta-lake.ipynb` — demonstração com Delta Lake
- `notebooks/spark-iceberg.ipynb` — demonstração com Apache Iceberg

> A primeira célula de cada notebook pode demorar — o Spark baixa os conectores Delta/Iceberg via Maven.

### Documentação local

```bash
uv run mkdocs serve
```

Acesse `http://localhost:8000`

---

## Estrutura do Projeto

```
.
├── docs/                    # Páginas da documentação MkDocs
│   ├── index.md             # Contextualização
│   ├── spark.md             # Apache Spark (PySpark)
│   ├── delta.md             # Delta Lake
│   └── iceberg.md           # Apache Iceberg
├── notebooks/
│   ├── spark-delta-lake.ipynb
│   └── spark-iceberg.ipynb
├── mkdocs.yml
├── pyproject.toml
└── README.md
```

---

## Documentação Online

Disponível em: **https://SEU_USUARIO.github.io/SEU_REPO/**

---

## Referências

- [Apache Spark](https://spark.apache.org/)
- [Delta Lake](https://delta.io/)
- [Apache Iceberg](https://iceberg.apache.org/)
- [Repositório referência — spark-delta (Prof. Jorge Silva)](https://github.com/jlsilva01/spark-delta)
- [Repositório referência — spark-iceberg (Prof. Jorge Silva)](https://github.com/jlsilva01/spark-iceberg)
