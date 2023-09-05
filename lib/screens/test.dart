// // update profile picture of user
//   static Future<void> updateProfilePicture(File file) async {
//     //getting image file extension
//     final ext = file.path.split('.').last;
//     log('Extension: $ext');

//     //storage file ref with path
//     final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

//     //uploading image
//     await ref
//         .putFile(file, SettableMetadata(contentType: 'image/$ext'))
//         .then((p0) {
//       log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
//     });

//     //updating image in firestore database
//     me.image = await ref.getDownloadURL();
//     await firestore
//         .collection('users')
//         .doc(user.uid)
//         .update({'image': me.image});
//   }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:phone_auth/utils/utils.dart';

// Future<File?> pickImage(BuildContext context) async {
//   File? image;

//   try {
//     final pickedImage = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//     );
//     if (pickedImage != null) {
//       File photoAsFile = File(pickedImage.path);
//       // ignore: use_build_context_synchronously
//       image = await cropImage(context, photoAsFile);

//       // image = File(pickedImage.path);
//     }
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }

//   return image;
// }

// Future<File?> cropImage(context, File image) async {
//   try {
//     final croppedimage = await ImageCropper().cropImage(
//       sourcePath: image.path,
//       aspectRatioPresets: Platform.isAndroid
//           ? [
//               CropAspectRatioPreset.square,
//               CropAspectRatioPreset.ratio3x2,
//               CropAspectRatioPreset.original,
//               CropAspectRatioPreset.ratio4x3,
//               CropAspectRatioPreset.ratio16x9
//             ]
//           : [
//               CropAspectRatioPreset.original,
//               CropAspectRatioPreset.square,
//               CropAspectRatioPreset.ratio3x2,
//               CropAspectRatioPreset.ratio4x3,
//               CropAspectRatioPreset.ratio5x3,
//               CropAspectRatioPreset.ratio5x4,
//               CropAspectRatioPreset.ratio7x5,
//               CropAspectRatioPreset.ratio16x9
//             ],
//     );
//     if (croppedimage != null) {
//       image = File(croppedimage.path);
//     }
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }

//   return image;
// }
