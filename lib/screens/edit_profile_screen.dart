import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_auth/resources/auth_methods.dart';
import 'package:phone_auth/resposive/mobile_screen_layout.dart';
import 'package:phone_auth/utils/utils.dart';

import '../utils/colors.dart';

class EditProfileScreen extends StatefulWidget {
  final String id;
  final String name;
  final String bio;
  const EditProfileScreen(
      {Key? key, required this.id, required this.name, required this.bio})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<EditProfileScreen> {
  // static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // // for accessing firebase storage
  // static FirebaseStorage storage = FirebaseStorage.instance;
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;
  var userData = {};

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _usernameController.dispose();
  }

  // void signUpUser() async {
  //   // set loading to true
  //   setState(() {
  //     _isLoading = true;
  //   });
  // }

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);

    if (im != null) {
      setState(() {
        _image = im;
      });
    }
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      print("Testing id : " + widget.id);
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.id)
          .get();
      userData = userSnap.data()!;
    } catch (e) {
      // showSnackBar(
      //   context,
      //   e.toString(),
      // );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.deepPurple,
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(userData['photoUrl']),
                          backgroundColor: Colors.grey,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 87,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.deepPurple,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: _usernameController,
                // initialValue: widget.name,
                style: TextStyle(color: Colors.black),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-z]")),
                ],
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.deepPurple),
                    ),
                    hintText: userData['username'],
                    hintStyle: TextStyle(color: Colors.grey)),
                // hintText: 'Edit username',
                // textInputType: TextInputType.text,
                // textEditingController: _usernameController,
                onChanged: (value) {
                  _usernameController.text = value;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                // initialValue: userData['bio']!,
                controller: _bioController,
                style: TextStyle(color: Colors.black),
                inputFormatters: <TextInputFormatter>[],
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.deepPurple),
                    ),
                    hintText: userData['bio'],
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  _bioController.text = value;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  print("User name is here");
                  print(_usernameController.text);
                  AuthMethods().UpdateUser(
                    username: _usernameController.text,
                    bio: _bioController.text,
                    // bio: _bioController.text,
                    // file: _image!
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MobileScreenLayout()));
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    color: deepPurpleColor,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'Update profile',
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
