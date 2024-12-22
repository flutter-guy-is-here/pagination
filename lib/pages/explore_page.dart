import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination/controllers/explore_controller.dart';
import 'package:pagination/localization/localization_chacker.dart';
import 'package:pagination/models/module.dart';
import 'package:pagination/utils/helpers/network_manager.dart';
import 'package:pagination/widgets/module_tile.dart';
import 'package:pagination/widgets/adaptive_pull_to_refresh.dart';
import 'package:pagination/widgets/shimmer_list.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  ExploreController exploreController = Get.put(ExploreController());
  late CollectionReference<Module> collection;

  @override
  void initState() {
    // exploreController.get

    super.initState();
    final collectionRef = FirebaseFirestore.instance.collection('modules');

    collection = collectionRef.withConverter<Module>(
      fromFirestore: (snapshot, _) => Module.fromJson(snapshot.data()!),
      toFirestore: (user, _) => Module().toJson(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  // LocalizationChacker.changeLang(context);
                  LocalizationChacker.changeLangGetx();
                },
                child: Text("change_the_languge".tr))
          ],
        ),
        body: SafeArea(
          child: Obx(
            () => exploreController.loading.value
                ? /* const Center(
                child: Text(
                "loading...!",
                style: TextStyle(color: Colors.black87, fontSize: 24),
              ))*/
                const ShimmerList()
                : exploreController.modules.isEmpty
                    ? FutureBuilder(
                        future: NetworkManager.isConnected(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Center(
                              child: Text(snapshot.data ?? false
                                  ? "no_element".tr
                                  : "YOU ARE NOT CONNECTED"),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      )
                    :
                    // adaptive scroll view with refresh indicator
                    AdaptivePullToRefresh(
                        itemCount: exploreController.modules.length + 1,
                        scrollController: exploreController.controller,
                        onRefresh: exploreController.loadData,
                        // physics: const AlwaysScrollableScrollPhysics(),
                        builder: (context, index) {
                          if (index == exploreController.modules.length) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: ListTile(
                                title: Text(exploreController.hasMore.value
                                    ? "loading_more".tr
                                    : "end_of_list".tr),
                              ),
                            );
                          } else {
                            Module module = exploreController.modules[index];
                            return ModuleTile(module: module);
                          }
                        },
                      ),

            // ONLY FOR ANDROID
            // ListView.separated(
            //     controller: exploreController.controller,
            //     itemCount: exploreController.modules.length + 1,
            //     itemBuilder: (context, index) {
            //       if (index == exploreController.modules.length) {
            //         return ListTile(
            //           title: Text(exploreController.hasMore.value
            //               ? "loading_more".tr
            //               : "end_of_list".tr),
            //         );
            //       } else {
            //         Module module = exploreController.modules[index];
            //         return ModuleTile(module: module);
            //       }
            //     },
            //     separatorBuilder: (BuildContext context, int index) {
            //       return const SizedBox(
            //         height: 15,
            //       );
            //     },
            //   ),
          ),
        ));
  }
}

class FirestoreListview extends StatelessWidget {
  const FirestoreListview({
    super.key,
    required this.collection,
  });

  final CollectionReference<Module> collection;

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Module>(
      query: collection.orderBy("timestamp", descending: true),
      padding: const EdgeInsets.all(8.0),
      pageSize: 11,
      loadingBuilder: (conte) => const Center(
        child: CircularProgressIndicator(
          color: Colors.pink,
          backgroundColor: Colors.purple,
        ),
      ),
      showFetchingIndicator: true,
      fetchingIndicatorBuilder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.amber,
        ),
      ),
      itemBuilder: (context, snapshot) {
        final module = snapshot.data();
        return Column(
          children: [
            ModuleTile(module: module),
            const Divider(),
          ],
        );
      },
    );
  }
}
