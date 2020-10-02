import 'package:e_commerce/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String _imgUrl;
  Map<String, dynamic> _fakeProduct;

  @override
  void initState() {
    // TODO: implement initState
    _fakeProduct = {
      'title': 'Item1',
      'description': fakeDescription,
      'price': 150.0,
      'imgUrl': null,
      'cart': true,
    };
    _imgUrl = _fakeProduct['imgUrl'] ??
        'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fmoorestown-mall.com%2Fnoimage.gif&f=1&nofb=1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_fakeProduct['title']),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              'Title',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.grey[800],
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: Image.network(
              _imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              children: <Widget>[
                Text(
                  '\$ ${_fakeProduct['price'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Offer',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              _fakeProduct['description'],
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.grey[800],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: RaisedButton(
              onPressed: () {},
              color: Theme.of(context).primaryColor,
              elevation: 0.0,
              child: Text(
                'Buy',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: OutlineButton(
              onPressed: _fakeProduct['cart'] ? null : () {},
              color: Colors.white,
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              child: Text(
                'Add to cart',
                style: TextStyle(
                  color: _fakeProduct['cart']
                      ? null
                      : Theme.of(context).primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
