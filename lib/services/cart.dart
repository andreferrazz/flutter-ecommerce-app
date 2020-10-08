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
    if (await isInCart(product.id, userId)) return false;

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

    return _users.doc(userId).update({
      'cartList': FieldValue.arrayUnion([cartItem.toJson()])
    }).then((value) {
      print('Product added to cart');
      return true;
    }).catchError((err) {
      print('Failed to add product to cart: $err');
      return false;
    });
  }

  // Get cart list
  Future<List<CartItem>> getAll(String userId) async {
    // Get cart list
    List<dynamic> result = await _users
        .doc(userId)
        .get()
        .then((value) => value.data()['cartList']);

    // Parse List<dynamic> to List<CartItem>
    List<CartItem> items = result.map((e) {
      e['addedAt'] = timestampToDateTime(e['addedAt']);
      return CartItem.fromJson(e);
    }).toList();

    return items;
  }

  // Check if the product is in the cart
  Future<bool> isInCart(String productId, String userId) async {
    List<CartItem> items = await getAll(userId);
    for (CartItem item in items) if (item.id == productId) return true;
    return false;
  }
}
