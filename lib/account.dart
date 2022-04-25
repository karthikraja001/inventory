// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({ Key? key }) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  void initState() {
    super.initState();
    fetchCount();
  }

  Future<void> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLoggedIn', false);
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => LoginPage())));
  }

  Future<void> fetchCount() async{
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('products').get().then((value){
      setState(() {
        count = value.docs.length;
        isLoaded = true;
      });
    });
  }

  int count = 0;
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text('Account', style: TextStyle(color: Colors.black),),
        leading: Icon(Icons.account_circle, color: Colors.black,),
      ),
      body: isLoaded ? Column(
        children: [
          SizedBox(height: 50,),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL.toString()))
            ),
          ),
          SizedBox(height: 20,),
          Text(
            FirebaseAuth.instance.currentUser!.displayName.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              'Total Number of Products in your Inventory:\t\t\t$count',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 40,),
          Container(
            padding: EdgeInsets.all(20),
            // width: MediaQuery.of(context).size.width ,
            child: RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.red,
              onPressed: (){
                signOut();
              },
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ) : Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: LinearProgressIndicator()),
      ),
    );
  }
}