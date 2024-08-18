import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_odyssey/utils/spacer.dart';
import 'package:quiz_odyssey/utils/white_loading.dart';

import '../controllers/db_controller.dart';
import '../theme/colors.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dbc = Get.find<DBController>();
    dbc.fetchAllUsers();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: navBarColor,
        title: const Text(
          'Leaderboard',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => dbc.isLoading.value
            ? whiteCircleLoading()
            : ListView.builder(
                itemCount: dbc.allUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    tileColor: tileColor(index),
                    leading: Text((index + 1).toString()),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                foregroundImage:
                                    dbc.allUsers[index].avatarUrl.isEmpty
                                        ? const AssetImage(
                                            "assets/images/default_avatar.jpg")
                                        : NetworkImage(
                                            dbc.allUsers[index].avatarUrl),
                              ),
                              horizontalSpacer(16),
                              Expanded(
                                child: Text(dbc.allUsers[index].name),
                              ),
                            ],
                          ),
                        ),
                        horizontalSpacer(20),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/coins.png',
                              height: 20,
                            ),
                            horizontalSpacer(8),
                            Text(dbc.allUsers[index].coins.toString())
                          ],
                        )
                      ],
                    ),
                    // trailing: ,

                    textColor: Colors.white,
                  );
                },
              ),
      ),
    );
  }

  Color tileColor(int index) {
    switch (index) {
      case 0:
        return riseShine;
      case 1:
        return Colors.grey;
      case 2:
        return orangeville;
      default:
        return Colors.transparent;
    }
  }
}
