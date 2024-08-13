import 'package:airbnb/models/property_model/model.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final  PropertyModel property;
  final String title;
  final String description;
  final IconData icon;
  const DetailsCard({super.key, required this.property, required this.title, required this.description, required this.icon});

  Widget _cardbuild(){
    return  const Expanded(
      child: Card(
        elevation: 10.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.start,children: [Text("data :  "),Icon(Icons.bed)],),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Text('3'),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return   Expanded(
      child: Card(
        elevation: 10.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,children: [Icon(icon),Flexible(child: Text("  $title :  ",))],),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(description,style: const TextStyle(fontSize: 18.0),),
            ),
          ],
        ),
      ),
    );
  }

}
