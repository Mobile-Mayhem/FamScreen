import 'dart:io';

import 'package:famscreen/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MlTestPage extends StatefulWidget {
  const MlTestPage({super.key});

  @override
  State<MlTestPage> createState() => _MlTestPageState();
}

class _MlTestPageState extends State<MlTestPage> {
  File? _image;
  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> sendImage() async {
    if (_image == null) {
      print('No image to send.');
      return;
    }

    final url = Uri.parse('http://127.0.0.1:8004/upload');

    try {
      var request = http.MultipartRequest('POST', url);
      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('ML Test Page', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected.')
                : Image.file(_image!),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: getImageFromGallery,
                  child: const Text('Select Image'),
                ),
                IconButton(
                    onPressed: sendImage,
                    icon: Icon(Icons.send, color: CustomColor.primary)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
