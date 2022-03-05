import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/*
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}
*/

class ChangeImage extends StatelessWidget {
  const ChangeImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: const Text('showModalBottomSheet'),
        onTap: () {
          showModalBottomSheet<void>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
            ),
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  //color: Colors.lightBlueAccent,
                ),
                //color: Colors.amber,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //const Text('Modal BottomSheet'),
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Gallery'),
                      onTap: () =>
                          Navigator.of(context).pop(ImageSource.gallery),
                    ),
                    Opacity(
                      opacity: 0.2,
                      child: Divider(
                        height: 1,
                        color: Colors.blueGrey,
                        thickness: 1,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera'),
                      onTap: () =>
                          Navigator.of(context).pop(ImageSource.camera),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
