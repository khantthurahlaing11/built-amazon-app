import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/custom_button.dart';
import 'package:flutterbackend/common/widgets/custom_textfield.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/features/auth/services/auth_service.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser(){
    authService.signUpUser(context: context, email: _emailController.text, password: _passwordController.text, name: _nameController.text);
  }

   void signInUser(){
    authService.signInUser(context: context, email: _emailController.text, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
              Text(
                "Welcome",
                
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,),
              ),
              SizedBox(height: 10,),
              ListTile(
                tileColor: _auth == Auth.signup?
                GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                title: Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
                if(_auth==Auth.signup)
                Container(
                  padding: EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [    
                        CustomTextField(controller: _nameController,hintText: "Name",),
                        SizedBox(height: 10,),
                        CustomTextField(controller: _emailController,hintText: "Email",),
                        SizedBox(height: 10,),
                        CustomTextField(controller: _passwordController,hintText: "Password",),
                        SizedBox(height: 10,),
                        CustomButton(text: 'Sign Up', onTap: (){
                          if(_signUpFormKey.currentState!.validate()){
                            signUpUser();
                          }
                        })
                      ],
                    )
                    ),
                ),
      
              ListTile(
                tileColor: _auth == Auth.signin?
                GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                title: Text(
                  'Sign-In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
      
              if(_auth==Auth.signin)
                Container(
                  padding: EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [    
                        CustomTextField(controller: _emailController,hintText: "Email",),
                        SizedBox(height: 10,),
                        CustomTextField(controller: _passwordController,hintText: "Password",),
                        SizedBox(height: 10,),
                        CustomButton(text: 'Sign In', onTap: (){
                           if(_signInFormKey.currentState!.validate()){
                            signInUser();
                          }
                        })
                      ],
                    )
                    ),
                ),
          ],
        ),
            )),
      ),
    );
  }
}
