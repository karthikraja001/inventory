// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewProduct extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productQuantity;
  final String productDescription;
  final String productId;
  final String productLastUpdated;
  const ViewProduct({ Key? key, required this.productName, required this.productPrice, required this.productQuantity, required this.productDescription, required this.productId, required this.productLastUpdated }) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {

  TextEditingController proNameController = TextEditingController();
  String productName = '';
  TextEditingController proPriceController = TextEditingController();
  String productPrice = '';
  TextEditingController proQuantityController = TextEditingController();
  String productQuantity = '';
  TextEditingController proDescriptionController = TextEditingController();
  String productDescription = '';
  TextEditingController proIdController = TextEditingController();
  String productId = '';
  TextEditingController proLastUpdatedController = TextEditingController();
  String productLastUpdated = '';

  bool isValid = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      productName = widget.productName;
      productPrice = widget.productPrice;
      productQuantity = widget.productQuantity;
      productDescription = widget.productDescription;
      productId = widget.productId;
      productLastUpdated = widget.productLastUpdated;
      proNameController.text = widget.productName;
      proPriceController.text = widget.productPrice;
      proQuantityController.text = widget.productQuantity;
      proDescriptionController.text = widget.productDescription;
      proIdController.text = widget.productId;
      proLastUpdatedController.text = widget.productLastUpdated;
    });
  }

  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(widget.productName, style: TextStyle(color: Colors.black),),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.black,)
        ),
        actions: [
          GestureDetector(
            onTap: (){
              setState(() {
                isEditable = !isEditable;
              });
            },
            child: Icon(
              !isEditable ? Icons.edit : Icons.block,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Center(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  enabled: isEditable ? true : false,
                  style: TextStyle(
                    fontSize: 17
                  ),
                  controller: proNameController,
                  onChanged: (value){
                    print(value);
                    setState(() {
                      productName = value;
                    });
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.abc_outlined),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    // disabledBorder: OutlineInputBorder(),
                    hintText: 'Product Name',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  enabled: isEditable ? true : false,
                  style: TextStyle(
                    fontSize: 17
                  ),
                  controller: proPriceController,
                  onChanged: (value){
                    print(value);
                    setState(() {
                      productPrice = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    // disabledBorder: OutlineInputBorder(),
                    hintText: 'Product Price',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  enabled: isEditable ? true : false,
                  style: TextStyle(
                    fontSize: 17
                  ),
                  controller: proQuantityController,
                  onChanged: (value){
                    print(value);
                    setState(() {
                      productQuantity = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.add_circle_outline),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    // disabledBorder: OutlineInputBorder(),
                    hintText: 'Product Quantity',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: SizedBox(
                // height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  enabled: isEditable ? true : false,
                  style: TextStyle(
                    fontSize: 17
                  ),
                  controller: proDescriptionController,
                  onChanged: (value){
                    print(value);
                    setState(() {
                      productDescription = value;
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    // disabledBorder: OutlineInputBorder(),
                    hintText: 'Product Description',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  enabled: false,
                  style: TextStyle(
                    fontSize: 17
                  ),
                  controller: proIdController,
                  onChanged: (value){
                    print(value);
                    setState(() {
                      productId = value;
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.tag),
                    border: OutlineInputBorder(),
                    // disabledBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Product Id',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: isEditable ? () async{
                final dateTime = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(1970), 
                  lastDate: DateTime.now(),
                );
                if(dateTime != null){
                  var month = dateTime.month == 1 ? 'Jan' : dateTime.month == 2? 'Feb' : dateTime.month == 3? 'Mar' : dateTime.month == 4? 'Apr' : dateTime.month == 5? 'May' : dateTime.month == 6? 'Jun' : dateTime.month == 7? 'Jul' : dateTime.month == 8? 'Aug' : dateTime.month == 9? 'Sep' : dateTime.month == 10? 'Oct' : dateTime.month == 11? 'Nov' : 'Dec';
                  proLastUpdatedController.text = dateTime.year.toString() + ' ' + month.toString() + ' ' + dateTime.day.toString();
                  productLastUpdated = proLastUpdatedController.text;
                }
              } : null,
              child: Center(
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextFormField(
                    enabled: false,
                    style: TextStyle(
                      fontSize: 17
                    ),
                    controller: proLastUpdatedController,
                    onChanged: (value){
                      print(value);
                      setState(() {
                        productLastUpdated = value;
                      });
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.update),
                      border: OutlineInputBorder(),
                      // enabledBorder: OutlineInputBorder(),
                      disabledBorder: isEditable ? OutlineInputBorder() : null,
                      hintText: 'Product Last Updated',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: RaisedButton(
                  onPressed: isEditable ? (){
                    if(proNameController.text != '' && proPriceController.text != '' && proQuantityController.text != '' && proDescriptionController.text != '' && proIdController.text != '' && proLastUpdatedController.text != ''){
                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('products').doc(productId).get().then((value){
                        if(value.data() == null){
                          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('products').doc(productId).set({
                            'productName': productName,
                            'productPrice': productPrice,
                            'productQuantity': productQuantity,
                            'productDescription': productDescription,
                            'productLastUpdated': productLastUpdated,
                          }).then((value){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                'Product Added'
                              ))
                            );
                            proNameController.clear();
                            proPriceController.clear();
                            proQuantityController.clear();
                            proDescriptionController.clear();
                            proIdController.clear();
                            proLastUpdatedController.clear();
                          });
                        }else{
                          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('products').doc(productId).update({
                            'productName': productName,
                            'productPrice': productPrice,
                            'productQuantity': productQuantity,
                            'productDescription': productDescription,
                            'productLastUpdated': productLastUpdated,
                          }).then((value){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                'Product already Exists. Updated Successfully'
                              ))
                            );
                            proNameController.clear();
                            proPriceController.clear();
                            proQuantityController.clear();
                            proDescriptionController.clear();
                            proIdController.clear();
                            proLastUpdatedController.clear();
                          });
                        }
                      });
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(
                          'Please fill all the fields'
                        ))
                      );
                    }
                  } : null,
                  color: Colors.blue,
                  child: Text('Add Product', style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}