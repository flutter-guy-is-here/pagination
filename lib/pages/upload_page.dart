import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination/controllers/explore_controller.dart';

class UploadModules extends StatefulWidget {
  const UploadModules({super.key});

  @override
  State<UploadModules> createState() => _UploadModulesState();
}

class _UploadModulesState extends State<UploadModules> {
  ExploreController exploreController = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        InkWell(
          onTap: () async {
            await exploreController.uploadModulesToFirestore();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Obx(
                () => Text(
                  exploreController.uploading.value
                      ? " uploading....."
                      : "Upload data",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
