import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/custom_button.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/features/address/screen/address_screen.dart';
import 'package:flutterbackend/features/cart/widgets/cart_product.dart';
import 'package:flutterbackend/features/cart/widgets/cart_subtotal.dart';
import 'package:flutterbackend/features/home/widgets/address_box.dart';
import 'package:flutterbackend/features/search/screens/search_screen.dart';
import 'package:flutterbackend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({ Key? key }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

    void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

     void navigateToAddressScreen(int sum){
    Navigator.pushNamed(context, AddressScreen.routeName,arguments: sum.toString());
  }
  @override
  Widget build(BuildContext context) {
     final user = Provider.of<UserProvider>(context).user;
      int sum = 0;
    user.cart.map((e) => sum+= e['quantity']*e['product']['price'] as int).toList();
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
           children: [
             AddressBox(),
             CartSubtotal(),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: CustomButton(text: 'Proceed to Buy (${user.cart.length} items)', 
               onTap: ()=>navigateToAddressScreen(sum),
               color: Colors.yellow[600],
               ),
             ),
             SizedBox(height: 5,),
             Container(
               color: Colors.black12.withOpacity(0.08),
               height: 1,
             ),
             SizedBox(height: 5,),
             ListView.builder(
               scrollDirection: Axis.vertical,
               shrinkWrap: true,
               itemCount: user.cart.length,
               itemBuilder: (context,index){
                 return CartProduct(index: index);
               })
           ],
         ),
       ),
    );
  }
}