import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterbackend/constants/error-handling.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/constants/utils.dart';
import 'package:flutterbackend/models/product.dart';
import 'package:flutterbackend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchService{
  Future<List<Product>> fetchSearchedProduct({
    required BuildContext context,
    required String searchQuery
  })async{
     final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Product> productList = [];
    try {
       http.Response res = await  http.get(Uri.parse('$uri/api/products/search/$searchQuery'),
       headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
      );

      httpErrorHandle(response: res, context: context, onSuccess: (){
        for(int i=0; i < jsonDecode(res.body).length;i++){
          productList.add(
            Product.fromJson(
              jsonEncode(jsonDecode(res.body)[i])
            )
          );
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
    return productList;
  }
}