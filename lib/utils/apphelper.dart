// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';

// class AppHelper{
// static Future<CroppedFile?> cropImage(File? imageFile) async {
//   var _croppedFile = await ImageCropper().cropImage(
//     sourcePath: imageFile!.path,
//     aspectRatioPresets: Platform.isAndroid
//         ? [
//             CropAspectRatioPreset.square,
//             CropAspectRatioPreset.ratio3x2,
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.ratio4x3,
//             CropAspectRatioPreset.ratio16x9
//           ]
//         : [
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.square,
//             CropAspectRatioPreset.ratio3x2,
//             CropAspectRatioPreset.ratio4x3,
//             CropAspectRatioPreset.ratio5x3,
//             CropAspectRatioPreset.ratio5x4,
//             CropAspectRatioPreset.ratio7x5,
//             CropAspectRatioPreset.ratio16x9
//           ],
//     androidUiSettings: AndroidUiSettings(
//         toolbarColor: Color(0xFF2564AF),
//         toolbarWidgetColor: Colors.white,
//         initAspectRatio: CropAspectRatioPreset.original,
//         lockAspectRatio: false),
//   );

//   return _croppedFile;
// }

// static Future<File> compress({
//     required File image,
//     int quality = 100,
//     int percentage = 30,
//   }) async {
//     var path = await FlutterNativeImage.compressImage(image.absolute.path,
//         quality: quality, percentage: percentage);
//     return path;
//   }
// }
//*******Android manifest code
// <activity
//     android:name="com.yalantis.ucrop.UCropActivity"
//     android:screenOrientation="portrait"
//     android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>