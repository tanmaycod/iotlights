import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iotlights/providers.dart';
import 'package:iotlights/services/authservice.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
late UserLoggedIn userSignedIn;
  @override
  Widget build(BuildContext context) {
    userSignedIn = ref.watch(userLoggedInProvider);
    return Scaffold(
      body: Center(
        child: Container(
          height: 30.0,
          width: 100.0,
          child: ElevatedButton(
            onPressed: (){
              AuthService().signOut(context, userSignedIn);
            },
            child: const Text('SingOut'),
          ),
        ),
      ),
    );
  }
}
