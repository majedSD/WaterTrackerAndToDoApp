import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todoproject/screens/product_list_screen.dart';

class AddNewProductScreen extends StatefulWidget{
  final Product ?product;
  const AddNewProductScreen({super.key,this.product});

  @override
  State<StatefulWidget> createState() {
   return AddNewProductScreenState();
  }

}

class AddNewProductScreenState extends State<AddNewProductScreen> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  bool addInprogress=false;
  final TextEditingController tittleTEcontroller=TextEditingController();
  final TextEditingController productCodeTEcontroller=TextEditingController();
  final TextEditingController imageTEcontroller=TextEditingController();
  final TextEditingController quantityTEcontroller=TextEditingController();
  final TextEditingController priceTEcontroller=TextEditingController();
  final TextEditingController totalpriceTEcontroller=TextEditingController();
  final TextEditingController descriptionTEcontroller=TextEditingController();
  Future<void> addNewProducts()async{
    addInprogress=true;
    setState(() {
    });
    final Map<String,String>inputMap={
      "Img":imageTEcontroller.text.trim(),
      "ProductCode":productCodeTEcontroller.text.trim(),
      "ProductName":tittleTEcontroller.text.trim(),
      "Qty":quantityTEcontroller.text.trim(),
      "TotalPrice":totalpriceTEcontroller.text.trim(),
      "UnitPrice":priceTEcontroller.text.trim(),
    };
    print(inputMap);
   final Response response=await post(
       Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
       headers: {
         'Content-Type' : 'application/json',
       },
       body:jsonEncode(inputMap),
   );
   print(response.statusCode);
   if(response.statusCode==200){
     tittleTEcontroller.clear();
     productCodeTEcontroller.clear();
     imageTEcontroller.clear();
     quantityTEcontroller.clear();
     priceTEcontroller.clear();
     totalpriceTEcontroller.clear();
     descriptionTEcontroller.clear();
   }
   addInprogress=false;
   setState(() {
   });
  }
  Future<void> updateNewProducts()async{
    addInprogress=true;
    setState(() {
    });
    final Map<String,String>inputMap={
      "Img":imageTEcontroller.text.trim(),
      "ProductCode":productCodeTEcontroller.text.trim(),
      "ProductName":tittleTEcontroller.text.trim(),
      "Qty":quantityTEcontroller.text.trim(),
      "TotalPrice":totalpriceTEcontroller.text.trim(),
      "UnitPrice":priceTEcontroller.text.trim(),
    };
    print(inputMap);
    final Response response=await post(
      Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product!.id}'),
      headers: {
        'Content-Type' : 'application/json',
      },
      body:jsonEncode(inputMap),
    );
    print(response.statusCode);
    if(response.statusCode==200){
      tittleTEcontroller.clear();
      productCodeTEcontroller.clear();
      imageTEcontroller.clear();
      quantityTEcontroller.clear();
      priceTEcontroller.clear();
      totalpriceTEcontroller.clear();
      descriptionTEcontroller.clear();
    }
    addInprogress=false;
    setState(() {
    });
  }
  @override
  void initState() {
   if(widget.product!=null){
       tittleTEcontroller.text=widget.product!.productName;
       productCodeTEcontroller.text=widget.product!.productCode;
       imageTEcontroller.text=widget.product!.image;
       quantityTEcontroller.text=widget.product!.quantiy;
       priceTEcontroller.text=widget.product!.unitPrice;
       totalpriceTEcontroller.text=widget.product!.totalPrice;
   }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
           child:Form(
             key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tittleTEcontroller,
                decoration: InputDecoration(
                  label: Text('Tittle'),
                  hintText: 'Enter the tittle',
                ),
                validator: isValidate,
              ),
              TextFormField(
                controller: productCodeTEcontroller,
                decoration: InputDecoration(
                    label: Text('Product code'),
                    hintText: 'Enter the product code'
                ),
                validator: isValidate,
              ),
              TextFormField(
                controller: imageTEcontroller,
                decoration: InputDecoration(
                    label: Text('Image'),
                    hintText: 'Enter your image'
                ),
                validator: isValidate,
              ),
              TextFormField(
                controller: quantityTEcontroller,
                decoration: InputDecoration(
                  label: Text('Quantity'),
                  hintText: 'Enter the quantity',
                ),
                validator: isValidate,
              ),
              TextFormField(
                controller: priceTEcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: Text('Price'),
                    hintText: 'Enter the price'
                ),
                validator: isValidate,
              ),
              TextFormField(
                controller: totalpriceTEcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: Text('Total Price'),
                    hintText: 'Enter the total price',
                ),
                validator: isValidate,
              ),
              TextFormField(
                maxLines: 3,
                controller: descriptionTEcontroller,
                decoration: InputDecoration(
                  label: Text('Description'),
                  hintText: 'Write your description',
                ),
                validator: isValidate,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child:addInprogress?Center(child: CircularProgressIndicator(),) :ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        if(widget.product!=null){
                          updateNewProducts();
                        }
                        else{
                          addNewProducts();
                        }
                      }
                    }, child:widget.product!=null?Text('Update'):Text('Add'),
               style: ElevatedButton.styleFrom(
                 textStyle:TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                     ),
                   ),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
 String? isValidate(String? value){
     if(value?.trim().isNotEmpty ?? false){
       return null;
     }
     return 'Enter a valid value';
  }
  ///Dispose use because here five text editing controller.we can take huge number of data this data take huge number of memory.
  ///dispose method clearing this memory
  void dispose(){
    tittleTEcontroller.dispose();
    imageTEcontroller.dispose();
    totalpriceTEcontroller.dispose();
    productCodeTEcontroller.dispose();
    quantityTEcontroller.dispose();
    priceTEcontroller.dispose();
    descriptionTEcontroller.dispose();
    super.dispose();
  }
}