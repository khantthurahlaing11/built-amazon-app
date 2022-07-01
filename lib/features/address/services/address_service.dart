import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterbackend/constants/error-handling.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/constants/utils.dart';
import 'package:flutterbackend/models/product.dart';
import 'package:flutterbackend/models/user.dart';
import 'package:flutterbackend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressService{
  void saveUserAddress({
    required BuildContext context,
    required String address,
  })async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try {
      
      http.Response res = await http.post(Uri.parse('$uri/api/save-user-address'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
      body: jsonEncode({
        'address': address
      }),
      );

       httpErrorHandle(response: res, context: context, onSuccess: (){
         User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address']
          );
          userProvider.setUserFromModel(user);
        });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //PlaceOrder
  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum
  })async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);

    try {
       http.Response res = await  http.post(Uri.parse('$uri/api/order'),
       headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
       body: jsonEncode({
        'cart': userProvider.user.cart,
        'address' : address,
        'totalPrice' : totalSum
      }),
      );

      httpErrorHandle(response: res, context: context, onSuccess: (){
        showSnackBar(context, 'Your oder has been placed!');
         User user = userProvider.user.copyWith(
           cart: []
         );
         userProvider.setUserFromModel(user);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }

  }


  //Delete Product
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess
  })async{
      final userProvider = Provider.of<UserProvider>(context,listen: false);
    try {

      http.Response res = await http.post(Uri.parse('$uri/admin/delete-product'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
      body: jsonEncode({
        'id' : product.id
      }),
      );

       httpErrorHandle(response: res, context: context, onSuccess: (){
          onSuccess();
        });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

}