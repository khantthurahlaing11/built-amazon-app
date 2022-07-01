import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/bottom_bar.dart';
import 'package:flutterbackend/features/address/screen/address_screen.dart';
import 'package:flutterbackend/features/admin/screens/add_product_screen.dart';
import 'package:flutterbackend/features/auth/screens/auth_screen.dart';
import 'package:flutterbackend/features/home/screens/category_deals_screen.dart';
import 'package:flutterbackend/features/home/screens/home_screen.dart';
import 'package:flutterbackend/features/orders/screens/order_detail_screen.dart';
import 'package:flutterbackend/features/product_details/screens/product_detail_screen.dart';
import 'package:flutterbackend/features/search/screens/search_screen.dart';
import 'package:flutterbackend/models/order.dart';
import 'package:flutterbackend/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>AddProductScreen());
    case CategoryDealsScreen.routeName:
    var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>CategoryDealsScreen(category: category));
    case SearchScreen.routeName:
    var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>SearchScreen(searchQuery: searchQuery));
    case ProductDetailScreen.routeName:
    var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>ProductDetailScreen(product: product));
     case AddressScreen.routeName:
     var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>AddressScreen(totalAmount : totalAmount));
    case OrderDetailScreen.routeName:
     var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>OrderDetailScreen(order : order));
    default:
    return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>Scaffold(
          body: Center(
            child: Text("Screen does not exists!"),
          ),
        ));
  }
}