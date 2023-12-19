import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/widgets/info_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget{
   double? _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

     return Scaffold(
      body:_datacard(),
     );
  }
 Widget _datacard() {
  return FutureBuilder(
    future: SharedPreferences.getInstance(),
    builder: (BuildContext _context, AsyncSnapshot _snapshot) {
      if (_snapshot.connectionState == ConnectionState.done && _snapshot.hasData) {
        final preps = _snapshot.data as SharedPreferences;
        final _date = preps.getString('bmi_date');
        final _data = preps.getStringList('bmi_data');

        return Center(
          child: InfoCard(
            height: _deviceHeight! * 0.25,
            width: _deviceWidth! * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _statustext(_data?[1] ?? "No data"), // Use null-aware operator
                _datetext(_date ?? "No date"), // Use null-aware operator
                _bmitext(_data?[0] ?? "No data"),
              ],
            ),
          ),
        );
      } else if (_snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(color: Colors.red),
        );
      } else {
        return Center(
          child: Text("Error loading data"), // Handle error state
        );
      }
    },
  );
}

  Widget _statustext(String _status){
    return Text(_status,style:const TextStyle(fontSize: 25,fontWeight: FontWeight.w500),);
  }
   Widget _datetext(String _date){
    DateTime _parsedDate =DateTime.parse(_date);
    return Text('${_parsedDate.day} / ${_parsedDate.month} / ${_parsedDate.year}',style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w300),);
  }
  Widget _bmitext(String _bmi){
    return Text(double.parse(_bmi).toStringAsFixed(2),style:const TextStyle(fontSize: 60,fontWeight: FontWeight.w700),);
  }
}
