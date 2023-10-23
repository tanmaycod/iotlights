import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iotlights/providers.dart';
import 'package:iotlights/services/authservice.dart';
import 'package:iotlights/signup_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late String username,password;
  late UserLoggedIn userSignedIn;
  @override
  Widget build(BuildContext context) {
    userSignedIn = ref.watch(userLoggedInProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
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
                    decoration: const InputDecoration(hintText: 'Username'),
                    onChanged: (val){
                      setState(() {
                        username=val;
                      });
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(hintText: 'Password'),
                    onChanged: (val){
                      setState(() {
                        password=val;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                      onPressed: (){
                        //to do
                        AuthService().signIn(username, password, userSignedIn);
                      }
                      , child: const Center(
                    child: Text('Sign In'),
                  )
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage()));
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
