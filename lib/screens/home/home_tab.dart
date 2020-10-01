import 'package:e_commerce/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final fakeItems = [
    {'title': 'item1', 'price': 100.0, 'imgUrl': null},
    {'title': 'item2', 'price': 200.0, 'imgUrl': null},
    {'title': 'item3', 'price': 300.0, 'imgUrl': null},
    {
      'title': 'item4',
      'price': 50.0,
      'imgUrl':
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.iTh4TBHYy0iAjn2Fyp5pGwHaEK%26pid%3DApi&f=1'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.65,
        ),
        itemCount: fakeItems.length,
        itemBuilder: (context, index) {
          return ProductCard(fakeItems[index]);
        },
      ),
    );
  }
}
