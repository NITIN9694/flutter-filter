
//  image_picker: ^0.8.6


import 'package:image_picker/image_picker.dart';

var imagePath = "";

pickImage(ImageSource.camera);

pickImage(ImageSource.camera);

pickImage(ImageSource imageSource) async {
    var date = DateTime.now();
    String imgPath = date.millisecondsSinceEpoch.toString();
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: imageSource);
    print('picked image');
    if (image!.path.isNotEmpty) {
      print('picked image not empty');
      imagePath = image.path;
    }

    // Compress
    final dir = Directory.systemTemp;
    final targetPath = dir.absolute.path + "/$imgPath.jpg";
    var compressedFile = await FlutterImageCompress.compressAndGetFile(image.path, targetPath, quality: 90);
  }