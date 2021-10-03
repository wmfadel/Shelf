import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/uploader_provider.dart';

class ImageUploaderPage extends StatefulWidget {
  static final String routeName = 'ImageUploader_page';

  @override
  _ImageUploaderPageState createState() => _ImageUploaderPageState();
}

class _ImageUploaderPageState extends State<ImageUploaderPage> {
  late String bookID;
  late Size size;
  late UploaderProvider uploaderProvider;
  File? file;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    uploaderProvider = Provider.of<UploaderProvider>(context);
    bookID = ModalRoute.of(context)?.settings.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: file == null ? null : cancelImage,
                icon: Icon(Icons.cancel_presentation_rounded)),
            IconButton(
                onPressed: file == null ? null : uploadImage,
                icon: Icon(Icons.upload_file)),
            IconButton(
                onPressed: file == null ? null : editImage,
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () => getImage(ImageSource.gallery),
                icon: Icon(Icons.photo_library)),
            IconButton(
                onPressed: () => getImage(ImageSource.gallery),
                icon: Icon(Icons.camera_alt)),
          ],
        ),
        Divider(),
        Container(
          height: 250,
          width: size.width,
          child: Center(
            child: file == null
                ? Icon(
                    Icons.broken_image_rounded,
                    color: Colors.grey,
                  )
                : Image.file(
                    file!,
                    height: 240,
                    fit: BoxFit.fitHeight,
                  ),
          ),
        ),
        Divider(),
        for (int i = 0; i < uploaderProvider.imageFiles.length; i++)
          uploadView(uploaderProvider.imageFiles[i]),
      ]),
    );
  }

  uploadImage() async {
    uploaderProvider.addImageFile(file!);
    File tempFile = file!;
    setState(() {
      file = null;
    });
    String url = await uploaderProvider.frankUploadFile(tempFile.path);
    uploaderProvider.addImageToBook(
      url,
      Provider.of<AuthProvider>(context, listen: false).uid!,
      bookID,
    );
  }

  Widget uploadView(File file) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: [
          Image.file(
            file,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(file.path),
          ),
        ],
      ),
    );
  }

  getImage(ImageSource source) async {
    final _picker = ImagePicker();
    XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;
    setState(() {
      file = File(pickedFile.path);
    });
  }

  cancelImage() {
    setState(() {
      file = null;
    });
  }

  editImage() async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: file!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    if (croppedFile == null) return;
    setState(() {
      file = croppedFile;
    });
  }
}
