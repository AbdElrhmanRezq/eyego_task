import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/core/widgets/simple_app_bar.dart';
import 'package:eyego_task/features/profile/data/repo/statistics_repo.dart';
import 'package:eyego_task/features/profile/data/repo/statistics_repo_impl.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final StatisticsRepoImpl s = StatisticsRepoImpl();
    return Scaffold(
      appBar: SimpleAppBar(),
      body: Column(
        children: [
          FutureBuilder(
            future: s.getStatistics(),
            builder: (context, snapshot) => Container(
              height: height * 0.7,

              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: height * 0.1,
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 32,
                          color: Colors.black,
                        ),
                        title: Text(
                          "users Count: ${snapshot.data?["users_count"]}",
                          style: Styles.textStyle30.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: height * 0.1,

                      child: ListTile(
                        leading: Icon(
                          Icons.article,
                          size: 32,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Saved articles: ${snapshot.data?["articles_count"]}",
                          style: Styles.textStyle30.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
