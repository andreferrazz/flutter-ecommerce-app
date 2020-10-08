import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/util/datetime.dart';

class ProductStorageService {
  static final ProductStorageService _instance =
      ProductStorageService._internal();

  factory ProductStorageService() {
    return _instance;
  }

  ProductStorageService._internal();

  CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  // Store a Product on Firebase
  Future<bool> addProduct(Product product) {
    return _products
        .doc(product.id)
        .set(product.toJson())
        .then((value) => true)
        .catchError((err) {
      print('Failed to add product: $err');
      return false;
    });
  }

  // Get all products
  Future<List<Product>> getAll() {
    return _products.orderBy('createdAt').get().then((value) {
      return value.docs.map((e) {
        var data = e.data();
        data['createdAt'] = timestampToDateTime(e.data()['createdAt']);
        // print(data);
        return Product.fromJson(data);
      }).toList();
    });
  }
}
