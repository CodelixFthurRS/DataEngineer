from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "postgresql+psycopg2://postgres:admin@localhost:5432/postgres"
db = SQLAlchemy(app)
ma = Marshmallow(app)

# Definisikan model

class User(db.Model):
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    email = db.Column(db.String(30), nullable=False)
    address = db.Column(db.String(50))

    def __init__(self, username, email, address):
        self.username = username
        self.email = email
        self.address = address

class Product(db.Model):
    __tablename__ = "product"
    id = db.Column(db.Integer, primary_key=True)
    product_name = db.Column(db.String(50), unique=True, nullable=False)
    product_price = db.Column(db.Numeric(19, 2), nullable=False)
    product_qty = db.Column(db.Integer, nullable=False)

    def __init__(self, product_name, product_price, product_qty):
        self.product_name = product_name
        self.product_price = product_price
        self.product_qty = product_qty

class Order(db.Model):
    __tablename__ = "order"
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey('product.id'), nullable=False)

    def __init__(self, user_id, product_id):
        self.user_id = user_id
        self.product_id = product_id

# Marshmallow Schemas

class UserSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = User

user_schema = UserSchema()
users_schema = UserSchema(many=True)

class ProductSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Product

product_schema = ProductSchema()
products_schema = ProductSchema(many=True)

class OrderSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Order

order_schema = OrderSchema()
orders_schema = OrderSchema(many=True)

# Blueprint

from flask import Blueprint

api_bp = Blueprint('api', __name__)

@api_bp.route("/users", methods=["GET"])
def get_users():
    users = User.query.all()
    return users_schema.jsonify(users)

@api_bp.route("/users", methods=["POST"])
def add_user():
    data = request.get_json()
    if "username" not in data or "email" not in data or "address" not in data:
        return jsonify({"message": "Semua kolom harus diisi: username, email, dan address"}), 400

    new_user = User(username=data["username"], email=data["email"], address=data["address"])
    db.session.add(new_user)
    db.session.commit()
    return jsonify({"message": "Data berhasil ditambahkan!"}), 201

# Tambahkan rute lainnya seperti produk dan pesanan menggunakan pendekatan yang serupa

app.register_blueprint(api_bp, url_prefix="/api")

if __name__ == "__main__":
    db.create_all()
    app.run(debug=True)
