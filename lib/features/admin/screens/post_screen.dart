import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/loader.dart';
import 'package:flutterbackend/features/account/widgets/single_product.dart';
import 'package:flutterbackend/features/admin/screens/add_product_screen.dart';
import 'package:flutterbackend/features/admin/services/admin_service.dart';
import 'package:flutterbackend/models/product.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({ Key? key }) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Product>? products;
  final AdminService adminService = AdminService();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts()async{
   products = await adminService.fetchAllProduct(context);
   setState(() {
     
   });
  }

  void deleteProduct(Product product,int index){
    adminService.deleteProduct(
      context: context, 
      product: product, 
      onSuccess: (){
        products!.removeAt(index);
        setState(() {
          
        });
      });
  }

  void navigateToAddProduct(){
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    return 
    products == null?
    Loader()
    :
    Scaffold(
      body: GridView.builder(
        itemCount: products!.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
        
        itemBuilder: (context,index){
          final productData = products![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                
                children: [
                  
                  SizedBox(
                    width: 200,
                    height: 115,
                    child: SingleProduct(
                      image: productData.images[0]),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        
                        Expanded(
                          
                          child: Text( productData.name,overflow: TextOverflow.ellipsis,maxLines: 2,)
                          ),
                        IconButton(onPressed: ()=>deleteProduct(productData, index), icon: Icon(Icons.delete_outline))
                      ],
                    ),
                  ),
                ],
              ),
            );
          
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}