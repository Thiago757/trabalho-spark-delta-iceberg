"""Ponto de entrada principal — demonstração básica de Spark + Iceberg."""

from pyspark.sql import SparkSession


def criar_spark_session(nome_app: str = "Spark-Iceberg-DataLake") -> SparkSession:
    """Cria e retorna uma SparkSession configurada com suporte a Iceberg."""
    spark = (
        SparkSession.builder.master("local[*]").appName(nome_app)
        .config(
            "spark.jars.packages",
            "org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.6.1",
        )
        .config(
            "spark.sql.extensions",
            "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions",
        )
        .config("spark.sql.catalog.local", "org.apache.iceberg.spark.SparkCatalog")
        .config("spark.sql.catalog.local.type", "hadoop")
        .config("spark.sql.catalog.local.warehouse", "spark-warehouse/iceberg")
        .getOrCreate()
    )
    spark.sparkContext.setLogLevel("WARN")
    return spark


def exemplo_basico(spark: SparkSession) -> None:
    """Cria um DataFrame simples e exibe o resultado."""
    dados = [
        ("Alice", 30, "Engenharia"),
        ("Bob", 25, "Ciência de Dados"),
        ("Carlos", 28, "Engenharia"),
    ]
    colunas = ["nome", "idade", "area"]

    df = spark.createDataFrame(dados, colunas)
    print("\n--- DataFrame de exemplo ---")
    df.show()
    print(f"Total de registros: {df.count()}")


def main() -> None:
    spark = criar_spark_session()
    try:
        exemplo_basico(spark)
    finally:
        spark.stop()


if __name__ == "__main__":
    main()
