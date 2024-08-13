import 'package:flutter/material.dart';


const errorDateSnackBar = SnackBar(
  backgroundColor: Colors.red,
  duration: Duration(seconds: 5),
  content: Text('Invalid date selected !'),
);
void showSnackBar(BuildContext context,SnackBar snackBar){
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}