import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/details/product_details.dart';
import 'package:e_commerce/services/cart.dart';
import 'package:e_commerce/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final String userId;
  final GlobalKey<ScaffoldState> globalKey;

  ProductCard(this.product, this.userId, this.globalKey);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  CartService _cartService = CartService();
  String _imgUrl;
  bool _isInCart = false;

  addToCart() {
    // Check if product is already in the cart
    if(_isInCart){
      widget.globalKey.currentState.showSnackBar(SnackBar(
        // backgroundColor: Colors.red,
        content: Text('Product is already in the cart!'),
        duration: Duration(seconds: 3),
      ));
      return;
    }

    // Add product to the cart
    _cartService.addToCart(widget.product, widget.userId).then((result) {
      if (result) {
        widget.globalKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Product added to cart!'),
          duration: Duration(seconds: 3),
        ));
        setState(() => _isInCart = true);
      }else {
        widget.globalKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Product not added to cart!'),
          duration: Duration(seconds: 3),
        ));
      }
    });
  }

  @override
  void initState() {
    _imgUrl = widget.product.imgUrl ?? NO_IMAGE_URL;
    _cartService.isInCart(widget.product.id, widget.userId).then((value) {
      setState(() => _isInCart = value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          // TODO: navigate to product detail screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductDetails()),
          );
        },
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.2,
              child: Image.network(_imgUrl, fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        widget.product.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '\$ ${(widget.product.price / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // TODO: add to favorite list(probably use a service for that)
                            print('favorite');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.favorite_border,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: addToCart,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              _isInCart
                                  ? Icons.shopping_cart
                                  : Icons.add_shopping_cart,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    )
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
