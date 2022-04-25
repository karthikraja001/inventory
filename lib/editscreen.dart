// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({ Key? key }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text('Edit', style: TextStyle(color: Colors.black),),
        leading: Icon(Icons.edit, color: Colors.black,),
      ),
    );
  }
}