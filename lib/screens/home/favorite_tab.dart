import 'package:e_commerce/components/favorite_tile.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = List();
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: true
          ? Center(
              child: Text(
                'Funcionalidade não disponível',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => FavoriteTile(products[index]),
            ),
    );
  }
}
