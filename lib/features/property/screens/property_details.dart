import 'dart:async';
import 'dart:developer';
import 'package:airbnb/util/extension.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:airbnb/common/Loading.dart';
import 'package:airbnb/features/property/controller/property_controller.dart';
import 'package:airbnb/features/property/screens/widgets/details.dart';
import 'package:airbnb/features/property/screens/widgets/owner_details.dart';
import 'package:airbnb/models/property_model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/snackbar.dart';


class PropertyDetails extends ConsumerStatefulWidget {
  final String propertyID;
  const PropertyDetails({
    super.key,
    required this.propertyID,
  });


  @override
  ConsumerState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends ConsumerState<PropertyDetails> {
  final _controller = CarouselController();
  DateTime _startingDate = DateTime.now();
  DateTime _endingDate = DateTime.now();
  int _current = 0;

  @override
  Widget build(BuildContext context) {



    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    //log(ref.read(getPropertyByIdProvider(widget.propertyID).future));
    return Scaffold(
      appBar: _buildAppBar(),
      body: ref.watch(getPropertyByIdProvider(widget.propertyID)).when(
        data: (prop) {
          final owner = prop.expand!.owner;
          final images = prop.imagesUrl;
          return SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarousel(
                      screenHeight, screenWidth, images, _controller),
                  _indicator(images, _controller, _current),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      prop.address.toString(),
                      style: const TextStyle(
                          fontSize: 30.0, color: Colors.black),
                    ),
                  ),
                  Row(children: [
                    const Icon(Icons.pin_drop_sharp, color: Colors.grey),
                    Text(
                      prop.city.name,
                      style: const TextStyle(
                          fontSize: 20.0, color: Colors.grey),
                    )
                  ]),
                  const SizedBox(height: 10.0),
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth - 10,
                    decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0))),
                    child: OwnerDetails(owner: owner,),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth - 10,
                    decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DetailsCard(
                              property: prop,
                              title: "Wifi",
                              description:
                              prop.hasWifi ? "yes" : "No Internet",
                              icon: Icons.wifi),
                          DetailsCard(
                              property: prop,
                              title: "Bedroom",
                              description: prop.numberOfRooms.toString(),
                              icon: Icons.bed),
                          DetailsCard(
                              property: prop,
                              title: "Bathroom",
                              description:
                              prop.numberOfBathrooms.toString(),
                              icon: Icons.bathtub),
                        ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(height: 1.0, color: Colors.black38,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: prop.description.length > 300 ? screenHeight *
                          0.20 : screenHeight * 0.10,
                      child: SingleChildScrollView(
                        child: Text(
                          "  Description: \n ${prop.description} ",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          );
        },
        error: (e, s) =>
            Center(
              child: TextButton(onPressed: () =>
                  ref.refresh(getPropertyByIdProvider(widget.propertyID)),
                child: const Text("Something Went Wrong Press to Refresh"),),
            ),
        loading: () => const Loading(),
      ),
      bottomNavigationBar:
      ref.watch(getPropertyByIdProvider(widget.propertyID)).when(
        data: (value) => _buildBottomBar(value, screenWidth, context),
        error: (error, stackTrace) => null,
        loading: () => null,
      ),
    );
  }

  SafeArea _buildBottomBar(PropertyModel prop, double screenWidth,
      BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: kBottomNavigationBarHeight * 1.25,
        // Adjust multiplier as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${prop.priceDaily.toString()}   SYP"),
            ),
            SizedBox(
              height: kBottomNavigationBarHeight,
              width: screenWidth * 0.60, // Adjust multiplier as needed
              child: ElevatedButton(
                onPressed: () async {
                  final confirmed = await _dialogBuilder(context,prop) ?? false;
                  if(confirmed){
                      ref.read(asyncPropertyProvider.notifier).bookProperty(
                          prop,
                          _startingDate,
                          _endingDate,
                           context.pop,
                            );
                  }


                },
                style: ElevatedButton.styleFrom(
                  elevation: 4.0,
                  backgroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
                child: const Text("Book now"),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child:  BackButton(
            onPressed: (){context.pop();},
            color: Colors.black,
          ),
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }

  Padding _buildCarousel(double screenHeight, double screenWidth,
      List<String> images, CarouselController controller) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.02, // Adjust vertical padding as needed
        bottom: screenHeight * 0.02,
        left: screenWidth * 0.05, // Adjust horizontal padding as needed
        right: screenWidth * 0.05,
      ),
      child: Container(
        height: screenHeight * 0.4, // Adjust container height as needed
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(20, 20),
            ),
          ],
        ),
        child: CarouselSlider(
          carouselController: controller,
          items: images.map((e) {
            return _decoratedNetworkImage(e, screenWidth);
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) =>
                setState(() {
                  _current = index;
                }),
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.9,
            disableCenter: true,
          ),
        ),
      ),
    );
  }

  Widget _decoratedNetworkImage(String imageUrl, double screenWidth) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) =>
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                )),
            width: screenWidth,
          ),
      placeholder: (context, url) => const Center(child: Loading()),
      errorWidget: (context, url, error) =>
      const Center(child: Icon(Icons.error)),
    );
  }

  Row _indicator(List<String> images, CarouselController controller,
      int current) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images
          .asMap()
          .entries
          .map((entry) {
        return GestureDetector(
            onTap: () => controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                Colors.black.withOpacity(current == entry.key ? 0.9 : 0.4),
              ),
            ));
      }).toList(),
    );
  }

  Future<bool?> _dialogBuilder(BuildContext context,PropertyModel prop) async {
    return await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context,setState) {
            final checkInDate=TextEditingController(
                text: DateFormat('yyyy-MM-dd').format(_startingDate));
            final checkOutDate=TextEditingController(
                text: DateFormat('yyyy-MM-dd').format(_endingDate));
            Future<void> _selectStartingDate() async {
              final DateTime? picked = await showDatePicker(

                context: context,
                initialDate: _startingDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null ) {
                setState((){
                  _startingDate=picked;
                });
              }
              else{
                    context.pop();
                    showSnackBar(context, errorDateSnackBar);
              }
            }
            Future<void> _selectEndingDate() async {
              final DateTime? picked = await showDatePicker(
                fieldLabelText: "s",
                context: context,
                initialDate: _endingDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null && picked != _endingDate && picked.isValidDate) {
                setState((){
                  _endingDate=picked;
                });
              }
              else{
                context.pop();
                showSnackBar(context, errorDateSnackBar);
              }
            }
            final dateDifferenceInDays=_endingDate.difference(_startingDate).inDays;
            return AlertDialog(
              scrollable: true,
              title: const Text('Book Property'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child:  Text(
                      'Please review your selected dates to confirm they are correct.\n'
                          ' If you need to make any changes, you can do so by clicking the "Edit Dates" button below. \n'
                          ' For any special requests or questions, feel free to contact the property owner or our support team.',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onTap:()async{ await _selectStartingDate();} ,

                      readOnly: true,
                      controller:checkInDate,
                      decoration: const InputDecoration(labelText: "Starting Data",border: OutlineInputBorder()),
                      ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      onTap: ()async{  await _selectEndingDate();},
                      readOnly: true,
                      controller:checkOutDate,
                      decoration: const InputDecoration(labelText: "Ending Data",border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(8.0),
                  child:Text(" Total Days : ${_endingDate.difference(DateTime.now()).inDays == 0 ? "":dateDifferenceInDays }")
                  ),
                  Padding(padding: const EdgeInsets.all(8.0),
                      child:Text(" Price Per Day : ${_endingDate.difference(DateTime.now()).inDays == 0 ? "":prop.priceDaily * dateDifferenceInDays }")
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  child: const Text('Confirm'),
                  onPressed: () {

                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          }
        );
      },);
  }

}
