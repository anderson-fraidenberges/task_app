import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
     return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(top:4.0, left:18),
        child: Image.asset("assets/images/logo_checked.png"),
      ),
         title:Image.asset("assets/images/Taski.png", fit: BoxFit.fitWidth,),
      actions: [const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child:  Text("John", style:TextStyle(fontFamily: "Urbanist", fontWeight: FontWeight.bold)) 
          ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child:  CircleAvatar(radius: 18, child:ClipOval(child: Image.asset("assets/images/john.png", fit: BoxFit.cover,)))
          )]
        );   
  }
  
  @override  
   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}