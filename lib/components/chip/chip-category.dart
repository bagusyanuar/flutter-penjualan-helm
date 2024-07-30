import 'package:app_sadean_helm/components/chip/chip.dart';
import 'package:app_sadean_helm/components/shimmer/custom-shimmer.dart';
import 'package:app_sadean_helm/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChipCategory extends StatelessWidget {
  final List<Category> data;
  final int selectedChip;
  final bool onLoading;
  final Function(int key, int id) onChipChange;

  const ChipCategory({
    Key? key,
    required this.data,
    required this.selectedChip,
    required this.onLoading,
    required this.onChipChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onLoading
        ? Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [1, 2, 3, 4, 5, 6].map((e) {
                return Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: const CustomShimmer(
                    height: 35,
                    width: 120,
                    radius: 10,
                  ),
                );
              }).toList(),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: data.map((e) {
                int key = data.indexOf(e);
                bool isSelected = key == selectedChip;
                return CustomChip(
                  text: e.name.toString(),
                  isSelected: isSelected,
                  onTap: () {
                    onChipChange(key, e.id);
                  },
                );
              }).toList(),
            ),
          );
  }
}
