import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nws_app/landing_page.dart';
import 'package:nws_app/service/auth.dart';
import 'package:nws_app/service/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

Future<String?> _showPasswordDialog() async {
  TextEditingController _passwordController = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Password'),
        content: TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Enter your password'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _passwordController.text),
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}

  
  String? profile, name, email;
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  late Future<void> loadUserDataFuture;

  @override
  void initState() {
    super.initState();
    loadUserDataFuture = _loadUserData();
  }

  Future<void> _loadUserData() async {
    profile = await SharedPreferenceHelper().getUserProfile();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
  }

  Future<void> _pickAndUploadImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {}); // Show preview

      final imageId = randomAlphaNumeric(10);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("profileImages")
          .child(imageId);
      final uploadTask = storageRef.putFile(selectedImage!);
      final downloadUrl = await (await uploadTask).ref.getDownloadURL();

      await SharedPreferenceHelper().saveUserProfile(downloadUrl);
      profile = downloadUrl;
      selectedImage = null;
      setState(() {}); // Update profile with new image
    }
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600)),
                  Text(value,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadUserDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 45, left: 20, right: 20),
                      height: MediaQuery.of(context).size.height / 4.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 105.0),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 6.5),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(60),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: GestureDetector(
                              onTap: _pickAndUploadImage,
                              child: selectedImage != null
                                  ? Image.file(selectedImage!,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover)
                                  : (profile != null
                                      ? Image.network(profile!,
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover)
                                      : Image.asset("images/img2.jpg",
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                _infoTile(Icons.person, "Name", name?? ''),
                const SizedBox(height: 20),
                _infoTile(Icons.email, "Email", email ?? ''),
                const SizedBox(height: 20),
                _infoTile(Icons.description, "Terms and Conditions", ""),
                const SizedBox(height: 20),
                GestureDetector(
                  
                    onTap: () async {
    String? password = await _showPasswordDialog();
    if (password != null && password.isNotEmpty) {
      try {
        await AuthMethods().deleteUserWithPassword(password);
        Navigator.pushReplacementNamed(context, '/signup'); // adjust as needed
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Delete failed: ${e.message}")),
        );
      }
    }
  
                  },
                  child: _infoTile(Icons.delete, "Delete Account", ""),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                   await AuthMethods().SignOut();
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LandingPage()));
                  },
                  child: _infoTile(Icons.logout, "Logout", ""),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
