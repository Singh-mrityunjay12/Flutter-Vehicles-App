import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicales_details/screens/Car_form.dart';
import 'package:vehicales_details/screens/bike_From.dart';

import 'Bike_Details.dart';
import 'Car_Deatails.dart';


class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  
  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne>
with SingleTickerProviderStateMixin {
late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

void _handleButtonClicked() {
    // Access the active tab index using _tabController.index
    int activeTabIndex = controller.index;
    activeTabIndex==0?
    Get.to(()=>const BikeFrom()):Get.to(()=>const CarFrom());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title:const Text("Vehicales Details"),
        bottom:  TabBar(
          indicatorColor: Colors.white,
          indicatorWeight: 2,
          controller: controller,
          tabs: const [
          Tab(text: 'Bikes',),
          Tab(text: 'Cars'),
        ]),
        ),
      body: Stack(
        children: [
          TabBarView(
            controller: controller,
            children: const [
            BikeDetails(),
            CarDetails(),
          ]),
          Positioned(
            bottom:2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height:50,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:2),
                    child: ElevatedButton(onPressed:_handleButtonClicked,
                    style:ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                    ), child: const Text("Add Vehicales",
                    style: TextStyle(
                      fontSize: 18
                    ),
                    ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}