import 'dart:async';

import 'package:e_commerce/models/cart_item.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  List<CartItem> _cart = List();

  final BehaviorSubject<List<CartItem>> _items =
      BehaviorSubject<List<CartItem>>();

  final BehaviorSubject<double> _subtotal = BehaviorSubject<double>();

  final StreamController<CartItem> _addItemController =
      StreamController<CartItem>();

  final StreamController<List<CartItem>> _cartController =
      StreamController<List<CartItem>>();

  final StreamController<CartItem> _updateItemController =
      StreamController<CartItem>();

  CartBloc() {
    _addItemController.stream.listen((event) {});
    _cartController.stream.listen((event) {
      _cart = event;
      _items.add(_cart);
      _subtotal.add(_calculateSubtotal());
    });
    _updateItemController.stream.listen((event) {
      _cart.remove(event);
      _cart.add(event);
      _subtotal.add(_calculateSubtotal());
    });
  }

  Sink<CartItem> get addItem => _addItemController.sink;

  Sink<List<CartItem>> get cart => _cartController.sink;

  Sink<CartItem> get updateItem => _updateItemController.sink;

  Stream<double> get subtotal => _subtotal.stream;

  Stream<List<CartItem>> get items => _items.stream;

  void dispose() {
    _items.close();
    _subtotal.close();
    _addItemController.close();
    _cartController.close();
    _updateItemController.close();
  }

  double _calculateSubtotal() {
    return _cart.fold(
            0, (previousValue, element) => previousValue + element.total) /
        100;
  }
}
