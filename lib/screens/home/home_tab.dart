import 'package:e_commerce/blocs/cart_provider.dart';
import 'package:e_commerce/models/cart_item.dart';
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
    // int count = 1;
    return Center(
      child: RaisedButton(
        onPressed: () async {
          /*
              Clear cart
           */
          // var userId = Provider.of<CustomUser>(context, listen: false).id;
          // CartService().clearCart(userId);

          /*
              Increment and decrement amount of CartItem
           */
          // var userId = Provider.of<CustomUser>(context, listen: false).id;
          // var id = '6ec1e3e1-0284-464b-944a-d9b4f9b64382';
          // print(await CartService().setAmount(id, userId, ++count));

          /*
              Remove item from cart
           */
          // var userId = Provider.of<CustomUser>(context, listen: false).id;
          // var id = '508466ff-fde6-4d88-990f-c7de56523588';
          // print(await CartService().removeItem(id, userId));

          /*
              Get cart list
           */
          // var userId = Provider.of<CustomUser>(context, listen: false).id;
          // print(await CartService().getAll(userId));

          /*
              Check if product is in the cart
           */
          // var id = '508466ff-fde6-4d88-990f-c7de56523588';
          // var userId = Provider.of<CustomUser>(context, listen: false).id;
          // print(await CartService().isInCart(id, userId));

          /*
              Get one product from cart
           */
          // var id = '508466ff-fde6-4d88-990f-c7de5652358';
          // var userId = Provider.of<CustomUser>(context, listen: false).id;
          // CartItem cartItem = await CartService().getOne(id, userId);
          // print(cartItem);

          /*
              Remover item from cart
           */
          // CartItem product = await CartService()
          //     .getAll(Provider.of<CustomUser>(context, listen: false).id)
          //     .then((value) => value[0]);
          // CartService().removeItem(
          //     product,
          //     Provider.of<CustomUser>(context, listen: false).id);

          /*
              Add a product to cart
           */
          // Product product =
          //     await ProductStorageService().getAll().then((value) => value[0]);
          // // print(product);
          // bool result = await CartService().addToCart(
          //     product, Provider.of<CustomUser>(context, listen: false).id);
          // print(result);

          /*
              Add a product
           */
          ProductStorageService().addProduct(Product(
            'HD externo 3TB',
            'Um hd externo da hora',
            'https://firebasestorage.googleapis.com/v0/b/e-commerce-aa26b.appspot.com/o/product-images%2Fhd-externo-2.jpeg?alt=media&token=da348a5d-0028-4a15-ad1e-7fc793b0fbbb',
            100000,
            id: Uuid().v4(),
            createdAt: DateTime.now(),
          ));
        },
        child: Text('Test'),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  HomeTab(this._globalKey);

  final GlobalKey<ScaffoldState> _globalKey;
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
                return ProductCard(
                  snapshot.data[index],
                  Provider.of<CustomUser>(context, listen: false).id,
                  _globalKey,
                );
              },
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
