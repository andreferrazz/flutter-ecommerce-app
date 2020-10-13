import 'package:e_commerce/models/custom_user.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  ProductDetails(this.product);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String _userId;
  String _imgUrl;
  bool _isInCart = false;
  bool _isInFavorites = false;
  final CartService _cartService = CartService();

  @override
  void initState() {
    // TODO: implement initState
    _userId = Provider.of<CustomUser>(context, listen: false).id;
    _cartService.isInCart(widget.product.id, _userId).then((value) {
      setState(() => _isInCart = value);
    });
    _imgUrl = widget.product.imgUrl ??
        'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fmoorestown-mall.com%2Fnoimage.gif&f=1&nofb=1';
    super.initState();
  }

  void addToCart() {
    _cartService.addToCart(widget.product, _userId).then((value) {
      setState(() {
        _isInCart = true;
      });
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text('${widget.product.title} adicionado ao carrinho'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 3),
      ));
    }).catchError((err) {
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text('Não foi possível adicionar ao carrinho'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    });
  }

  void addToFavorites() {
    _globalKey.currentState.showSnackBar(SnackBar(
      content: Text('Funcionlidade não disponível'),
      backgroundColor: Colors.yellow[700],
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(widget.product.title),
        // centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
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
                  '\$ ${widget.product.price.toStringAsFixed(2)}',
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
              widget.product.description,
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
            child: Row(
              children: <Widget>[
                Expanded(
                  child: OutlineButton(
                    onPressed: _isInCart ? null : addToCart,
                    color: Colors.white,
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    child: Text(
                      'Add to cart',
                      style: TextStyle(
                        color:
                            _isInCart ? null : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: OutlineButton(
                    onPressed: _isInFavorites ? null : addToFavorites,
                    color: Colors.white,
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    child: Text(
                      'Add to favorites',
                      style: TextStyle(
                        color: _isInFavorites
                            ? null
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
