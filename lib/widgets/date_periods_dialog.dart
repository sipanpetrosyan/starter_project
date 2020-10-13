import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/widgets/triangle.dart';

class DatePeriodsDialog extends StatefulWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final double position;
  final double rightPadding;
  int selectedItem;

  DatePeriodsDialog(
      {this.itemBuilder,
      this.position,
      this.selectedItem,
      this.rightPadding,
      this.itemCount});

  @override
  _DatePeriodsDialogState createState() => _DatePeriodsDialogState();
}

class _DatePeriodsDialogState extends State<DatePeriodsDialog> {
  ConstVariables constVariables =ConstVariables();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: widget.rightPadding,
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
                      itemCount: this.widget.itemCount,
                      itemBuilder: widget.itemBuilder,
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

Widget _thirtyDate() {}
Widget _mountDate() {
  DateTime now = DateTime.now();
  var prevMonth = new DateTime(now.year, now.month - 1, now.day);
  print(prevMonth);
}
