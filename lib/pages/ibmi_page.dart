import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/widgets/info_page.dart'; // Assuming InfoCard is defined or imported correctly

class IbmiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IbmiPage();
  }
}

class _IbmiPage extends State<IbmiPage> {
   double? _deviceHeight, _deviceWidth; 
   int _age=25,_weight=60;// Use late to indicate that these variables will be initialized before use
   int _height=70, _gender=0;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          height: _deviceHeight! * 0.8, // Adjust the height to leave some space for AppBar
          child: SingleChildScrollView(
            child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  mainAxisSize: MainAxisSize.max,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ageselector(),
        _weightselector(),
      ],
    ),
    SizedBox(height: 20), // Add space between _weightselector and _heightSelector
    _heightSelector(),
    SizedBox(height: 25), // Add space between _heightSelector and _genderSelector
    _genderSelector(),
    SizedBox(height: 60), // Add space between _genderSelector and _calculateBMI
    _calculateBMI(),
  ],
),

        ),
            ),
      ));
  }

  Widget _ageselector() {

    return InfoCard(
      height: _deviceHeight! * 0.20,
      width: _deviceWidth! * 0.45,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Age",
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Text(
            _age.toString(),
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
          ),
          Row(  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 50,child: FloatingActionButton(backgroundColor: Colors.white,onPressed: () {
           setState(() {
             _age--;
           }); 
          },child: const Text("-",style: TextStyle(fontSize: 25,color: Colors.red),),),),
          SizedBox(width: 50,child: FloatingActionButton(backgroundColor: Colors.white,onPressed: () {
             setState(() {
             _age++;
           }); 
          },child: const Text("+",style: TextStyle(fontSize: 25,color: Colors.blue),),),)
        ],)
        ],
      ),
    );
  }
  Widget _weightselector() {

    return InfoCard(
      height: _deviceHeight! * 0.20,
      width: _deviceWidth! * 0.45,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Weight in Kg",
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Text(
            _weight.toString(),
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
          ),
          Row(  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 50,child: FloatingActionButton(backgroundColor: Colors.white,onPressed: () {
           setState(() {
             _weight--;
           }); 
          },child: const Text("-",style: TextStyle(fontSize: 25,color: Colors.red),),),),
          SizedBox(width: 50,child: FloatingActionButton(backgroundColor: Colors.white,onPressed: () {
             setState(() {
              _weight++;
           }); 
          },child: const Text("+",style: TextStyle(fontSize: 25,color: Colors.blue),),),)
        ],)
        ],
      ),
    );
  }
Widget _heightSelector() {
    return InfoCard(
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Height in cm",
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Text(
            _height.toString(),
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
          ),
           Slider(
            value: _height.toDouble(),
            onChanged: (value) {
              setState(() {
                _height = value.toInt();
              });
            },
            min: 50,
            max: 250,
          )
        ],
      ),
    );
  }
    Widget _genderSelector() {
    return InfoCard(
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Gender",
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
          ),
          _buildGenderSelector(),
        ],
      ),
    );
  }
  Widget _buildGenderSelector() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ChoiceChip(
            label: const Text("Male"),
            selected: _gender == 0,
            onSelected: (selected) {
              setState(() {
                _gender = selected ? 0 : _gender;
              });
            },
          ),
          ChoiceChip(
            label: const Text("Female"),
            selected: _gender == 1,
            onSelected: (selected) {
              setState(() {
                _gender = selected ? 1 : _gender;
              });
            },
          ),
        ],
      );
    }
  Widget _calculateBMI() {
  return Container(
    height: _deviceHeight! * 0.07,
    child: ElevatedButton(
      onPressed: () {
        if (_height > 0 && _weight > 0 && _age > 0) {
          double _bmi = (_weight / pow(_height / 100, 2)); //Formula
          print(_bmi);
          showResult(_bmi);
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Set the background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set the border radius
        ),
      ),
      child: const Text("Calculate BMI",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
    ),
  );
}
 void showResult(double _bmi) {
  String? _status;
  if (_bmi < 18.5) {
    _status = "Underweight";
  } else if (_bmi >= 18.5 && _bmi < 25) {
    _status = "Normal";
  } else if (_bmi >= 25 && _bmi < 30) {
    _status = "Overweight";
  } else if (_bmi >= 30) {
    _status = "Obese";
  }

  showDialog(
    context: context,
    builder: (BuildContext _context) {
      return AlertDialog(
        title: Text(_status!),
        content: Text(_bmi.toStringAsFixed(2)),
        actions: [
          TextButton(
            onPressed: () {
              _saveResult(_bmi.toString(), _status!);
              Navigator.pop(_context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
 void _saveResult(String _bmi, String _status) async {
   final preps = await SharedPreferences.getInstance();
   await preps.setString('bmi_date', DateTime.now().toString(),);
   await preps.setStringList('bmi_data', <String>[_bmi,_status]);
   print("Save");
 }

  }


