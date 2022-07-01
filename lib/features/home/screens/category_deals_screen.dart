import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/loader.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/features/home/services/home_service.dart';
import 'package:flutterbackend/features/product_details/screens/product_detail_screen.dart';
import 'package:flutterbackend/models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({ Key? key,required this.category }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeService homeService = HomeService();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts()async{
    productList = await homeService.fetchCategoryProducts(context: context, category: widget.category);
    setState(() {
      
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
          centerTitle: true,
          title: Text(widget.category,style: TextStyle(color: Colors.black),),
        ),
      ),
      body: productList==null?
        Loader()
        :
       Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            alignment: Alignment.topLeft,
            child: Text('Keep shoping for ${widget.category}',style: TextStyle(fontSize: 20),),
          ),
          SizedBox(height: 10,),
          SizedBox(
            height: 200,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              // padding: EdgeInsets.only(left: 15),
              itemCount: productList!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
  
              ), 
              itemBuilder: (context,index){
                final product = productList![index];
                return GestureDetector(
                  onTap: (){
                    // Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetailScreen(product: product)));
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 135,
                      width: 160,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12,width: 0.5)
                        ),
                        child: Padding(padding: EdgeInsets.all(10),
                        child: Image.network(product.images[0]),
                        ),
                      ),
                      ),
                      SizedBox(height: 4,),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 18,top: 5,right: 15),
                        child: Text(product.name,maxLines: 3,overflow: TextOverflow.visible,),
                      )
                    ],
                  ),
                );
              }),
          )
        ],
      ),
    );
  }
}