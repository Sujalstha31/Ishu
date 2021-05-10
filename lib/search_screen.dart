import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qifyadmin/user_tile.dart';
import 'package:qifyadmin/view_windows.dart';
import 'package:qifyadmin/models/doctorsList.dart';
import 'current_user.dart';

String currentText = "";

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String placeholderText = 'Start connecting with doctors now!';
  bool searchState = false;

  Color c1 = Colors.grey;
  Color c2 = Colors.grey;
  Color activeC = Colors.pink;
  Color inactiveC = Colors.grey;

  String speciality = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0
          ,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: Consumer<CurrentUser>(
          builder: (context, userData, child) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                   
                  Padding(
                    padding: EdgeInsets.only(top: 4, left: 4, right: 4),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        prefixStyle: TextStyle(color: Color(0xFF0A0E21)),
                        contentPadding: EdgeInsets.only(
                          top: 14.0,
                        ),
                        border: OutlineInputBorder(
                            //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF0A0E21), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF0A0E21), width: 2.0),
                        ),
                      ),
                      onChanged: (value) {
                        placeholderText = 'No doctor found!';
                        setState(() {
                          currentText = value.toLowerCase();
                          if (!searchState) {
                            searchState = true;
                          } else if (value == "") {
                            searchState = false;
                          }
                        });
                      },
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: !['', null].contains(currentText) ? Firestore.instance
                            .collection('users')
                        .where('isDoctor', isEqualTo: true)
                        .where('indexList', arrayContains: currentText)
                            .snapshots()
                        : Firestore.instance.collection('users')
                        .where('isDoctor', isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.data.documents.length == 0) {
                        return Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                                  '$placeholderText',
                                  style: TextStyle(fontSize: 16),
                                ),
                        );
                      }
                      final users = snapshot.data.documents;
                      List<UserTile> userList = [];
                      for (var user in users) {
                        final userName = user.data['displayName'];
                        final photoUrl = user.data['profile'];
                        final speical = user.data['speciality'];
                        final uid = user.documentID.toString();


                            userList.add(
                              UserTile(
                                photoUrl: photoUrl,
                                userName: userName,
                                special: speical,
                                onPress: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return ViewWindows(
                                          name: userName,
                                          uid: uid,
                                          des: speical,
                                        );
                                      }));
                                },
                              ),
                            );


                      }
                      return Expanded(
                        child: userList.length != 0
                            ? ListView(
                                children: userList,
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('No results found for $speciality'),
                              ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
