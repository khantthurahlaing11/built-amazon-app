
import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/loader.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/features/home/widgets/address_box.dart';
import 'package:flutterbackend/features/product_details/screens/product_detail_screen.dart';
import 'package:flutterbackend/features/search/services/search_service.dart';
import 'package:flutterbackend/features/search/widgets/searched_products.dart';
import 'package:flutterbackend/models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({ Key? key,required this.searchQuery }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchService searchService = SearchService();
  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }
  fetchSearchedProduct()async{
    products = await searchService.fetchSearchedProduct(
      context: context, 
      searchQuery: widget.searchQuery);
      setState(() {
        
      });
  }
   void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
        preferredSize: Size.fromHeight(57),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: (){},
                          child: Padding(padding: EdgeInsets.only(left: 6),
                          child: Icon(Icons.search,
                          color: Colors.black,
                          size: 23,
                          ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(color: Colors.black38,width: 1)
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                        )
                      ),
                    ),
                  )
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.mic,color: Colors.black,size: 25,),
              )
            ],
          ),

        ),
      ),
      body: products==null?
         Loader()
         :
         Column(
           children: [
             AddressBox(),
             SizedBox(height: 10,),
             Expanded(child: ListView.builder(
               itemCount: products!.length,
               itemBuilder: (context,index){
                 return GestureDetector(
                   onTap: (){
                     Navigator.pushNamed(context,ProductDetailScreen.routeName,
                     arguments: products![index]
                     );
                   },
                   child: SearchProduct(product: products![index]));
               }
               )
               )
           ],
         ),
    );
  }
}