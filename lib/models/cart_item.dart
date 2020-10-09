import 'package:e_commerce/models/product.dart';

class CartItem extends Product {
  int _amount;
  int _total;
  DateTime _addedAt;

  CartItem(
    this._amount,
    this._total,
    this._addedAt,
    String id,
    String title,
    String description,
    String imgUrl,
    int price,
  ) : super(title, description, imgUrl, price, id: id);

  CartItem.fromJson(Map<String, dynamic> map)
      : _amount = map['amount'],
        _total = map['total'],
        _addedAt = map['addedAt'],
        super(
          map['title'],
          map['description'],
          map['imgUrl'],
          map['price'],
          id: map['id'],
        ) {
    this.total = this.amount * this.price;
  }

  Map<String, dynamic> toJson() {
    return {
      'addedAt':_addedAt,
      'amount': _amount,
      'description': this.description,
      'id' : this.id,
      'imgUrl': this.imgUrl,
      'price': this.price,
      'title': this.title,
      'total': _total,
    };
  }


  @override
  String toString() {
    return super.toString() + 'CartItem{_amount: $_amount, _total: $_total, _addedAt: $_addedAt}';
  }

  int get total => _total;

  set total(int value) {
    _total = value;
  }

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
  }
}
