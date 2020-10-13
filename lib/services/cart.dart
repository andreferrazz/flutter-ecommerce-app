import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/util/datetime.dart';

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  // Add to cart
  Future<bool> addToCart(Product product, String userId) async {
    // Finish the method if the product already in cart
    // if (await isInCart(product.id, userId)) return false;

    CartItem cartItem = CartItem(
      1,
      product.price,
      DateTime.now(),
      product.id,
      product.title,
      product.description,
      product.imgUrl,
      product.price,
    );

    return _users
        .doc(userId)
        .collection('cart')
        .doc(cartItem.id)
        .set(cartItem.toJson())
        .then((value) {
      print('Product added to cart');
      return true;
    }).catchError((err) {
      print('Failed to add product to cart: $err');
      return false;
    });
  }

  // Get cart list
  Future<List<CartItem>> getAll(String userId) {
    return _users
        .doc(userId)
        .collection('cart')
        .get()
        .then((value) => value.docs.map((e) {
              Map<String, dynamic> map = e.data();
              map['addedAt'] = timestampToDateTime(map['addedAt']);
              return CartItem.fromJson(map);
            }).toList());
  }

  // Get one item
  Future<CartItem> getOne(String id, String userId) {
    return _users.doc(userId).collection('cart').doc(id).get().then((value) {
      Map<String, dynamic> result = value.data();
      if (result == null) return null;
      result['addedAt'] = timestampToDateTime(result['addedAt']);
      return CartItem.fromJson(result);
    });
  }

  // Check if the product is in the cart
  Future<bool> isInCart(String productId, String userId) async {
    CartItem cartItem = await getOne(productId, userId);
    if (cartItem == null) return false;
    return true;
  }

  // Remove item
  Future<bool> removeItem(String id, String userId) {
    return _users.doc(userId).collection('cart').doc(id).delete().then((value) {
      print('Product removed from cart.');
      return true;
    }).catchError((err) {
      print('Failed to remove product from cart.');
      return false;
    });
  }

  // Clear cart
  Future<bool> clearCart(String userId) {
    return _users
        .doc(userId)
        .collection('cart')
        .get()
        .then((value) => value.docs)
        .then((value) => value.forEach((element) {
              _users
                  .doc(userId)
                  .collection('cart')
                  .doc(element.data()['id'])
                  .delete();
            }))
        .then((value) => true)
        .catchError((err) => false);
  }

  // Increment amount
  Future<bool> setAmount(String id, String userId, int amount) {
    return _users
        .doc(userId)
        .collection('cart')
        .doc(id)
        .update({'amount': amount}).then((value) {
      print('Amount updated');
      return true;
    }).catchError((err) {
      print('Failed to update amount');
      return false;
    });
  }
}
