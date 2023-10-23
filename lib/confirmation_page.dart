import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iotlights/services/authservice.dart';

class ConfirmationPage extends StatefulWidget {
  final username;
   const ConfirmationPage({Key? key, this.username}) : super(key: key);

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  late String code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        Container(
        padding: EdgeInsets.all(8.0),
        height: 300.0,
        width: MediaQuery.of(context).size.width - 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow:[
            BoxShadow(
                color: Colors.grey.withOpacity(0.7)
            )
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            children: [
        TextFormField(
        decoration: const InputDecoration(
        hintText: 'Confirmation Code'
        ),
        onChanged: (val){
          setState(() {
            code=val;
          });
        },
      ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                  onPressed:() {
                    AuthService().confirmUser(widget.username, code, context);
                  },
                child: const Text('Confirm'),

              ),
      ]),
      ),
      ]
    ),
      ),
    );
  }
}
