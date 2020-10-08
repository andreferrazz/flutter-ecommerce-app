import 'package:e_commerce/models/custom_user.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/cart.dart';
import 'package:e_commerce/services/product_storage.dart';
import 'package:e_commerce/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TestTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          Product product = await ProductStorageService().getAll().then((value) => value[2]);
          // print(product);
          bool result = await CartService().addToCart(product, Provider.of<CustomUser>(context, listen: false).id);
          print(result);
          // ProductStorageService().addProduct(Product(
          //   'Monitor',
          //   'Um monitor da hora',
          //   'https://firebasestorage.googleapis.com/v0/b/e-commerce-aa26b.appspot.com/o/product-images%2Fmouse-2.jpeg?alt=media&token=cf064742-7732-4ef7-849a-df4f034f6632',
          //   8000,
          //   id: Uuid().v4(),
          //   createdAt: DateTime.now(),
          // ));
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
          return Center(child: Text("Something went wrong: ${snapshot.error}"));
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
