import 'package:flutter/material.dart';
import 'package:flutterbackend/common/widgets/custom_button.dart';
import 'package:flutterbackend/common/widgets/custom_textfield.dart';
import 'package:flutterbackend/constants/global_variables.dart';
import 'package:flutterbackend/constants/utils.dart';
import 'package:flutterbackend/features/address/services/address_service.dart';
import 'package:flutterbackend/providers/user_provider.dart';

import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({ Key? key,required this.totalAmount }) : super(key: key);
  

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = "";
  // List<PaymentItem> paymentItems = [];
  final AddressService addressService = AddressService();
  @override
  // void initState() {
  //   super.initState();
  //   paymentItems.add(PaymentItem(amount: widget.totalAmount,label: 'Total Amount',status: PaymentItemStatus.final_price
  //   ));
  // }
  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }
  // void onGooglePayResult(res){
  //   if(Provider.of<UserProvider>(context,listen: false).user.address.isEmpty){
  //     addressService.saveUserAddress(context: context, address: addressToBeUsed);
  //     addressService.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
  //   }
  // }

  void payPressed(String addressFromProvider){
    addressToBeUsed = "";
    bool isForm = flatBuildingController.text.isNotEmpty ||
                   areaController.text.isNotEmpty ||
                   pincodeController.text.isNotEmpty ||
                   cityController.text.isNotEmpty;
    if(isForm){
      if(_addressFormKey.currentState!.validate()){
        addressToBeUsed = '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
     
      }else{
        throw Exception('Please enter all the values!');
      }

    if(Provider.of<UserProvider>(context,listen: false).user.address.isEmpty){
      addressService.saveUserAddress(context: context, address: addressToBeUsed);
      addressService.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
    }else{
      addressService.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
    }

    
    }else if(addressFromProvider.isNotEmpty){
      addressToBeUsed = addressFromProvider;
    }else{
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = Provider.of<UserProvider>(context).user.address;
    return Scaffold(
         appBar: PreferredSize(
        preferredSize: Size.fromHeight(57),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if(address.isNotEmpty)
              Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(address,style: TextStyle(fontSize: 18),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('OR',style: TextStyle(fontSize: 18),),
                  SizedBox(height: 20,),
                ],
              ),
              Form(
                        key: _addressFormKey,
                        child: Column(
                          children: [    
                            CustomTextField(controller: flatBuildingController,hintText: "Flat, House no, Building",),
                            SizedBox(height: 10,),
                            CustomTextField(controller: areaController,hintText: "Area, Street",),
                            SizedBox(height: 10,),
                            CustomTextField(controller: pincodeController,hintText: "Pincode",),
                            SizedBox(height: 10,),
                            CustomTextField(controller: cityController,hintText: "Town/City",),
                            SizedBox(height: 10,),
                                       
                          ],
                        )
                        ),
                        SizedBox(height: 10,),
                        CustomButton(text: 'Buy Now', onTap: ()=>payPressed(address)
                        ,color: Colors.yellow[600],
                        ),

            ],
          ),
        ),
      ),
    );
  }
}