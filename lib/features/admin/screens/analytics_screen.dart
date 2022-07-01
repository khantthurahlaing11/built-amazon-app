
import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/loader.dart';
import 'package:flutterbackend/features/admin/models/sale.dart';
import 'package:flutterbackend/features/admin/services/admin_service.dart';
import 'package:flutterbackend/features/admin/widgets/category_product_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({ Key? key }) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService adminService = AdminService();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings()async{
   var earningData =  await adminService.getEarnings(context);
   totalSales = earningData['totalEarnings'];
   earnings = earningData['sales'];
   setState(() {
     
   });
  }
  @override
  Widget build(BuildContext context) {
    return earnings==null || totalSales==null? Loader() : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text('\$$totalSales',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(
            height: 250,
            child: CategoryProductChart(seriesList: [
              charts.Series(id: 'Sales', data: earnings!, domainFn: (Sales sales,_)=>sales.label, measureFn: (Sales sales,_)=>sales.earnings)
            ]),
          )
        ],
      ),
    );
  }
}