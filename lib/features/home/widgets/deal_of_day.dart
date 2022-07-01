import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/loader.dart';
import 'package:flutterbackend/features/home/services/home_service.dart';
import 'package:flutterbackend/features/product_details/screens/product_detail_screen.dart';
import 'package:flutterbackend/models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({ Key? key }) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeService homeService = HomeService();
  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay()async{
    product = await homeService.fetchDealOfDay(context: context);
    setState(() {
      
    });
  }

  void navigateToDetailScreen(){
    Navigator.pushNamed(context,ProductDetailScreen.routeName,arguments: product);
  }
  @override
  Widget build(BuildContext context) {
    return product==null?
    Loader()
    :
    product!.name.isEmpty?
    SizedBox()
    :
    GestureDetector(
      onTap: navigateToDetailScreen,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 10,top: 15),
            child: Text("Deal of the day",style: TextStyle(fontSize: 20),),
          ),
          Image.network(product!.images[0],
          height: 235,
          fit: BoxFit.fitHeight,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 15),
            child: Text(
              '\$100',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 15,top: 5,right: 40),
            child: Text(
              'KTYH',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: product!.images.map((e) => Image.network(e,fit: BoxFit.fitWidth,width: 100,height: 100,),).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 15,top: 15,right: 15
            ),
            alignment: Alignment.topLeft,
            child: Text('See all deals',
            style: TextStyle(color: Colors.cyan[800]),
            ),
          )
        ],
      ),
    );
  }
}