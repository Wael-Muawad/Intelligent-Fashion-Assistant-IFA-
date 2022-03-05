import 'package:flutter/material.dart';

class SnackBarPage extends StatelessWidget {
  //const SnackBarPage({Key? key}) : super(key: key);
  final String errorText;

  SnackBarPage(
      {
        this.errorText ='',
      }
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text(errorText),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}