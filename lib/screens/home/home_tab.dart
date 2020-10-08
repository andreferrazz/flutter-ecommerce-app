import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/product_storage.dart';
import 'package:e_commerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TestTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          ProductStorageService().addProduct(Product(
            'Monitor',
            'Um monitor da hora',
            null,
            50000,
            id: Uuid().v4(),
          ));
        },
        child: Text('Test'),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final ProductStorageService _productStorageService = ProductStorageService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productStorageService.getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.65,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ProductCard(snapshot.data[index]);
              },
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
