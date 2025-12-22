import 'package:eyego_task/consts.dart';
import 'package:eyego_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

class FilterRow extends StatelessWidget {
  FilterRow({
    super.key,
    required this.onChanged,
    required this.selectedCategory,
    this.type = 'Showing',
    required this.items,
  });
  void Function(String?)? onChanged;
  String selectedCategory;
  String type;
  List<String> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$type: ", style: Styles.textStyle20),
        DropdownButton<String>(
          value: selectedCategory,
          style: Styles.textStyle20,
          iconEnabledColor: kMainColor,
          isDense: true,
          underline: SizedBox(),
          items: items
              .map(
                (c) => DropdownMenuItem<String>(
                  value: c,
                  child: Text(
                    c[0].toUpperCase() + c.substring(1),
                    style: Styles.textStyle20.copyWith(
                      color: selectedCategory == c ? kMainColor : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
