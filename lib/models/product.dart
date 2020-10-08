class Product {
  String _id;
  String _title;
  String _description;
  String _imgUrl;
  int _price;

  Product(this._title, this._description, this._imgUrl, this._price,
      {String id}) {
    _id = id;
  }

  Product.fromJson(Map<String, dynamic> map)
      : _id = map['id'],
        _title = map['title'],
        _description = map['description'],
        _imgUrl = map['imgUrl'],
        _price = map['price'];

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'title': _title,
      'description': _description,
      'imgUrl': _imgUrl,
      'price': _price,
    };
  }

  @override
  String toString() {
    return 'Product{_id: $_id, _title: $_title, _description: $_description, _imgUrl: $_imgUrl, _price: $_price}';
  }

  String get id => _id;

  String get title => _title;

  String get description => _description;

  String get imgUrl => _imgUrl;

  int get price => _price;
}
