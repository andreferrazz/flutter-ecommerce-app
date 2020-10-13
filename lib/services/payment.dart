import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:e_commerce/util/constants.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();

  factory PaymentService() => _instance;

  PaymentService._internal();

  void init() {
    StripePayment.setOptions(StripeOptions(publishableKey: PK_STRIPE_API));
  }

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final HttpsCallable _intent = CloudFunctions.instance
      .getHttpsCallable(functionName: 'createPaymentIntent');

  Future<PaymentMethod> createPaymentMethod(String userId) {
    return StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
        .then((value) => _savePaymentMethod(userId, value));
  }

  Future<PaymentIntent> createPaymentIntent(
    double amount,
    PaymentMethod paymentMethod,
  ) async {
    // convert to cents
    amount *= 100.0;

    // call firebase cloud function
    var clientSecret = await _intent.call(<String, dynamic>{
      'amount': amount,
      'currency': CURRENCY_BRL,
    }).then((value) => value.data['client_secret']);

    return PaymentIntent(
        paymentMethodId: paymentMethod.id, clientSecret: clientSecret);
  }

  Future confirmPayment(PaymentIntent paymentIntent) async {
    String status = await StripePayment.confirmPaymentIntent(paymentIntent)
        .then((value) => value.status);
    if (status == 'success') return true;
    return false;
  }

  Future<PaymentMethod> _savePaymentMethod(
      String userId, PaymentMethod paymentMethod) {
    return _users
        .doc(userId)
        .collection('paymentMethods')
        .doc(paymentMethod.id)
        .set(paymentMethod.toJson())
        .then((value) => paymentMethod)
        .catchError((err) {
      print('Failed to save the payment method');
      return null;
    });
  }

  Future<PaymentMethod> getPaymentMethod(String id, String userId) {
    return _users
        .doc(userId)
        .collection('paymentMethods')
        .doc(id)
        .get()
        .then((value) => PaymentMethod.fromJson(value.data()))
        .catchError((err) {
      print('Failed to get the payment method');
      return null;
    });
  }

  Future<List<PaymentMethod>> getAllPaymentMethods(String userId) {
    return _users
        .doc(userId)
        .collection('paymentMethods')
        .get()
        .then((value) => value.docs)
        .then((value) =>
            value.map((e) => PaymentMethod.fromJson(e.data())).toList())
        .catchError((err) {
      print('Failed to get payment methods');
      return null;
    });
  }
}
