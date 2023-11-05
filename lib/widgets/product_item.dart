import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoproject/screens/add_new_product_screen.dart';
import 'package:todoproject/screens/product_list_screen.dart';

class ProductItem extends StatelessWidget{
  const ProductItem({super.key, required this. product, required this.onPressedDelet});
 final Product product;
 final Function(String) onPressedDelet;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///todo ExpansionTile----work same as listtyle and it work with butto and given some description must be children
        ///Expansiontile er description childrean er bitore dewa lage
        ListTile(
          onTap: (){
            showDialog(
                context: context, builder: (context){
              return ProductActionDialoge(context);
            }
            );
          },
          title:Text(product.productName),
          subtitle:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
                  Text(product.productCode),
                  Text(product.totalPrice),
                  Text(product.quantiy)
            ],
          ),
          trailing: Text('\$${product.unitPrice}'),
          leading:Image.network(
            product.image,
              ),
        ),
      ],
    );
  }

  AlertDialog ProductActionDialoge(context) {
    return AlertDialog(
      title:Text('Selection'),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Edit'),
            leading: Icon(Icons.edit_outlined),
            onTap:(){
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(
                builder: (context)=>AddNewProductScreen(product: product),
              ),
              );
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile( title: Text('Delet'),
            leading: Icon(Icons.delete),
            onTap: (){
              Navigator.pop(context);
              onPressedDelet(product.id);
            },
          ),
        ],
      ),
    );
  }

}