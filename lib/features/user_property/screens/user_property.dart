

import 'package:airbnb/features/property/controller/property_controller.dart';
import 'package:airbnb/models/property_model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class MyProperty extends ConsumerStatefulWidget {
  const MyProperty({super.key});

  @override
  ConsumerState<MyProperty> createState() => _MyPropertyState();
}

class _MyPropertyState extends ConsumerState<MyProperty> {
   bool hideDetails=false;


   @override
  void dispose() {
     hideDetails=false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title:const Text("Your Own Property") ,
          actions: [
            TextButton(onPressed: (){},
                child:const Text("Booked Property"), ),

          ],

        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              context.go('/MyProperty/addProp');
            },
            child:const Icon(
              Icons.add_home,
              color: Colors.white,
            )),
        body:ref.watch(userPropertyProvider).when(
            data: (data) {
              return  Column(
                children:
                 [
                   if(!hideDetails)
                  mainCard(data.length),
                  buildListView(context,data),
                ],

              );
            },
            error:(error, stackTrace) => Center(child: Text("error : $error")) ,
            loading:  () => const Center(child: CircularProgressIndicator())
        ),
      ),
    );
  }

  Card mainCard(int length) {
    return Card(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20),),
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("MY Property", style: TextStyle(
                        fontSize: 24,
                        color: Colors.white
                    ),),
                    Container(height: 10),
                    Text("PropertyCount: ${length.toString()} ", style: TextStyle(
                        fontSize: 15, color: Colors.grey[200]
                    )),
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.transparent),
                child: const Text("Hide", style: TextStyle(color: Colors.white),),
                onPressed: (){ setState(() {
                  hideDetails=true;
                });},
              ),
            ],
          ),
                      );
  }
  Expanded buildListView(BuildContext context,List<PropertyModel> data) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, index) {
            return buildGestureDetector(context, index, data[index]);
          }),
    );
  }
  GestureDetector buildGestureDetector(BuildContext context, int index, PropertyModel data) {
    return GestureDetector(
      onTap: () {
        context.go('/all/details/${data.id}');
      },
      child: SizedBox(
        width: double.infinity,
        height: 180.0,
        child: Card(
          child: Row(children: [
            Expanded(flex: 1,child: decoratedNetworkImage(data)),
            const VerticalDivider(width: 10.0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(data.address,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis),
                      softWrap: true),
                  Text(
                    "price :${data.priceDaily.round()}",
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis),
                    softWrap: true,
                  ),
                  const Divider(),
                  Text(
                    "Description:\n ${data.description}",style: const TextStyle(overflow: TextOverflow.ellipsis),),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
  Widget decoratedNetworkImage( PropertyModel prop ){
    return CachedNetworkImage(
      imageUrl: prop.thumbImage == null  ? "https://picsum.photos/200" : prop.thumbImage! ,
      imageBuilder: (context, imageProvider) {
        return   ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            height:double.infinity ,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),

                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                )),

          ),
        );

      },
      placeholder: (context, url) => const Center(child:  CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
