import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterbackend/common/widgets/custom_button.dart';
import 'package:flutterbackend/common/widgets/stars.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/features/product_details/services/product_details_service.dart';
import 'package:flutterbackend/features/search/screens/search_screen.dart';
import 'package:flutterbackend/models/product.dart';
import 'package:flutterbackend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  // static const String routeName = '/product-details';
  final Product product;
  const ProductDetailScreen({ Key? key ,required this.product }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final ProductDetailService productDetailService = ProductDetailService();

  double avgRating = 0;
  double myRating = 0;
  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for(int i=0;i<widget.product.rating!.length;i++){
      totalRating += widget.product.rating![i].rating;
      if(widget.product.rating![i].userId == Provider.of<UserProvider>(context,listen: false).user.id){
        myRating = widget.product.rating![i].rating;
      }
    }

    if(totalRating!=0){
      avgRating = totalRating/widget.product.rating!.length ;
    }
  }
    void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  void addToCart(){
    productDetailService.addToCart(context: context, product: widget.product);
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
       body: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(widget.product.id!),
                   Stars(rating: avgRating)
                 ],
               ),
             ),
             Padding(
               padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
               child: Text(widget.product.name,style: TextStyle(fontSize: 15),),
               ),
            CarouselSlider(
              items: widget.product.images.map((i) {
                return Builder(
                  builder: (BuildContext context)=>Image.network(
                    i,
                    fit: BoxFit.contain,
                    height: 200,
                  ));
              }).toList(), 
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300
              )
              ),
              Container(color: Colors.black12,height: 5,),
              Padding(padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(text: 'Deal Price: ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),
                children: [
                  TextSpan(text: '\$${widget.product.price}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.red))
                ]
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.product.description),
              ),
             Container(color: Colors.black12,height: 5,),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: CustomButton(text: 'Buy Now', onTap: (){}),
             ),
             SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: CustomButton(text: 'Add to Cart', 
               onTap: addToCart,
               color: Color.fromRGBO(254, 216, 19, 1),
               ),
             ),
             SizedBox(height: 10,),
             Container(color: Colors.black12,height: 5,),
             Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Rate The Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
              RatingBar.builder(
                initialRating: myRating,
                maxRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context,_)=>Icon(Icons.star,color: GlobalVariables.secondaryColor,), 
                onRatingUpdate: (rating){
                  productDetailService.rateProduct(
                    context: context, 
                    product: widget.product, 
                    rating: rating);
                }
                ),
                SizedBox(height: 20,),
           ],
         ),
       ),
    );
  }
}