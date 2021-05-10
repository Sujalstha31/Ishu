import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qifyadmin/search_screen.dart';
//import 'package:health_and_doctor_appointment/firestore-data/searchList.dart';

class DoctorsList extends StatefulWidget {
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  TextEditingController _textController = new TextEditingController();
  String search;
  var _length = 0;

  @override
  void initState() {
    super.initState();
    search = _textController.text;
    _length = search.length;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        //child: _length == 0
        //?
          child: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                          
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(
                                          
                                        )
                      ));
                          // setState(() {
                          //   _length = 1;
                          // }
                          // );
                        },
                        child: Text(
                          'Show All Doctors',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image(image: AssetImage('assets/search-bg.png')),
                    ],
                  ),
                ),
              )

      ),
    );
  }
}
