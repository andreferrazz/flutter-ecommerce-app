import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/details/product_details.dart';
import 'package:e_commerce/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard(this.product);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String _imgUrl;

  @override
  void initState() {
    _imgUrl = widget.product.imgUrl ?? NO_IMAGE_URL;
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
                          onTap: () {
                            // TODO: add to cart(probably use a service for that)

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.add_shopping_cart,
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
