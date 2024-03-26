// ignore_for_file: depend_on_referenced_packages, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, unused_field, unused_element, override_on_non_overriding_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';


class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? _video;
  String? _imagePath;
  
  Future<void> _getImage(ImageSource source) async {
  final pickedFile = await _picker.pickImage(
    source: source,
  );
  
  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _imagePath=_image!.path;
    } else {
      print('No image selected.');
    }
  });
}

Future<void> _getVideo(ImageSource source) async {
  final pickedFile = await _picker.pickVideo(
    source: source,
  );

  setState(() {
    if (pickedFile != null) {
      _video = File(pickedFile.path);
      // Create a VideoPlayerController to play the video
      var _videoPlayerController = VideoPlayerController.file(_video!);
      // Initialize the controller
      _videoPlayerController.initialize().then((_) {
        setState(() {});
      });
    } else {
      print('No video selected.');
    }
  });
}

@override



Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Image Picker App'),
    ),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/homepage1.jpeg"), // Add your background image
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _getImage(ImageSource.gallery);
              },
              child: Text('Pick Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: () {
                _getVideo(ImageSource.gallery);
              },
              child: Text('Pick Video from Gallery'),
            ),
            _image != null
                ? Image.network(
                    _image!.path,
                    height: 150,
                  )
                : SizedBox(),
            _video != null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        child: VideoPlayer(_video! as VideoPlayerController),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    ),
  );
}
}

