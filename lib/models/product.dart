class Product {
  String _id;
  String _title;
  String _description;
  String _imgUrl;
  int _price;
  DateTime _createdAt;

  Product(this._title, this._description, this._imgUrl, this._price,
      {DateTime createdAt, String id}) {
    _id = id;
    _createdAt = createdAt;
  }

  Product.fromJson(Map<String, dynamic> map)
      : _id = map['id'],
        _title = map['title'],
        _description = map['description'],
        _imgUrl = map['imgUrl'],
        _price = map['price'],
        _createdAt = map['createdAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'title': _title,
      'description': _description,
      'imgUrl': _imgUrl,
      'price': _price,
      'createdAt': _createdAt,
    };
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && _id == other._id;

  @override
  int get hashCode => _id.hashCode;

  @override
  String toString() {
    return 'Product{_id: $_id, _title: $_title, _description: $_description, _imgUrl: $_imgUrl, _price: $_price, _createdAt: $_createdAt}';
  }

  String get id => _id;

  String get title => _title;

  String get description => _description;

  String get imgUrl => _imgUrl;

  int get price => _price;
}
