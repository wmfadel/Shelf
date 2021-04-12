import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/uploader_provider.dart';
import 'package:shelf/widgets/image_uploader.dart';

class AddPhotoView extends StatefulWidget {
  final String bookID;

  AddPhotoView({required this.bookID});

  @override
  _AddPhotoViewState createState() => _AddPhotoViewState();
}

class _AddPhotoViewState extends State<AddPhotoView> {
  late UploaderProvider uploaderProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    uploaderProvider = Provider.of<UploaderProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /*  IconButton(
                onPressed: _imageFiles.isEmpty ? null : () {},
                icon: Icon(
                  Icons.imagesearch_roller,
                ),
              ),*/
              IconButton(
                onPressed: () async {
                  PickedFile? file = await getImage(ImageSource.gallery);
                  if (file != null) uploaderProvider.imageFiles.add(file);
                  setState(() {});
                },
                icon: Icon(
                  Icons.photo,
                ),
              ),
              IconButton(
                onPressed: () async {
                  PickedFile? file = await getImage(ImageSource.camera);
                  if (file != null) uploaderProvider.imageFiles.add(file);
                  setState(() {});
                },
                icon: Icon(
                  Icons.camera_alt,
                ),
              ),
            ],
          ), // end of actions row
          Divider(),
          SizedBox(height: 10),
          if (uploaderProvider.imageFiles.isEmpty)
            Text('No Images being uploaded'),
          if (uploaderProvider.imageFiles.isNotEmpty)
            ...uploaderProvider.imageFiles
                .map(
                  (PickedFile? image) => ImageUploader(image: image!),
                )
                .toList()
        ],
      ),
    );
  }

  Future<PickedFile?> getImage(ImageSource source) async {
    final picker = ImagePicker();
    return await picker.getImage(source: source);
  }
}
