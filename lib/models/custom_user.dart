import 'package:stripe_payment/stripe_payment.dart';

class CustomUser {
  String _id;
  String _name;
  String _email;
  List<String> _cartList;
  List<String> _favoriteList;
  List<PaymentMethod> _paymentMethods;

  CustomUser(
    this._id,
    this._name,
    this._email,
    this._cartList,
    this._favoriteList,
    this._paymentMethods,
  );

  CustomUser.fromJson(Map<String, dynamic> map)
      : _id = map['id'],
        _name = map['name'],
        _email = map['email'],
        _cartList = List<String>.from(map['cartList']),
        _favoriteList = List<String>.from(map['favoriteList']),
        _paymentMethods = List<PaymentMethod>.from(map['paymentMethods']);

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'email': _email,
      'cartList': _cartList,
      'favoriteList': _favoriteList,
      'paymentMethods': _paymentMethods,
    };
  }

  @override
  String toString() {
    return 'CustomUser{_id: $_id, _name: $_name, _email: $_email, _cartList: $_cartList, _favoriteList: $_favoriteList, _paymentMethods: $_paymentMethods}';
  }

  String get id => _id;

  set name(String name) {
    _name = name;
  }
}
