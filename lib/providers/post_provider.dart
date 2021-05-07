import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelf/models/post.dart';

class PostProvider with ChangeNotifier {
  final List<File> images = [];
  bool isUploading = false;

  createPost({
    required String text,
    required String userID,
    required String name,
    required String email,
    required String photo,
    String? replyTo,
  }) async {
    isUploading = true;
    notifyListeners();
    List<String> urls = [];
    if (images.isNotEmpty) urls = await uploadImages();
    DocumentReference reference =
        await FirebaseFirestore.instance.collection('social').add({
      'text': text,
      'user': userID,
      'photo': photo,
      'email': email,
      'name': name,
      'date': Timestamp.now(),
      'images': urls,
      'reply-to': replyTo,
      'comments': <String>[],
      'likes': <String>[],
    });
    DocumentSnapshot commentedOnPost = await FirebaseFirestore.instance
        .collection('social')
        .doc(replyTo)
        .get();

    if (replyTo != null) {
      var newList = (commentedOnPost.get('comments') as List<dynamic>)
        ..add(reference.id);
      FirebaseFirestore.instance
          .collection('social')
          .doc(replyTo)
          .update({'comments': newList});
    }

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

  Future<String> frankUploadFile(String image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('photos/${DateTime.now()}');
    UploadTask uploadTask = storageReference.putFile(File(image));
    await uploadTask.whenComplete(() {});
    String url = await storageReference.getDownloadURL();
    return url;
  }

  getImage(ImageSource source) async {
    final _picker = ImagePicker();
    PickedFile? pickedFile = await _picker.getImage(source: source);
    if (pickedFile == null) return;
    images.add(File(pickedFile.path));
    print(
        '######################## images ${images.length} #############################');
    notifyListeners();
  }

  removeImage(File image) {
    images.remove(image);
    notifyListeners();
  }

  deleteComments(List<String> comments) {
    comments.forEach((String comment) async {
      DocumentSnapshot commentPost = await FirebaseFirestore.instance
          .collection('social')
          .doc(comment)
          .get();
      deletePost(Post.fromJson(commentPost.data()!, commentPost.id));
    });
  }

  deletePost(Post post) {
    // delete post itself
    FirebaseFirestore.instance.collection('social').doc(post.id).delete();
    // delete post images
    /* if (post.images!.isNotEmpty) {
      post.images!.forEach((String image) {
        print('deleting image $image');
        Reference imageReference = FirebaseStorage.instance.ref(image);
        imageReference.delete();
      });
    }*/
    if (post.comments!.isNotEmpty) deleteComments(post.comments!);
  }
}
