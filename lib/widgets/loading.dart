import 'package:flutter/material.dart';

class AppDialogs {
  final BuildContext context;

  AppDialogs(this.context);

  showLoading() {
    Center alert = Center(
      child: Container(
        // color: Colors.red,
        width: 210,
        height: 100,
        child: Column(
          children: [
            Theme(
              data: Theme.of(context)
                  .copyWith(accentColor: Color.fromARGB(255, 244, 129, 79)),
              child: new CircularProgressIndicator(),
            ),
            // Text(
            //   "Loading...",
            //   style: TextStyle(
            //       color: Color.fromARGB(255, 244, 129, 79), fontSize: 15),
            // ),
          ],
        ),
      ),
    );
    /*AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: 70,
        color: Colors.transparent,
        child: new Column(
          children: [
            // CircularProgressIndicator(),
            Theme(
              data: Theme.of(context)
                  .copyWith(accentColor: Color.fromARGB(255, 244, 129, 79)),
              child: new CircularProgressIndicator(),
            ),
            Container(
                child: Text(
              "Loading...",
              style: TextStyle(color: Color.fromARGB(255, 244, 129, 79)),
            )),
          ],
        ),
      ),
    );*/
    showDialog(
      // barrierColor: Color.fromARGB(255, 180, 180, 180),
      barrierDismissible: false,
      context: this.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
