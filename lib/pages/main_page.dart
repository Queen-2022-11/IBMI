

import 'package:flutter/material.dart';
import 'package:ibmi/pages/history_page.dart';
import 'package:ibmi/pages/ibmi_page.dart';
class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}
class _MainPage extends State<MainPage>{
  final List<Widget> _pages=[IbmiPage(),HistoryPage(),];
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("IBMI", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      bottomNavigationBar: _bottom(),
      body: _pages[currentPage],
     );
  }
  Widget _bottom(){
    print("Building BottomNavigationBar");
    return BottomNavigationBar(currentIndex: currentPage,onTap: (_index){setState(() {
      currentPage=_index;
    });},items: const [BottomNavigationBarItem(label: 'IBMI',icon: Icon(Icons.home)),BottomNavigationBarItem(label: 'History',icon: Icon(Icons.person))],);
  }
}