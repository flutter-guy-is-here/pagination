import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination/models/module.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.module});

  final Module module;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Hero(
          tag: "mod-coef-${module.name}",
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 0.2 * MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Center(
              child: Text(
                module.coef.toString(),
                style: const TextStyle(
                    fontSize: 68,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  "${"module_name".tr}: ",
                  style: TextStyle(color: Colors.black87),
                ),
                Text(
                  module.name ?? "no name found!",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${"hours".tr}: ",
                  style: TextStyle(color: Colors.black87),
                ),
                Text(
                  module.hours.toString(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${"year".tr}: ",
                  style: TextStyle(color: Colors.black87),
                ),
                Text(
                  module.year ?? "uknown year",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ]),
        )
      ]),
    );
  }
}
