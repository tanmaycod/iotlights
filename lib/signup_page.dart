import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iotlights/services/authservice.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String username,password,email;
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
                      hintText: 'Email'
                    ),
                    onChanged: (val){
                      setState(() {
                        email=val;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Username'
                    ),
                    onChanged: (val){
                      setState(() {
                        username=val;
                      });
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'Password'
                    ),
                    onChanged: (val){
                      setState(() {
                        password=val;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                      onPressed:(){
                        AuthService().signUp(email, username, password, context);
                      }
                      , child:const Center(
                    child: Text('Sign Up'),
                  )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
