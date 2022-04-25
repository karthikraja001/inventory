// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({ Key? key }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text('Add Product', style: TextStyle(color: Colors.black),),
        leading: Icon(Icons.add, color: Colors.black,),
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
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Product Id',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: () async{
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
              },
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
                      disabledBorder: OutlineInputBorder(),
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
                  onPressed: (){
                    if(proNameController.text != '' && proPriceController.text != '' && proQuantityController.text != '' && proDescriptionController.text != '' && proIdController.text != '' && proLastUpdatedController.text != ''){
                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('products').doc(productId).get().then((value){
                        if(value.data() == null){
                          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('products').doc(productId).set({
                            'productName': productName,
                            'productPrice': productPrice,
                            'productQuantity': productQuantity,
                            'productDescription': productDescription,
                            'productLastUpdated': productLastUpdated,
                            'productId' : productId
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
                            'productId' : productId
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
                  },
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