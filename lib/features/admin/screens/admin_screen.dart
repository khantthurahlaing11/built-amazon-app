import 'package:flutter/material.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/features/admin/screens/analytics_screen.dart';
import 'package:flutterbackend/features/admin/screens/orders_screen.dart';
import 'package:flutterbackend/features/admin/screens/post_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({ Key? key }) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    PostScreen(),
    AnalyticsScreen(),
    OrdersScreen()
  ];

  void updatePage(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/amazon_in.png",width: 120,height: 45,color: Colors.black,)
              ),
              Text('Admin',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
              )
            ],
          ),

        ),
      ),
       body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //Posts
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
          //Analytics
            BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(
                color: _page==1? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth
              ))
            ),
            child: Icon(Icons.analytics_outlined),
          ),
          label: ''
          ),
         //Orders
            BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(
                color: _page==2? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth
              ))
            ),
            child: Icon(Icons.all_inbox_outlined),
          ),
          label: ''
          ),
        ],
        
      ),
    );
  }
}