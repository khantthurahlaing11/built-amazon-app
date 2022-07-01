import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/loader.dart';
import 'package:flutterbackend/features/account/widgets/single_product.dart';
import 'package:flutterbackend/features/admin/services/admin_service.dart';
import 'package:flutterbackend/features/orders/screens/order_detail_screen.dart';
import 'package:flutterbackend/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({ Key? key }) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminService adminService = AdminService();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders()async{
    orders = await adminService.fetchAllOrders(context);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return orders==null? Loader() : GridView.builder(
      itemCount: orders!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ), 
      itemBuilder: (context,index){
        final orderData = orders![index];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, OrderDetailScreen.routeName,arguments: orderData);
          },
          child: SizedBox(
            height: 140,
            child: SingleProduct(image: orderData.products[0].images[0]),
          ),
        );
      });
  }
}