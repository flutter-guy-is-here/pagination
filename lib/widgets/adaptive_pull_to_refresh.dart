import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptivePullToRefresh extends StatelessWidget {
  const AdaptivePullToRefresh(
      {super.key,
      this.scrollController,
      required this.itemCount,
      required this.builder,
      required this.onRefresh,
      this.physics});

  final ScrollController? scrollController;
  final Widget Function(BuildContext, int) builder;
  final int itemCount;
  final ScrollPhysics? physics;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
                physics: physics ?? const AlwaysScrollableScrollPhysics(),
                itemBuilder: builder,
                controller: scrollController,
                itemCount: itemCount))
        : CustomScrollView(
            controller: scrollController,
            physics: physics ?? const BouncingScrollPhysics(),
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: onRefresh,
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(builder,
                      childCount: itemCount))
            ],
          );
  }
}
