"""Testes do módulo principal."""

import pytest


def test_importacao_pacote():
    """Verifica que o pacote é importado corretamente."""
    import trabalho_spark_iceberg

    assert trabalho_spark_iceberg.__version__ == "0.1.0"


def test_importacao_main():
    """Verifica que o módulo main é importado sem erros."""
    from trabalho_spark_iceberg import main

    assert callable(main.criar_spark_session)
    assert callable(main.exemplo_basico)
    assert callable(main.main)


@pytest.mark.skip(reason="Requer Java e jars do Spark — executar manualmente no ambiente local")
def test_spark_session():
    """Verifica criação da SparkSession (requer Java)."""
    from trabalho_spark_iceberg.main import criar_spark_session

    spark = criar_spark_session("test-app")
    assert spark is not None
    spark.stop()
