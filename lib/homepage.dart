// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inventory/account.dart';
import 'package:inventory/addproduct.dart';
import 'package:inventory/editscreen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inventory/viewdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Widget> pages = [
    HomeScreen(),
    AddProduct(),
    AccountScreen()
  ];

  PageController pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        child: GNav(
          onTabChange: (value) {
            pageController.jumpToPage(value);
          },
          gap: 10,
          color: Colors.white,
          activeColor: Colors.white,
          iconSize: 24,
          tabBackgroundColor: Colors.purple.withOpacity(0.1),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.add,
              text: 'Add Product',
            ),
            GButton(
              icon: Icons.account_circle,
              text: 'Account',
            ),
          ]
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomeScreen(),
          AddProduct(),
          AccountScreen()
        ],
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        },
      )
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text('Home', style: TextStyle(color: Colors.black),),
        leading: Icon(Icons.home, color: Colors.black,),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            var data = snapshot.data!.docs;
            if(snapshot.data!.docs.isEmpty){
              return Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'You Don\'t Have Any Products Yet!. Goto Add Product and add your products.',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index){
                // create a tile for each document
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => ViewProduct(productName: data[index]['productName'], productPrice: data[index]['productPrice'], productQuantity: data[index]['productQuantity'], productDescription: data[index]['productDescription'], productId: data[index]['productId'], productLastUpdated: data[index]['productLastUpdated']))));
                  },
                  child: Slidable(
                    endActionPane: ActionPane(motion: ScrollMotion(), children: [
                      SlidableAction(
                        foregroundColor: Colors.red,
                        label: 'Delete',
                        icon: Icons.delete, onPressed: (value) {
                          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('products').doc(data[index].id).delete();
                        },
                      ),
                    ]),
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(data[index]['productName']),
                      subtitle: Text("Last Updated:\t"+data[index]['productLastUpdated']),
                      trailing: Text(
                        "Quantity:\t"+data[index]['productQuantity'].toString(),
                        style: TextStyle(
                          color: int.parse(data[index]['productQuantity']) <=5 ? Colors.red : Colors.green.shade600,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      )
    );
  }
}