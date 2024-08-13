
import 'package:flutter/material.dart';
class SettingTile extends StatelessWidget {
   const SettingTile({
    super.key,
    required this.prefixIcon,
    required this.title,
    required this.desc,
    this.onPress
  });
  final IconData prefixIcon;
  final String title;
  final String desc;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      height: screenHeight * 0.1,
      width: screenWidth ,
      decoration: const BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  prefixIcon,
                  color: Colors.black,
                )),
          ),
        ),
       Container(
         margin: const EdgeInsets.symmetric(vertical: 10.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center,

           children: [
           Text(title,
               style:const  TextStyle(fontSize: 20.0, color: Colors.black)
           ),
           Expanded(
             child: Text(desc
             ,style:const TextStyle(color: Colors.grey) ),
           ),
         ],),
       ),

        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration:  BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: IconButton(
                onPressed: onPress,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                )),
          ),
        )
      ]),
    );
  }
}
