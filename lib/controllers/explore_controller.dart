import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:pagination/data/repository/modules_data.dart';
import 'package:pagination/utils/modules_list.dart';

class ExploreController extends GetxController {
  RxBool loading = true.obs;
  RxBool loadingMore = false.obs;
  RxBool hasMore = true.obs;
  RxList modules = [].obs;
  RxBool isFromCache = false.obs;
  ScrollController controller = ScrollController();

  var uploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    controller.addListener(onScroll);
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  // For loading the data intially
  Future<void> loadData() async {
    loading.value = true;

    try {
      var fetchedModulesMap = await ModulesData.getModules();
      var fetchedModules = fetchedModulesMap["list"];
      isFromCache.value = fetchedModulesMap["isFromCache"];
      modules.clear();
      hasMore.value = true;
      modules.addAll(fetchedModules.toList());
      if (isFromCache.value) {
        Get.snackbar("THE DATA LOADED FROM CACHE", "NO INTERNET ACCESS");
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Something went wrong", e.code.toString(),
          icon: const Icon(
            Icons.warning,
            color: Colors.amber,
          ));
    } catch (e) {
      Get.snackbar("Something went wrong", "${e.runtimeType}",
          icon: const Icon(
            Icons.warning,
            color: Colors.amber,
          ));
    } finally {
      loading.value = false;
    }
  }

  // Just for the button to change it's status
  void toggleUpload() {
    uploading.value = !uploading.value;
  }

  // To upload local modules list to firestore
  Future<void> uploadModulesToFirestore() async {
    uploading.value = true;
    try {
      await ModulesData.uploadModuleToFirestore(modulesList);
      uploading.value = false;
    } catch (e) {
      uploading.value = false;
      Get.snackbar("Error uploading", e.toString());
    }
  }

  // To loead more when reached the bottom of the list
  Future<void> loadMore() async {
    try {
      if (!hasMore.value || loadingMore.value) return;

      loadingMore.value = true;

      if (ModulesData.lastDoc != null) {
        var moreData = await ModulesData.loadMore();
        if (moreData.length < ModulesData.batchSize) hasMore.value = false;
        print("\n the NEW BATCH SIZEEE: ${moreData.length}");

        modules.addAll(moreData.toList());
        loadingMore.value = false;
      }
    } catch (e) {
      loadingMore.value = false;
      Get.snackbar("Error uploading", e.toString());
    }
  }

  // when scrolled all the way down to load more data
  void onScroll() async {
    print("LOAD MORE CALLED beforee");
    if (controller.position.pixels == controller.position.maxScrollExtent &&
        !loadingMore.value &&
        hasMore.value) {
      print("LOAD MORE CALLED");
      await loadMore();
    }
  }
}
