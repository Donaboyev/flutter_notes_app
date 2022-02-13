import 'package:flutter/material.dart';
import '../utils/app_helper.dart';

class ColorPicker extends StatelessWidget {
  final Function(int) onTap;
  final int? selectedIndex;

  const ColorPicker({Key? key, this.selectedIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppHelper.colors.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              // setState(() {
              //   selectedIndex = index;
              // });
              onTap(index);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 50,
              height: 50,
              child: Container(
                child: Center(
                  child: selectedIndex == index
                      ? const Icon(Icons.done)
                      : Container(),
                ),
                decoration: BoxDecoration(
                  color: AppHelper.colors[index],
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
