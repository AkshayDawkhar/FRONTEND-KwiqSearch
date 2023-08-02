import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/controller/home.dart';

class NotificationsPage extends StatelessWidget {
  UnitController unitController = Get.put(UnitController());
  FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        onRefresh: () => unitController.init(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Text('name'),
        ),
      ),
    );
  }
}
