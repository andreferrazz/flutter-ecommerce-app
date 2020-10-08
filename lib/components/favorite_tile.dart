import 'dart:ui';

import 'package:e_commerce/screens/details/product_details.dart';
import 'package:e_commerce/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteTile extends StatefulWidget {
  final Map<String, dynamic> product;

  FavoriteTile(this.product);

  @override
  _FavoriteTileState createState() => _FavoriteTileState();
}

class _FavoriteTileState extends State<FavoriteTile> {
  final _height = 100.0;
  Map<String, dynamic> _product;
  String _imgUrl;

  @override
  void initState() {
    // TODO: implement initState
    _product = widget.product;
    _imgUrl = _product['imgUrl'] ??
        'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fmoorestown-mall.com%2Fnoimage.gif&f=1&nofb=1';
    super.initState();
  }

  void _onSelectedPopupMenuOption(FavoriteOption selectedOption) {
    switch (selectedOption) {
      case FavoriteOption.REMOVE:
        // TODO: remove item from favorite list
        print('Removing...');
        break;
      case FavoriteOption.ADD_CART:
        // TODO: add item to cart
        print('Adding to cart list...');
        break;
      default:
        throw Exception('Unexpected argument');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: (){
          // TODO: navigate to product detail screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductDetails()),
          );
        },
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                _imgUrl,
                fit: BoxFit.cover,
                height: _height,
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                width: 1 / 0,
                height: _height,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        height: _height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Title',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '\$ 100.00',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      right: 0,
                      child: PopupMenuButton<FavoriteOption>(
                        icon: Icon(Icons.more_vert, color: Colors.grey[800]),
                        onSelected: _onSelectedPopupMenuOption,
                        itemBuilder: (_) => <PopupMenuItem<FavoriteOption>>[
                          PopupMenuItem<FavoriteOption>(
                            value: FavoriteOption.REMOVE,
                            child: Text('Remove'),
                          ),
                          PopupMenuItem<FavoriteOption>(
                            value: FavoriteOption.ADD_CART,
                            child: Text('Add to cart'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
