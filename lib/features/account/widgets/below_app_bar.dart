import 'package:flutter/material.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      decoration: BoxDecoration(
        gradient: GlobalVariables.appBarGradient
      ),
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Row(
        children: [RichText(
          text: TextSpan(
            text: "Hello, ",
            style: TextStyle(
              fontSize: 22,
              color: Colors.black
            ),
            children: [
              TextSpan(
            text: user.name,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w600
            ),
              )
            ]
          ),
          )],
      ),
    );
  }
}