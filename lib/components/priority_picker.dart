import 'package:flutter/material.dart';

class PriorityPicker extends StatelessWidget {
  final Function(int) onTap;
  final int selectedIndex;

  const PriorityPicker({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final List<String> priorityText = ['Low', 'High', 'Very High'];
    final List<Color> priorityColor = [
      Colors.green,
      Colors.lightGreen,
      Colors.red,
    ];
    return SizedBox(
      width: width,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
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
              width: width / 3,
              height: 70,
              child: Container(
                child: Center(
                  child: Text(
                    priorityText[index],
                    style: TextStyle(
                      color:
                          selectedIndex == index ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? priorityColor[index]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  border: selectedIndex == index
                      ? Border.all(width: 2, color: Colors.black)
                      : Border.all(width: 0, color: Colors.transparent),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
