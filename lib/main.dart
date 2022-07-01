import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/bottom_bar.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/features/admin/screens/admin_screen.dart';
import 'package:flutterbackend/features/auth/screens/auth_screen.dart';
import 'package:flutterbackend/features/auth/services/auth_service.dart';

import 'package:flutterbackend/providers/user_provider.dart';
import 'package:flutterbackend/router.dart';
import 'package:provider/provider.dart';


void main() {
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider(),)
    ],
    child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
 

  @override
  void initState() {
    super.initState();
    authService.getUserdata(context);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: ColorScheme.light(
          primary: GlobalVariables.secondaryColor
        )
      ),
      onGenerateRoute: (settings)=>generateRoute(settings),
      home:  Provider.of<UserProvider>(context).user.token.isNotEmpty?
       Provider.of<UserProvider>(context).user.type == 'user' ?
      BottomBar() : AdminScreen()
      :
      AuthScreen(),
    );
  }
}

