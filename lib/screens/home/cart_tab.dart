import 'package:e_commerce/components/cart_tile.dart';
import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/models/custom_user.dart';
import 'package:e_commerce/services/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTab extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;

  CartTab(this.globalKey);

  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final CartService _cartService = CartService();

  double subtotal = 0.0;

  double shipping = 0.0;

  double total = 0.0;

  Function removeItem;

  @override
  void initState() {
    // TODO: implement initState
    removeItem = (CartItem product, String userId) {
      _cartService.removeItem(product, userId).then((result) {
        if (result) {
          setState(() {});

          widget.globalKey.currentState.showSnackBar(SnackBar(
            content: Text('Product removed from cart'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ));
        } else {
          widget.globalKey.currentState.showSnackBar(SnackBar(
            content: Text('Product not removed from cart'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ));
        }
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CartItem>>(
      future: _cartService
          .getAll(Provider.of<CustomUser>(context, listen: false).id),
      builder: (BuildContext context, AsyncSnapshot<List<CartItem>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong: ${snapshot.error}"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // setState(() {
          subtotal = snapshot.data.fold(
              0, (previousValue, element) => previousValue + element.total);
          subtotal /= 100;
          shipping = 0.0;
          total = subtotal + shipping;
          // });
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => CartTile(
                      snapshot.data[index],
                      Provider.of<CustomUser>(context, listen: false).id,
                      widget.globalKey,
                      removeItem,
                    ),
                  ),
                ),
              ),
              snapshot.data.isEmpty
                  ? Container()
                  : Container(
                      // height: 100.0,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 1.0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            0.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Subtotal',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                    )),
                                Text('\$ ${subtotal.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                    )),
                              ],
                            ),
                            SizedBox(height: 6.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Shipping',
                                    style: TextStyle(color: Colors.grey[600])),
                                Text('\$ ${shipping.toStringAsFixed(2)}',
                                    style: TextStyle(color: Colors.grey[600])),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('TOTAL',
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text('\$ ${total.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            RaisedButton(
                              onPressed: () {},
                              elevation: 0,
                              color: Theme.of(context).primaryColor,
                              child: Text('Continue',
                                  style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
