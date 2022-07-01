import 'package:flutter/material.dart';
import 'package:flutterbackend/features/account/services/account_service.dart';
import 'package:flutterbackend/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
               onTap: (){

            }),
             AccountButton(
              text: 'Turn Seller',
               onTap: (){

            }),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
               onTap: ()=>AccountService().logOut(context)
               ),
             AccountButton(
              text: 'Your Wish List',
               onTap: (){

            }),
          ],
        )
      ],
    );
  }
}