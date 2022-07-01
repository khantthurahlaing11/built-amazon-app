import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterbackend/constants/error-handling.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/constants/utils.dart';
import 'package:flutterbackend/features/admin/models/sale.dart';
import 'package:flutterbackend/models/order.dart';
import 'package:flutterbackend/models/product.dart';
import 'package:flutterbackend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService{
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images
  })async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try {
      final cloudinary = CloudinaryPublic('ktyh', 'qkwqegag');
      List<String> imageUrls = [];

      for(int i=0;i<images.length;i++){
      CloudinaryResponse res =  await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path,folder: name)
        );
      imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name, 
        description: description, 
        price: price, 
        quantity: quantity, 
        category: category, 
        images: imageUrls, 
       );

      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
      body: product.toJson(),
      );

       httpErrorHandle(response: res, context: context, onSuccess: (){
          showSnackBar(context, 'Product Added Successfully');
          Navigator.pop(context);
        });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get all products
  Future<List<Product>> fetchAllProduct(BuildContext context)async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Product> productList = [];
    try {
       http.Response res = await  http.get(Uri.parse('$uri/admin/get-products'),
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

    //orders
  Future<List<Order>> fetchAllOrders(BuildContext context)async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Order> orderList = [];
    try {
       http.Response res = await  http.get(Uri.parse('$uri/admin/get-orders'),
       headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
      );

      httpErrorHandle(response: res, context: context, onSuccess: (){
        for(int i=0; i < jsonDecode(res.body).length;i++){
          orderList.add(
            Order.fromJson(
              jsonEncode(jsonDecode(res.body)[i])
            )
          );
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
    return orderList;
  }

   //Order Status
  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess
  })async{
      final userProvider = Provider.of<UserProvider>(context,listen: false);
    try {

      http.Response res = await http.post(Uri.parse('$uri/admin/change-order-status'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
      body: jsonEncode({
        'id' : order.id,
        'status' : status
      }),
      );

       httpErrorHandle(response: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

      //Analytics
  Future<Map<String,dynamic>> getEarnings(BuildContext context)async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Sales> sales = [];
    int totalEarnings = 0;
    try {
       http.Response res = await  http.get(Uri.parse('$uri/admin/analytics'),
       headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
      );

      httpErrorHandle(response: res, context: context, onSuccess: (){
        var response = jsonDecode(res.body);
        totalEarnings = response['totalEarnings'];
        sales = [
          Sales('Mobiles', response['mobileEarnings']),
          Sales('Essentials', response['essentialsEarnings']),
          Sales('Appliances', response['appliancesEarnings']),
          Sales('Books', response['booksEarnings']),
          Sales('Fashion', response['fashionEarnings']),
        ];
      });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
    return {
      'sales' : sales,
      'totalEarnings': totalEarnings
    };
  }

}