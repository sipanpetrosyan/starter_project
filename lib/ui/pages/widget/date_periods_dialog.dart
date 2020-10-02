import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/ui/pages/widget/triangle.dart';

class DatePeriodsDialog extends StatelessWidget {
  ConstVariables constVariables;
  final List items;
  final double position;

  List<String> listItems = [
    'This week',
    'Last 30 days',
    'Last month',
    'Last 3 months',
    'Since beginning',
    'Select period'
  ];

  DatePeriodsDialog(this.items, {this.position});
  @override
  Widget build(BuildContext context) {
    constVariables = ConstVariables(context: context);
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            right: constVariables.screenWidth * 0.3,
            top: position,
            child: CustomPaint(
              size: Size(20, 20),
              painter: DrawTriangleShape(),
            ),
          ),
          Positioned(
            left: 0,
            top: position + 20,
            child: Padding(
              padding: EdgeInsets.only(
                left: constVariables.screenWidth * 0.05,
                right: constVariables.screenWidth * 0.05,
              ),
              child: Container(
                width: constVariables.screenWidth * 0.9,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: listItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.done),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(child: Text('Entry ${listItems[index]}')),
                              Divider(
                                thickness: 3,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
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
