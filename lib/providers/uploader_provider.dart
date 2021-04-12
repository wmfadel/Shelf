import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class UploaderProvider with ChangeNotifier {
  List<PickedFile?> imageFiles = [];
}
