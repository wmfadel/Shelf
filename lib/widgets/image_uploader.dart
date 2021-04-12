import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/uploader_provider.dart';

class ImageUploader extends StatefulWidget {
  late final PickedFile image;

  ImageUploader({required this.image});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  UploadTask? _uploadTask;

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

    uploadTask = ref.putFile(io.File(file.path), metadata);

    setState(() {
      _uploadTask = uploadTask;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    uploadFile(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TaskSnapshot>(
        stream: _uploadTask?.snapshotEvents,
        builder: (_, snapshot) {
          var event = snapshot.data;

          double progressPercent =
              event != null ? event.bytesTransferred / event.totalBytes : 0;
          if (snapshot.data?.state == TaskState.success) {
            Provider.of<UploaderProvider>(context)
                .imageFiles
                .remove(widget.image);
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(
                  io.File(widget.image.path),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: snapshot.data?.state == TaskState.paused
                      ? _uploadTask?.resume
                      : null,
                ),

                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: snapshot.data?.state == TaskState.running
                      ? _uploadTask?.pause
                      : null,
                ),

                // Progress bar
                Expanded(
                    child: LinearProgressIndicator(value: progressPercent)),
                Text('${(progressPercent * 100).toStringAsFixed(0)} % '),
              ],
            ),
          );
        });
  }
}
