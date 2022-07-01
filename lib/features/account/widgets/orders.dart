import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/loader.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/features/account/services/account_service.dart';
import 'package:flutterbackend/features/account/widgets/single_product.dart';
import 'package:flutterbackend/features/orders/screens/order_detail_screen.dart';
import 'package:flutterbackend/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({ Key? key }) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
 List<Order>? orders;
 final AccountService accountService = AccountService();
 @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders()async{
    orders = await accountService.fetchMyOrders(context: context);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return orders==null ? Loader() : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Text("Your Orders",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 15),
              child: Text("See all",
              style: TextStyle(
                color: GlobalVariables.selectedNavBarColor
              ),
              ),
            )
          ],
        ),
        //display orders
        Container(
          height: 200,
  
          padding: EdgeInsets.only(left: 10,top: 20,right: 0),
          child: ListView.builder(
            scrollDirection : Axis.horizontal,
            itemCount: orders!.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, OrderDetailScreen.routeName,arguments: orders![index]);
                },
                child: Row(
                  children: [
                    SingleProduct(
                  image: orders![index].products[0].images[0]
                  ),
                
         
                  ],
                )
              );
            }),
        )
      ],
    );
  }
}