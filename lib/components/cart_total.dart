import 'package:e_commerce/blocs/cart_provider.dart';
import 'package:flutter/material.dart';

class CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartBloc = CartProvider.of(context);
    return StreamBuilder<double>(
      stream: cartBloc.subtotal,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        var subtotal = snapshot.data;
        var shipping = 0.0;
        var total = subtotal + shipping;
        return Container(
          // height: 100.0,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(0.0, 0.0),
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
                    Text('Shipping', style: TextStyle(color: Colors.grey[600])),
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
                  onPressed: () {
                    // TODO: redirect to payment page
                  },
                  elevation: 0,
                  // color: Theme.of(context).primaryColor,
                  child: Text('Continue'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
