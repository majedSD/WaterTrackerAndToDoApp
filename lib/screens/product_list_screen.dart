import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todoproject/screens/add_new_product_screen.dart';
import 'package:todoproject/widgets/product_item.dart';
class ProductListScreen extends StatefulWidget{
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product>productList=[];
  bool inProgress=false;
  void initState(){
    getProducts();
    super.initState();
  }

  void getProducts()async{
    inProgress=true;
    productList.clear();
    setState(() {
    });
    Response response=await get(Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct"));
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
     final Map<String,dynamic> responsData=jsonDecode(response.body);
     if(responsData['status']=='success'){
       for(Map<String,dynamic>productJson in responsData['data']){
         productList.add(Product(
                 productJson['_id'],
                 productJson['ProductName']??' ',
                 productJson['ProductCode']??' ',
                 productJson['Img']??' ',
                 productJson['UnitPrice']??' ',
                 productJson['Qty']??' ',
                 productJson['TotalPrice']??' '
            ),
         );
       }
     }
    }
    inProgress =false;
    setState(() {
    });
  }
  void deletProducts(String ProductId)async{
    inProgress=true;
    productList.clear();
    setState(() {
    });
    Response response=await get(Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/${ProductId}"));
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
     getProducts();
    }
    else {
      inProgress = false;
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Product List'),
      actions: [
      IconButton(onPressed:(){
        getProducts();
      }, icon:Icon(Icons.refresh) ),
      ],
    ),
    body:inProgress?const Center(
      child: CircularProgressIndicator(),
    ):ListView.separated(
        itemCount:productList.length,
      separatorBuilder:(context,index)=>Divider(),
      itemBuilder:(context,index)=>ProductItem(product:productList[index], onPressedDelet: (String ProductId) {
        deletProducts(ProductId);
      },),
    ),
    floatingActionButton:FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,MaterialPageRoute(builder:(context){
              return AddNewProductScreen();
        }
        )
        );
      },
      child: Icon(Icons.add),
    )
  );
  }
}
class Product{
  final String id;
  final String productName;
  final String productCode;
  final String image;
  final String unitPrice;
  final String quantiy;
  final String totalPrice;

  Product(this.id, this.productName, this.productCode, this.image, this.unitPrice, this.quantiy, this.totalPrice);
}