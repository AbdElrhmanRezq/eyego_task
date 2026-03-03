import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/assets.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/init_screen_bar.dart';
import 'package:flutter/material.dart';

class InitScreenBody extends StatelessWidget {
  const InitScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    AssetsData.logo,
                    width: width * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Read the latest news",
                  style: Styles.textStyle20,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20),
                Text(
                  "Read and react with the latest news from around the world, all in one place.",
                  style: Styles.textStyle16,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: kMainColor, width: 1),
                  ),
                  child: InitScreenBar(width: width),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
