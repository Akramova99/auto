import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDialog {
  showDialogBox(BuildContext context) => showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("You appear to be offline"),
          content: Text(
              "You can't use this app until ypu're connected to the internet"),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text("OK"))
          ],
        );
      });
}



