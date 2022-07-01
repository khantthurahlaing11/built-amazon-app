import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutterbackend/features/admin/models/sale.dart';

class CategoryProductChart extends StatelessWidget {
  final List<charts.Series<Sales,String>> seriesList;
  const CategoryProductChart({ Key? key,required this.seriesList }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(seriesList,animate: true,);
  }
}