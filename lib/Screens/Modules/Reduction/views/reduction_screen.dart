import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/Reduction/reduction_path.dart';

class ReductionScreen extends GetView<ReductionScreenController>{
  const ReductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
     appBar: AppBar(
       backgroundColor: controller.colorPrimary.value,
       centerTitle: true,
       title: Text('Réservations', style: TextStyle(
           fontSize: 23,
           color: Colors.white,
           fontWeight: FontWeight.bold,
           fontFamily: GoogleFonts.taprom().fontFamily),),
     ),
     body: const ReductionComponent(),
   );
  }
}