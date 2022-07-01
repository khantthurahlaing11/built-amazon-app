

import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/custom_button.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/features/admin/services/admin_service.dart';
import 'package:flutterbackend/features/search/screens/search_screen.dart';
import 'package:flutterbackend/models/order.dart';
import 'package:flutterbackend/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({ Key? key,required this.order }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminService adminService = AdminService();
  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }
  //Only for Admin
  void changeOrderStatus(int status){
    adminService.changeOrderStatus(context: context, status: status+1, order: widget.order, onSuccess: (){
      setState(() {
        currentStep += 1;
      });
    });
  }
    void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("View order details",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Date:        ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderAt))}'),
                      Text('Order ID:            ${widget.order.id}'),
                      Text('Order Total:       \$${widget.order.totalPrice}')
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Text("Purchase Details",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                Container(
  
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     for (int i = 0; i < widget.order.products.length; i++) 
                     Row(
                       children: [
                         Image.network(widget.order.products[i].images[0],width: 120,height: 120,),
                          SizedBox(width: 5,),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.order.products[i].name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                              Text('Qty: ${widget.order.quantity[i]}'),
                            ],
                          ))
                       ],
                     )
                    ]
                  ),
                ),
                 SizedBox(height: 10,),
                Text("Tracking",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                     
                  Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12)
                  ),
                  child: Stepper(
                    controlsBuilder: (context,details){
                      if(user.type == 'admin'){
                        return CustomButton(text: 'Done', onTap: ()=>changeOrderStatus(details.currentStep));
                      }
                      return SizedBox();
                    },
                    currentStep: currentStep,
                    steps: [
                      Step(title: Text('Pending'), content: Text('Your order is yet to be delivered'),
                      isActive: currentStep> 0,
                      state: currentStep > 0 ? StepState.complete : StepState.indexed
                      ),
                      Step(title: Text('Completed'), content: Text('Your order has been delivered, you are yet to sign.'),
                      isActive: currentStep> 1,
                      state: currentStep > 1 ? StepState.complete : StepState.indexed
                      ),
                      Step(title: Text('Received'), content: Text('Your order has been delivered and signed by you.'),
                      isActive: currentStep> 2,
                      state: currentStep > 2 ? StepState.complete : StepState.indexed
                      ),
                      Step(title: Text('Delivered'), content: Text('Your order has been delivered and signed by you!'),
                      isActive: currentStep>= 3,
                      state: currentStep >= 3 ? StepState.complete : StepState.indexed
                      ),
                    ]
                    )
                ),
              ],
            ),
          ),
        ),
    );
  }
}