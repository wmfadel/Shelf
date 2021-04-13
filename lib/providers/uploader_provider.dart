import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class UploaderProvider with ChangeNotifier {
  List<UploadTask?> uploadTasks = [];
  List<File> _imageFiles = [];

  List<File> get imageFiles => [..._imageFiles];

  addImageFile(File file) {
    _imageFiles.add(file);
    //notifyListeners();
  }

  Future<String> frankUploadFile(String _image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('posts/$_image');
    UploadTask uploadTask = storageReference.putFile(File(_image));
    await uploadTask.whenComplete(() {});

    String url = await storageReference.getDownloadURL();
    return url;
  }

  addImageToBook(String imageUrl, String userID, String bookID) async {
    QuerySnapshot doc = await FirebaseFirestore.instance
        .collection('market')
        .where('id', isEqualTo: bookID)
        .where('user-id', isEqualTo: userID)
        .get();

    String marketItem = doc.docs.first.id;
    DocumentReference marketDoc =
        FirebaseFirestore.instance.collection('market').doc(marketItem);
    DocumentSnapshot snapshot = await marketDoc.get();
    marketDoc.update(
        {'photos': (snapshot.get('photos') as List<String>)..add(imageUrl)});
  }

  uploadFile(PickedFile file) async {
    UploadTask uploadTask;
    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('playground')
        .child('/image-${DateTime.now()}.jpg');

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    uploadTask = ref.putFile(File(file.path), metadata)
      ..whenComplete(() => notifyListeners());
    uploadTasks.add(uploadTask);
    notifyListeners();
  }
}
