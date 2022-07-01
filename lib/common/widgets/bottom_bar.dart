import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/features/account/screens/account_screen.dart';
import 'package:flutterbackend/features/cart/screens/cart_screen.dart';
import 'package:flutterbackend/features/home/screens/home_screen.dart';
import 'package:flutterbackend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomBar({ Key? key }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    HomeScreen(),
    AccountScreen(),
    CartScreen()
  ];

  void updatePage(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    final userCartLen = Provider.of<UserProvider>(context).user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //Home 
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(
                color: _page==0? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth
              ))
            ),
            child: Icon(Icons.home_outlined),
          ),
          label: ''
          ),
          //Account
            BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(
                color: _page==1? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth
              ))
            ),
            child: Icon(Icons.person_outline_outlined),
          ),
          label: ''
          ),
          //Cart
            BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(
                color: _page==2? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth
              ))
            ),
            child: Badge(
              elevation: 0,
              badgeContent: Text(userCartLen.toString()),
              badgeColor: Colors.white,
              child: Icon(Icons.shopping_cart_outlined)),
          ),
          label: ''
          ),
        ],
        
      ),
    );
  }
}

