from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime
from airflow.providers.postgres.operators.postgres import PostgresOperator

DEPARTMENTS = [
    "Business Department",
    "Customer Management Department",
    "Enterprise Department",
    "Marketing Department",
    "Operations Department"
]

INGEST_SCRIPT = "/opt/airflow/python-ingestion/ingest.py"
TRANSFORM_SCRIPT = "/opt/airflow/r-transformation/cleaning.r"
DATA_ROOT = "/opt/airflow/data"

with DAG(
    dag_id="etl_pipeline_shopzada",
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False,
    template_searchpath=["/opt/airflow/sql"]
):

    ingestion_tasks = []

    for dept in DEPARTMENTS:

        ingest = BashOperator(
            task_id=f"ingest_{dept.replace(' ', '_').lower()}",
            bash_command=f"""
                python {INGEST_SCRIPT} \
                --user airflow \
                --password airflow \
                --host postgres \
                --port 5432 \
                --db airflow \
                --data_dir "{DATA_ROOT}/{dept}"
            """
        )

        ingestion_tasks.append(ingest)


    r_cleaning = BashOperator(
        task_id="cleaning_r",
        bash_command=f"Rscript {TRANSFORM_SCRIPT}"
    
    )

    merge_data_sql = PostgresOperator(
        task_id="merge_tables",
        postgres_conn_id="airflow_postgres",
        sql="merge.sql"
    )

    create_dims_sql = PostgresOperator(
        task_id="create_dims",
        postgres_conn_id="airflow_postgres",
        sql="create_dims.sql"
    )

    create_fact_sql = PostgresOperator(
        task_id="create_fact",
        postgres_conn_id="airflow_postgres",
        sql="create_fact.sql"
    )



    ingestion_tasks>>r_cleaning>>merge_data_sql>>create_dims_sql>>create_fact_sql
