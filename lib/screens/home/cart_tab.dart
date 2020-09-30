import 'package:e_commerce/widgets/cart_tile.dart';
import 'package:flutter/material.dart';

class CartTab extends StatefulWidget {
  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final fakeItems = [
    {'title': 'item1', 'price': 100.0, 'amount': 1, 'total': 100.0, 'imgUrl': null},
    {'title': 'item2', 'price': 200.0, 'amount': 1, 'total': 200.0, 'imgUrl': null},
    {'title': 'item3', 'price': 300.0, 'amount': 1, 'total': 300.0, 'imgUrl': null},
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
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: fakeItems.length,
        itemBuilder: (context, index) => CartTile(fakeItems[index]),
      ),
    );
  }
}
