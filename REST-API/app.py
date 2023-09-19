from flask import Flask, request, jsonify
import psycopg2

app = Flask(__name__)

# Konfigurasi database PostgreSQL
db_connection = psycopg2.connect(
    host="localhost",
    database="nama_database",
    user="nama_pengguna",
    password="password"
)

@app.route('/api/mahasiswa', methods=['GET'])
def get_mahasiswa():
    try:
        cursor = db_connection.cursor()
        cursor.execute("SELECT * FROM mahasiswa")
        mahasiswa = cursor.fetchall()
        cursor.close()
        return jsonify(mahasiswa), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/mahasiswa', methods=['POST'])
def create_mahasiswa():
    data = request.get_json()
    if 'nama' not in data or 'nim' not in data:
        return jsonify({'error': 'Nama dan NIM mahasiswa harus disediakan'}), 400

    try:
        cursor = db_connection.cursor()
        cursor.execute("INSERT INTO mahasiswa (nama, nim) VALUES (%s, %s)", (data['nama'], data['nim']))
        db_connection.commit()
        cursor.close()
        return jsonify({'message': 'Mahasiswa berhasil ditambahkan'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
