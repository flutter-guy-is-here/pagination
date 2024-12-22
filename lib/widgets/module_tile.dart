import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination/models/module.dart';
import 'package:pagination/utils/formatters/firestore_time.dart';

class ModuleTile extends StatelessWidget {
  const ModuleTile({super.key, required this.module});

  final Module module;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        module.name ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: Text(
        formatters.formatTimestamp(
          module.timestamp,
        ),
        style: const TextStyle(color: Colors.black45),
      ),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.deepPurple.withOpacity(.8)),
        child: Center(
          child: Text(
            module.coef.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(TextSpan(text: "${"year".tr} : ", children: [
            TextSpan(
                text: module.year ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black87))
          ])),
          Text.rich(TextSpan(text: "${"hours".tr} : ", children: [
            TextSpan(
                text: module.hours.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black87))
          ])),
        ],
      ),
    );
  }
}
