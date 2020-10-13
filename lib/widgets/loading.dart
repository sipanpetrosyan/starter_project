import 'package:flutter/material.dart';

class AppDialogs {
  final BuildContext context;

  AppDialogs(this.context);

  showLoading() {
    Center alert = Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 210,
          height: 100,
          child: Column(
            children: [
              Theme(
                data: Theme.of(context)
                    .copyWith(accentColor: Color.fromARGB(255, 244, 129, 79)),
                child: new CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "Loading...",
                  style: TextStyle(
                      color: Color.fromARGB(255, 244, 129, 79),
                      fontSize: 17,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: this.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
