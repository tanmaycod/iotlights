import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iotlights/amplifyconfiguration.dart';
import 'package:iotlights/homepage.dart';
import 'package:iotlights/login_page.dart';
import 'package:iotlights/models/ModelProvider.dart';
import 'package:iotlights/providers.dart';

void main() {
  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool _amplifyConfigured = false;
  bool checkAuthStatus = false;
  late UserLoggedIn userLoggedIn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {

    try {
      final auth = AmplifyAuthCognito();
      final data =AmplifyDataStore(modelProvider: ModelProvider.instance);
      await Amplify.addPlugins([auth,data]);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }

    try{
      getUserStatus();
          setState(() {
            _amplifyConfigured = true;
          });
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    userLoggedIn = ref.watch(userLoggedInProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AWS'),
          centerTitle: true,
        ),
        body: _amplifyConfigured ?
        checkAuthStatus ?
            userLoggedIn.getUserCurrentState() ? const HomePage() :
        const LoginPage(): const Text('Loading')
            :const Text('Loading')
        ,
      ),
    );
  }
   getUserStatus()async {
    handleAuth().then((val){
      if(val.isSignedIn){
        userLoggedIn.setUserCurrentState(val.isSignedIn);
        setState(() {
          checkAuthStatus=true;
        });
      }else{
        setState(() {
          checkAuthStatus=true;
        });
        return const LoginPage();
      }
    });
  }
   handleAuth() async{
    var authStatus = await Amplify.Auth.fetchAuthSession();
    return authStatus;
  }
}


