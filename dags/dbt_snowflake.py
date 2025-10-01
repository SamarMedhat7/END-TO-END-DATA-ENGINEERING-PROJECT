from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

# Define default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 6, 25),  # Change as needed
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    dag_id="snowflake_dbt_pipeline",
    default_args=default_args,
    schedule="@daily",   # <-- new param
    catchup=False,
)
# Define the path to your dbt project
DBT_PROJECT_DIR = "/usr/local/airflow/dags/dbt/snowflake_dbt/"  # Update this path

# Task 1: Run dbt models
dbt_run = BashOperator(
    task_id='dbt_run',
    bash_command=f'cd {DBT_PROJECT_DIR} && dbt run  ',
    dag=dag,
)


# Task 2: Run dbt tests after models are built
dbt_test = BashOperator(
    task_id='dbt_test',
    bash_command=f'cd {DBT_PROJECT_DIR} && dbt test',
    dag=dag,
)

# Define task dependencies
dbt_run >> dbt_test  # dbt_run must finish before dbt_test starts