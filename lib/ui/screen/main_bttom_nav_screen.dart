import 'package:flutter/material.dart';
import 'package:todoproject/ui/screen/cancelled_task_screen.dart';
import 'package:todoproject/ui/screen/completed_task_screen.dart';
import 'package:todoproject/ui/screen/new_task_screen.dart';
import 'package:todoproject/ui/screen/progress_task_screen.dart';

class MainBttomNavScreen extends StatefulWidget {
  const MainBttomNavScreen({super.key});

  @override
  State<MainBttomNavScreen> createState() => _MainBttomNavScreenState();
}

class _MainBttomNavScreenState extends State<MainBttomNavScreen> {
  int _selectedIndex=0;
  final List<Widget>_screens=[
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        onTap: (index){
          _selectedIndex=index;
          setState(() {});
        },
        items:const [
          BottomNavigationBarItem(icon:Icon(Icons.abc_rounded),label: 'New'),
          BottomNavigationBarItem(icon:Icon(Icons.change_circle_outlined),label: 'In progress'),
          BottomNavigationBarItem(icon:Icon(Icons.done_outline_outlined),label: 'Completed'),
          BottomNavigationBarItem(icon:Icon(Icons.close_rounded),label: 'Cancelled'),
        ],
      ),
    );
  }
}
