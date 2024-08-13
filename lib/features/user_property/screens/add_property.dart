import 'dart:developer';

import 'package:airbnb/features/auth/widget/form_field.dart';
import 'package:airbnb/features/property/controller/property_controller.dart';
import 'package:airbnb/models/property_model/model.dart';
import 'package:airbnb/util/extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddPropertyScreen extends ConsumerStatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  ConsumerState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends ConsumerState<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  List<XFile?>? _image;

  City? city;
  bool _internet = false;
  bool _imageLoading=false;
  void _toggleInternet(bool value) {
    setState(() {
      _internet = value;
    });
  }


  final Map<String,TextEditingController> _controllers = {
    "address":TextEditingController(),
    "city":TextEditingController(),
    "description":TextEditingController(),
    "numberOfRoom":TextEditingController(),
    "numberOfBathroom":TextEditingController(),
    "Daily_Price":TextEditingController(),
    "Monthly_Price":TextEditingController(),
    "Internet":TextEditingController(),
    "size":TextEditingController(),
  };
  final List<String> hintText = [
    "Ex: Midan,...",
    "Damascus,tartus",
    "Describe your Property",
    "Number of Bedrooms",
    "Number of Bathrooms",
    "3000SYP",
    "3000SYP",

    "Yes Or NO"
  ];
  final List<String> labelText = [
    "Address",
    "City",
    "Descriptions",
    "Number of room",
    "Number of Bathroom",
    "Daily Price",
    "Monthly Price",
    "Internet"
  ];
  Future<void> pickImageFromGallery() async {

    setState(() {

      _imageLoading=true;
    });
     List<XFile?>? image = await _picker.pickMultiImage(imageQuality: 50,limit: 3);
    if (image.isNotEmpty) {
      setState(() {
        _image = image;
        _imageLoading=false;
      });
    }
    else {
      image=null;
    }
  }
  void addProp(BuildContext context) async {
    log(city!.name);
    PropertyModel x= PropertyModel(address: _controllers["address"]!.text,
        availabilityStatus: true,
        city: city!,
        description: _controllers["description"]!.text,
         images: _image!.map((e) => e!.name,).toList(),
        numberOfBathrooms:int.parse( _controllers["numberOfRoom"]!.text),
        numberOfRooms: int.parse( _controllers["numberOfBathroom"]!.text),
        priceDaily:  int.parse( _controllers["Daily_Price"]!.text),
        priceMonthly:   int.parse( _controllers["Monthly_Price"]!.text),
        size: int.parse( _controllers["size"]!.text),
        hasWifi: _internet, id: '', owner: '');
    if (  _image != null || _image!.isNotEmpty) {
      ref.read(asyncPropertyProvider.notifier).addProperty(x, _image as List<XFile>,context.pop);
    }
    else{log("image is Empty");}
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Adding New Property"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: const BackButton(
              color: Colors.black,
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height- 16.0,
            ),
            child: IntrinsicHeight(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ///address
                    CustomFormField(
                    controller: _controllers["address"]!,
                    hintText: hintText[0],
                    labelText: labelText[0],
                    validateFunction: (String? val ) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      if (val.isValidName) {
                        return null;
                      }
                      return "Not Valid Address";
                    },inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r' ')),
                    FilteringTextInputFormatter.deny(RegExp(r'\n')),
                  ], label:Text(labelText[0]),



                  ),
                      ///city
                      DropdownButtonFormField<City>(
                        selectedItemBuilder: (context) =>
                        City.values.map<Text>((e) =>Text( city?.name ?? ""),).toList(),
                        elevation: 10,
                        decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            labelText: "City",
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 20.0),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        value: city,
                        hint:  Text(hintText[1]),
                        items: City.values.map<DropdownMenuItem<City>>((City val) {
                          return DropdownMenuItem<City>(value: val,child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(val.name),
                          ),);
                        },).toList(),
                        onChanged: (City? value) {
                          setState(() {
                            city = value;
                          });
                        },
                        validator: (City? value) {
                          if (value == null) {
                            return 'Please select City';
                          }
                          return null;
                        },
                      ),
                      ///descriptions
                      CustomFormField(
                        inputFormatters: [],
                        controller: _controllers["description"]!,
                        hintText: hintText[2],
                        labelText: labelText[2],
                        validateFunction: (String? val ) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          if (val.isValidName) {
                            return null;
                          }
                          return "Not Valid Address";
                        }, label:Text(labelText[2]),



                      ),
                      ///Number fo rooms
                      CustomFormField(
                        controller: _controllers["numberOfRoom"]!,
                        hintText: hintText[3],
                        labelText: labelText[3],
                        validateFunction: (String? val ) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], label:Text(labelText[3]),



                      ),
                      ///Number fo Bathrooms
                      CustomFormField(
                        controller: _controllers["numberOfBathroom"]!,
                        hintText: hintText[4],
                        labelText: labelText[4],
                        validateFunction: (String? val ) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], label:Text(labelText[4]),



                      ),
                      ///Daily Price
                      CustomFormField(
                        controller: _controllers["Daily_Price"]!,
                        hintText: hintText[5],
                        labelText: labelText[5],
                        validateFunction: (String? val ) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], label:Text(labelText[5]),



                      ),
                      ///Monthly Price
                      CustomFormField(
                        controller: _controllers["Monthly_Price"]!,
                        hintText: hintText[6],
                        labelText: labelText[6],
                        validateFunction: (String? val ) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], label:Text(labelText[6]),



                      ),
                      ///size
                      CustomFormField(
                        controller: _controllers["size"]!,
                        hintText:"260",
                        labelText: "size",
                        validateFunction: (String? val ) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }

                          return null;
                        },inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], label:Text("Size"),


                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Expanded(child: Text("Internet")),
                          Switch(
                            value: _internet,
                            onChanged: _toggleInternet,
                            activeTrackColor: Colors.black,
                            activeColor: Colors.white,
                          ),
                        ],
                      ),

                      //const Spacer(flex: 2,),
                      Row(
                        children: [
                          const Expanded(child: Text("Upload  Image")),
                           _imageLoading ? const CircularProgressIndicator() : IconButton(
                              onPressed: () async{
                                await pickImageFromGallery();
                              },
                              icon: const Icon(Icons.image)),
                        ],
                      ),
                    ],
                  )
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: kBottomNavigationBarHeight + 30.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: ElevatedButton(
                      onPressed:  _imageLoading ?(){}: () {
                      if (_formKey.currentState!.validate()) {
                        addProp(context);
                      }

                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4.0,
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                      child:_imageLoading ? const Text("Reading Images"): const Text("Add Property"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
