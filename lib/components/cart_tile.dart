import 'package:e_commerce/blocs/cart_bloc.dart';
import 'package:e_commerce/blocs/cart_provider.dart';
import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/models/custom_user.dart';
import 'package:e_commerce/services/cart.dart';
import 'package:e_commerce/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatefulWidget {
  final CartItem product;
  final String userId;
  final GlobalKey<ScaffoldState> globalKey;
  final Function removeItem;

  CartTile(this.product, this.userId, this.globalKey, this.removeItem);

  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final CartService _cartService = CartService();
  final _height = 100.0;
  String _imgUrl;
  CartItem _product;

  @override
  void initState() {
    _product = widget.product;
    _imgUrl = _product.imgUrl ?? NO_IMAGE_URL;
    super.initState();
  }

  void _onSelectedPopupMenuOption(CartOption selectedOption) {
    switch (selectedOption) {
      case CartOption.REMOVE:
        // TODO: remove item from cart list
        widget.removeItem(_product, widget.userId);
        break;
      case CartOption.ADD_FAVORITE:
        // TODO: add item to favorite list
        print('Adding to favorite list...');
        break;
      default:
        throw Exception('Unexpected argument');
    }
  }

  void _incrementAmount(BuildContext context, CartBloc cartBloc) {
    if (_product.amount == 10) return;
    setState(() {
      _product.amount++;
      _product.total =
          _product.amount * _product.price;
    });
    var userId = Provider.of<CustomUser>(context, listen: false).id;
    _cartService.setAmount(_product.id, userId, _product.amount).then((value) {
      if(value){
        // TODO: update subtotal and total values on cart tab
        cartBloc.updateItem.add(_product);
      }else{
        setState(() {
          _product.amount--;
          _product.total =
              _product.amount * _product.price;
        });
      }
    });
  }

  void _decrementAmount(BuildContext context, CartBloc cartBloc){
    if (_product.amount == 1) return;
    setState(() {
      _product.amount--;
      _product.total =
          _product.amount * _product.price;
    });
    var userId = Provider.of<CustomUser>(context, listen: false).id;
    _cartService.setAmount(_product.id, userId, _product.amount).then((value) {
      if(value){
        // TODO: update subtotal and total values on cart tab
        cartBloc.updateItem.add(_product);
      }else{
        setState(() {
          _product.amount++;
          _product.total =
              _product.amount * _product.price;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartBloc = CartProvider.of(context);
    return Card(
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Image.network(
              _imgUrl,
              fit: BoxFit.cover,
              height: _height,
              width: double.maxFinite,
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              height: _height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 16.0,
                    left: 16.0,
                    child: Text(
                      _product.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[800],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: PopupMenuButton<CartOption>(
                      onSelected: _onSelectedPopupMenuOption,
                      itemBuilder: (_) => <PopupMenuItem<CartOption>>[
                        PopupMenuItem<CartOption>(
                          value: CartOption.REMOVE,
                          child: Text('Remove'),
                        ),
                        PopupMenuItem<CartOption>(
                          value: CartOption.ADD_FAVORITE,
                          child: Text('Add to favorite'),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 6.0,
                      left: 6.0,
                      // width: 100.0,
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.remove, color: Colors.red),
                            ),
                            onTap: (){
                              _decrementAmount(context, cartBloc);
                            },
                          ),
                          Text(
                            '${_product.amount}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.add, color: Colors.blue),
                            ),
                            onTap: (){
                              _incrementAmount(context, cartBloc);
                            },
                          ),
                        ],
                      )),
                  Positioned(
                    bottom: 16.0,
                    right: 22.0,
                    child: Text(
                      '\$ ${(_product.total / 100).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
