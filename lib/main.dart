import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/product_list_screen.dart';

void main(){
  runApp(const CrudApp());
}

class CrudApp extends StatelessWidget{
  const CrudApp();

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home:ProductListScreen(),
   );
  }
}

