import 'package:flutter/material.dart';
import 'package:intl/intl.dart';///date time format nia kaj kora jonno pubspec.yaml a add kora lage
void main(){
  runApp( MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title: 'To Do Project',
     home: HomeScreen(),
   );
  }
//
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 // List<DateTime>waterConsumeList=[];
  List<WaterTrack>waterConsumeList=[];
  TextEditingController fild1=TextEditingController();
  int TotalAmount=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water tracker'),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Total Consume',style: Theme.of(context).textTheme.titleLarge),///By deauflt design nia kaj korte pari
            Text('${TotalAmount}',style: Theme.of(context).textTheme.titleLarge,),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: fild1,
                    keyboardType:TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  int amount=int.tryParse(fild1.text.trim())??1;
                  TotalAmount+=amount;
                    WaterTrack waterTrack=WaterTrack(DateTime.now(),amount);
                   waterConsumeList.add(waterTrack);
                   fild1.text='';
                   setState(() {});
                }, child:Text('Add')),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
                child: ListView.builder(
                  itemCount: waterConsumeList.length,
                    //reverse: true,
                    itemBuilder: (context,index){
                     return Card(
                       elevation: 10,
                       child: ListTile(
                         onTap: (){
                           TotalAmount-=waterConsumeList[index].noOfGlass;
                           waterConsumeList.removeAt(index);
                           setState(() {});
                         },
                         ///Date time format nia kaj korar jonno pubspec.yaml a ( intl: ^0.18.1) add kora lage
                        title: Text(DateFormat('HH-mm-s   dd-MM--yyyy').format(waterConsumeList[index].time)),
                         leading: CircleAvatar(
                           child: Text('${index+1}'),
                         ),
                         trailing: Text('${waterConsumeList[index].noOfGlass}'),
                         ),
                      );
                    }
                ),
            ),
          ],
        ),
      ),
    );
  }
}
/// Ekon ami date time er sathe text field teka praptho number of glass o list er moddhe rakte chai
/// List er moddhe date time and no of glass rakte chai ai jonno custome data type nia kaj korte hobe
class WaterTrack{
  final DateTime time;
  final int noOfGlass;
  WaterTrack(this.time, this.noOfGlass);
}