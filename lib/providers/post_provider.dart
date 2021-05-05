import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class PostProvider with ChangeNotifier {
  final List<File> images = [];
  bool isUploading = false;

  createPost(String text, String userID) async {
    isUploading = true;
    notifyListeners();
    List<String> urls = await uploadImages();
    FirebaseFirestore.instance.collection('social').add({
      'text': text,
      'user': userID,
      'date': Timestamp.now(),
      'images': urls,
      'reply-to': null,
      'comments': <String>[],
      'likes': <String>[],
    });
    images.clear();
    isUploading = false;
    notifyListeners();
  }

  Future<List<String>> uploadImages() async {
    List<String> urls = [];
    for (var i in images) {
      String url = await frankUploadFile(i.path);
      urls.add(url);
    }
    return urls;
  }

  Future<String> frankUploadFile(String _image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('photos/${DateTime.now()}');
    UploadTask uploadTask = storageReference.putFile(File(_image));
    await uploadTask.whenComplete(() {});
    String url = await storageReference.getDownloadURL();
    return url;
  }

  getImage(ImageSource source) async {
    final _picker = ImagePicker();
    PickedFile? pickedFile = await _picker.getImage(source: source);
    if (pickedFile == null) return;

    images.add(File(pickedFile.path));
    notifyListeners();
  }

  removeImage(File image) {
    images.remove(image);
    notifyListeners();
  }
}
