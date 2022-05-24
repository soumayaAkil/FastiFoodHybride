




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime _dateTime = DateTime(2022,12,05);
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  @override
  Widget build(BuildContext context)
  { double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
    final hours = time.hour.toString().padLeft(2,'0');
    final minutes = time.minute.toString().padLeft(2,'0');
    return Scaffold(
        body: Center(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_dateTime == null ? 'nothing has picked yet ' : '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}'),//_dateTime.toString()
                RaisedButton(
                  child:
                  Text('pick a date'),
                  onPressed: () async{
                    DateTime newDate= await showDatePicker(
                        context: context,
                        initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2023));

                    // if cancel
                    if(newDate == null) return;
                    // if ok
                    setState(() =>
                    _dateTime = newDate
                    );

                  },
                ),
                Text('$hours:$minutes'),
                RaisedButton(
                  child:
                  Text('pick time '),
                  onPressed: () async{
                    TimeOfDay newTime = await showTimePicker(
                        context: context,
                        initialTime: time
                    );
                    // if cancel => null
                    if(newTime == null) return;
                    // if ok timeofday
                    setState(() =>
                    time = newTime
                    );
                  },
                ),
             SizedBox(

              height: 150,),
                Positioned(
                  bottom: 15,
                  left: 110,
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 150,

                        child: RaisedButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),


                        child:Text(
                          ' Valider',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),

                        ),
                      ),
                    ),
                    ),

                ),

              ],
            )
        ));
  }
}
