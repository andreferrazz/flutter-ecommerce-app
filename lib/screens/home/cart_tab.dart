import 'dart:ui';

import 'package:e_commerce/widgets/cart_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartTab extends StatelessWidget {
  final fakeItems = [
    {
      'title': 'item1',
      'price': 100.0,
      'amount': 1,
      'total': 100.0,
      'imgUrl': null
    },
    {
      'title': 'item2',
      'price': 200.0,
      'amount': 1,
      'total': 200.0,
      'imgUrl': null
    },
    {
      'title': 'item3',
      'price': 300.0,
      'amount': 1,
      'total': 300.0,
      'imgUrl': null
    },
    {
      'title': 'item1',
      'price': 100.0,
      'amount': 1,
      'total': 100.0,
      'imgUrl': null
    },
    {
      'title': 'item2',
      'price': 200.0,
      'amount': 1,
      'total': 200.0,
      'imgUrl': null
    },
    {
      'title': 'item3',
      'price': 300.0,
      'amount': 1,
      'total': 300.0,
      'imgUrl': null
    },
    {
      'title': 'item4',
      'price': 50.0,
      'amount': 1,
      'total': 50.0,
      'imgUrl':
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.iTh4TBHYy0iAjn2Fyp5pGwHaEK%26pid%3DApi&f=1'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: ListView.builder(
              itemCount: fakeItems.length,
              itemBuilder: (context, index) => CartTile(fakeItems[index]),
            ),
          ),
        ),
        fakeItems.isEmpty
            ? Container()
            : Container(
                // height: 100.0,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                          Text('\$ 399.99',
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
                          Text('\$ 0.00',
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
                          Text('\$ 399.99',
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
}
