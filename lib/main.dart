import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';


void main() {
  MpesaFlutterPlugin.setConsumerKey("Yd9IqUNruDXUFbrGKBTYv4dIn4GjGwrG");
  MpesaFlutterPlugin.setConsumerSecret("XLjnGFYl1aNz9t2S");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var number = TextEditingController();

//method to initiate the transaction
  Future<void> startCheckout({String userPhone, String amount}) async {
    dynamic transactionInitialization;

    try {
      transactionInitialization =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: double.parse(amount),
        partyA: userPhone,
        partyB: "174379",
        callBackURL: Uri.parse("https://sandbox.safaricom.co.ke/"),
        accountReference: "Flutter Mpesa Tim",
        phoneNumber: userPhone,
        transactionDesc: "Purchase",
        baseUri: Uri.parse("https://sandbox.safaricom.co.ke/"),
        passKey:
            "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
      );
      print("Transaction Result: " + transactionInitialization.toString());
      return transactionInitialization;
    } catch (e) {
      print("Exception: " + e.toString());
    }
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Sending Request'),
        duration: Duration(seconds: 2),
        // action: SnackBarAction(
        //     label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'MPESA Payment',
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: Builder(
            //body now wrapped in a Builder
            builder: (context) => Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/merchant.png'),
                        SizedBox(
                          height: 15.0,
                        ),
                        FloatingActionButton.extended(
                          backgroundColor: Colors.blueAccent,
                          icon: Icon(Icons.account_balance_wallet),
                          label: Text('Pay', style: TextStyle(color: Colors.white),),
                          onPressed: () {
                             _showToast(context);
                              startCheckout(
                                  userPhone: "254741095752", amount: "1");
                          },
                        ),
                      
                      ]),
                )));
  }
}
