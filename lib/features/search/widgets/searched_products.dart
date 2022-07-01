import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/stars.dart';
import 'package:flutterbackend/models/product.dart';

class SearchProduct extends StatelessWidget {
  final Product product;
  const SearchProduct({ Key? key ,required this.product }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     double totalRating = 0;
    for(int i=0;i<product.rating!.length;i++){
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0;
    if(totalRating!=0){
      avgRating = totalRating/product.rating!.length ;
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(product.images[0],fit: BoxFit.contain,height: 135,width: 135,),
              Column(
                children: [
                  Container(
                    width: 205,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(product.name,style: TextStyle(fontSize: 16),maxLines: 2,),
                  ),
                   Container(
                    width: 205,
                    padding: EdgeInsets.only(left: 10,top: 5),
                    child: Stars(rating: avgRating),
                  ),
                    Container(
                    width: 205,
                    padding: EdgeInsets.only(left: 10,top: 5),
                    child: Text('\$${product.price}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 2,),
                  ),
                   Container(
                    width: 205,
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Eligible for FREE Shipping',)
                  ),
                     Container(
                    width: 205,
                    padding: EdgeInsets.only(left: 10,top: 5),
                    child: Text('In Stock',style: TextStyle(color: Colors.teal),maxLines: 2,)
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}