import 'package:e_commerce/blocs/cart_bloc.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends InheritedWidget {
  final CartBloc bloc;

  CartProvider({
    Key key,
    CartBloc bloc,
    Widget child,
  })  : bloc = bloc ?? CartBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static CartBloc of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartProvider>().bloc;
}
