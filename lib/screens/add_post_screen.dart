import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_auth/providers/user_provider.dart';
import 'package:phone_auth/resources/firestore_methods.dart';
import 'package:phone_auth/resposive/mobile_screen_layout.dart';
import 'package:phone_auth/utils/colors.dart';
import 'package:phone_auth/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.deepPurple,
          title:
              const Text('Create a Post', style: TextStyle(letterSpacing: 1)),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(1),
                child: const ListTile(
                  leading: Image(
                    image: AssetImage('assets/camera.png'),
                    height: 40,
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      'Camera',
                      style: TextStyle(letterSpacing: 1),
                    ),
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(1),
                child: const ListTile(
                  leading: Image(
                    image: AssetImage('assets/gallery.png'),
                    height: 45,
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Gallery',
                      style: TextStyle(letterSpacing: 1),
                    ),
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(1),
              child: const ListTile(
                leading: Image(
                  image: AssetImage('assets/cancel.png'),
                  height: 39,
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 9),
                  child: Text(
                    'Cancel',
                    style: TextStyle(letterSpacing: 1),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MobileScreenLayout()));
        setState(() {
          isLoading = false;
        });
        if (context.mounted) {
          showSnackBar(
            context,
            'Posted!',
          );
        }
        clearImage();
      } else {
        if (context.mounted) {
          showSnackBar(context, res);
        }
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: _file == null
          ? Center(
              child: IconButton(
                icon: const Icon(
                  Icons.add_a_photo,
                  color: deepPurpleColor,
                  size: 40,
                ),
                onPressed: () => _selectImage(context),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: clearImage,
                ),
                title: const Text(
                  'Post',
                ),
                centerTitle: false,
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      postImage(
                        userProvider.getUser.uid,
                        userProvider.getUser.username,
                        userProvider.getUser.photoUrl,
                      );
                    },
                    child: const Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  )
                ],
              ),
              // POST FORM
              body: Column(
                children: <Widget>[
                  isLoading
                      ? const LinearProgressIndicator(
                          color: Colors.deepPurple,
                          backgroundColor: Colors.white,
                        )
                      : const Padding(padding: EdgeInsets.only(top: 0.0)),
                  const Divider(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //     userProvider.getUser.photoUrl,
                          //   ),
                          // ),
                          SizedBox(
                            height: 380,
                            width: 350,
                            child: AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter,
                                  image: MemoryImage(_file!),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: SizedBox(
                          // width: MediaQuery.of(context).size.width * 0.3,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: _descriptionController,
                            cursorColor: Colors.deepPurple,
                            decoration: const InputDecoration(
                                // prefixIcon:,

                                enabledBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 109, 41, 197)),
                                ),
                                hintText: "Write a caption...",
                                hintStyle: TextStyle(color: Colors.grey)
                                // border: InputBorder.none
                                ),
                            minLines: 1,
                            maxLines: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
    );
  }
}
