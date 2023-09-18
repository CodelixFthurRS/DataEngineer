"""membuat DAG yang memiliki operasi Dummy, operasi BranchPython, dan operasi Dummy yang bergantung satu sama lain. 
aya juga menambahkan argumen schedule_interval dan catchup dalam definisi DAG untuk menunjukkan cara Anda dapat mengatur 
interval eksekusi dan menghindari eksekusi tertinggal (catch-up execution) jika diperlukan."""

from airflow import DAG
from airflow.operators.python_operator import BranchPythonOperator
from airflow.operators.dummy_operator import DummyOperator
from datetime import datetime

# Fungsi ini akan menentukan jalur yang harus diambil dalam DAG berdasarkan akurasi model
def choose_best_model():
    accuracy = 6
    if accuracy > 5:
        return "accurate"
    else:
        return "inaccurate"

# Pengaturan default untuk DAG
default_args = {
    "owner": "fathur",
    "email": "fathur.rosy.tpm2@gmail.com",
    "start_date": datetime(2021, 10, 26)
}

# Membuat DAG
dag = DAG(
    dag_id="etl_workflow_almer",
    default_args=default_args,
    schedule_interval=None,  # Atur interval eksekusi di sini
    catchup=False  # Jika Anda ingin menghindari catch-up eksekusi
)

# Operasi Dummy untuk titik awal DAG
start = DummyOperator(
    task_id="start",
    dag=dag
)

# Operasi BranchPython yang akan memutuskan jalur yang harus diambil dalam DAG
choose_best_model_task = BranchPythonOperator(
    task_id="choose_best_model_task",
    python_callable=choose_best_model,
    provide_context=False,
    dag=dag
)

# Operasi Dummy untuk jalur "accurate"
accurate = DummyOperator(
    task_id="accurate",
    dag=dag
)

# Operasi Dummy untuk jalur "inaccurate"
inaccurate = DummyOperator(
    task_id="inaccurate",
    dag=dag
)

# Mendefinisikan ketergantungan antara tugas-tugas dalam DAG
start >> choose_best_model_task
choose_best_model_task >> [accurate, inaccurate]

