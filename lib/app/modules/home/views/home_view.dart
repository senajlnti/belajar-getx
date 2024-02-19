import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/profile');
              }, 
              child: Text("Pindah ke profil"),
              ),
               SizedBox(height: 10,),
              ElevatedButton(
              onPressed: () {
                Get.toNamed('/counter');
              }, 
              child: Text("Pindah ke counter"),
              ),
               SizedBox(height: 10,),
              ElevatedButton(
              onPressed: () {
                Get.toNamed('/biodata');
              }, 
              child: Text("Pindah ke biodata"),
              )
          ],
        ),
      ),
    );
  }
}