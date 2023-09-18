from airflow.models import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
from airflow.operators.dummy_operator import DummyOperator
from datetime import datetime
import requests
import json

# Menentukan argumen default untuk DAG
default_arguments = {
    "owner": "fathur",
    "email": "fathur.rosy.tpm2@gmail.com",
    "start_date": datetime(2021, 10, 25)
}

# Inisialisasi DAG
dag = DAG(
    dag_id="etl_workflow_almer",
    default_args=default_arguments
)

# Membuat operator Dummy untuk tugas awal
start = DummyOperator(
    task_id="start",
    dag=dag
)

# Mendefinisikan fungsi untuk mengambil data dari URL dan menyimpannya dalam file JSON
def retrieve_data(url, filename):
    response = requests.get(url)
    todos = response.json()
    data = []
    for i in todos:
        data.append(i)
    with open(filename, "w") as file:
        file.write(json.dumps(data))

# Membuat operator Python untuk tugas retrieve_data
retrieve_todo_task = PythonOperator(
    task_id="retrieve_todo_list",
    python_callable=retrieve_data,
    op_kwargs={"url": "https://jsonplaceholder.typicode.com/posts", "filename": "posts_list.json"},
    dag=dag
)

# Membuat operator Bash untuk mencetak pesan status
status_task = BashOperator(
    task_id="print_status",
    bash_command="echo 'Data sudah ditarik dan berhasil disimpan pada file'",
    dag=dag
)

# Menentukan ketergantungan antara operator-operator
start >> retrieve_todo_task >> status_task

