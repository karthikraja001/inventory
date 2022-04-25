// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inventory/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://img.freepik.com/free-vector/man-putting-boxes-shelves-rack_74855-10897.jpg?t=st=1650784275~exp=1650784875~hmac=9064c3eb0dc5c7f131e7b41b16b7d59ff42ede04ae30db4e24f0017642ad370f&w=996'),
                  fit: BoxFit.cover
                )
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  'Manage All your Inventory needs in one app',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Center(
              child: GestureDetector(
                onTap: () async{
                  await signInWithGoogle().then((value) async{
                    if(value != null){
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.setBool('isLoggedIn', true);
                      FirebaseFirestore.instance.collection('users').doc(value.user!.uid).get().then((value){
                        if(value.data() == null){
                          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
                            'name': FirebaseAuth.instance.currentUser!.displayName,
                            'email': FirebaseAuth.instance.currentUser!.email,
                            'photoUrl': FirebaseAuth.instance.currentUser!.photoURL,
                            'uid': FirebaseAuth.instance.currentUser!.uid
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                        }
                        else{
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                        }
                      });

                    }
                  });
                },
                child: Container(
                  // width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    // color: const Color(0xFF4285F4),
                    border: Border.all(
                      width: 0.7
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.network(
                        'https://img.icons8.com/color/344/google-logo.png',
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0,right: 10.0),
                          child: Text("Sign in with Google",style: TextStyle(color: Colors.black,fontSize: 17, fontWeight: FontWeight.bold),)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}