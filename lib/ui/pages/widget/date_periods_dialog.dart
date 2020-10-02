import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/ui/pages/widget/triangle.dart';

class DatePeriodsDialog extends StatefulWidget {
  final List items;
  final double position;

  DatePeriodsDialog(this.items, {this.position});

  @override
  _DatePeriodsDialogState createState() => _DatePeriodsDialogState();
}

class _DatePeriodsDialogState extends State<DatePeriodsDialog> {
  ConstVariables constVariables;

  int selectidIndex;

  @override
  Widget build(BuildContext context) {
    constVariables = ConstVariables(context: context);
    return Stack(
      children: [
        Positioned(
          right: constVariables.screenWidth * 0.3,
          top: widget.position,
          child: CustomPaint(
            size: Size(20, 20),
            painter: DrawTriangleShape(),
          ),
        ),
        Positioned(
          left: 0,
          top: widget.position + 20,
          child: Padding(
            padding: EdgeInsets.only(
              left: constVariables.screenWidth * 0.05,
              right: constVariables.screenWidth * 0.05,
            ),
            child: Container(
              width: constVariables.screenWidth * 0.9,
              height: 260,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: this.widget.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: GestureDetector(
                            onTap: () {
                              print('index- ${index}');
                              setState(() {
                                selectidIndex = index;
                                if (index == 5) _dataPickerDialog(context);
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (selectidIndex == index)
                                    ? Icon(
                                        Icons.done,
                                        color:
                                            Color.fromARGB(255, 244, 129, 79),
                                      )
                                    : SizedBox(
                                        width: 24,
                                        height: 24,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          '${this.widget.items[index]}',
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              color: (selectidIndex != index)
                                                  ? Colors.black
                                                  : Color.fromARGB(
                                                      255, 244, 129, 79)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          indent: constVariables.screenWidth * 0.09,
                          color: Colors.grey,
                        );
                      }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

Widget _dataPickerDialog(context) {
  DateTime now = DateTime.now();
  showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050));
}
