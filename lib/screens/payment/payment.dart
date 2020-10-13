import 'package:e_commerce/blocs/cart_provider.dart';
import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/models/custom_user.dart';
import 'package:e_commerce/services/cart.dart';
import 'package:e_commerce/services/payment.dart';
import 'package:e_commerce/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentScreen extends StatefulWidget {
  final double total;

  PaymentScreen(this.total);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final PaymentService _paymentService = PaymentService();
  final CartService _carService = CartService();
  List<PaymentMethod> _paymentMethods;
  PaymentMethod _selected;
  // double _amount = 1000.0;

  @override
  void initState() {
    // TODO: implement initState
    _paymentService.init();
    _paymentMethods = List();
    // _getPaymentMethods();
    super.initState();
  }

  void _getPaymentMethods() {
    var userId = Provider.of<CustomUser>(this.context, listen: false).id;
    _paymentService.getAllPaymentMethods(userId).then((value) {
      setState(() {
        _paymentMethods = value;
        _selected = value[0];
      });
    });
  }

  void _addPaymentMethod() {
    var userId = Provider.of<CustomUser>(this.context, listen: false).id;
    _paymentService.createPaymentMethod(userId).then((value) {
      // print(value);
      if (value == null) return;
      setState(() {
        _paymentMethods.add(value);
        _selected = value;
      });
    });
  }

  void _performPayment() async {
    // Get payment intent
    PaymentIntent paymentIntent =
        await _paymentService.createPaymentIntent(widget.total, _selected);

    // Show user confirmation dialog
    var userChoice = await _showDialogAndGetTheResult();

    // confirm payment if user choice is true
    if (userChoice) {
      bool result = await _paymentService.confirmPayment(paymentIntent);
      print(result);
      if (!result) {
        _globalKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Erro no pagamento! Transação cancelada'),
          duration: Duration(seconds: 3),
        ));
      }
      _globalKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text('Pagamento efetuado com sucesso'),
        duration: Duration(seconds: 3),
      ));
      bool clearResult = await _carService.clearCart(Provider.of<CustomUser>(context, listen: false).id);
      if(clearResult){
        CartProvider.of(context).cart.add(List<CartItem>());
      }
      Navigator.pop(context);
    } else {
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text('Pagamento não efetuado'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Payment'),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(16.0),
          onPressed: _paymentMethods == null || _paymentMethods.isEmpty
              ? null
              : _performPayment,
          child: Text(
            'Continuar',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300],
                width: 1.0,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            // color: Colors.blue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Total a pagar:', style: paymentTextStyle),
                      Text('R\$ ${widget.total.toStringAsFixed(2)}', style: paymentTextStyle),
                    ],
                  ),
                ),
                Divider(height: 0, color: Colors.grey[300]),
                _paymentMethods == null || _paymentMethods.isEmpty
                    ? Container()
                    : Column(
                        children: _paymentMethods
                            .map((p) => _buildListTile(p))
                            .toList(),
                      ),
                InkWell(
                  onTap: _addPaymentMethod,
                  child: Container(
                    padding: EdgeInsets.all(24.0),
                    child: Center(
                      child: Text('Adicionar cartão de crédito',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(PaymentMethod p) {
    return Column(
      children: <Widget>[
        RadioListTile(
          title: Text('xxxx xxxx xxxx ${p.card.last4}'),
          value: p,
          groupValue: _selected,
          secondary: Icon(Icons.credit_card),
          onChanged: (PaymentMethod value) {
            setState(() {
              _selected = value;
            });
          },
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }

  Future _showDialogAndGetTheResult() {
    return showDialog(
        context: this.context,
        builder: (_) {
          return AlertDialog(
            title: Text('Confirmar pagamento'),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Valor: R\$ ${widget.total}', style: TextStyle(fontSize: 17.0)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Cartão com final ${_selected.card.last4}',
                      style: TextStyle(fontSize: 17.0)),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('Cancelar', style: TextStyle(color: Colors.red)),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text('Confirmar'),
              ),
            ],
          );
        });
  }
}
