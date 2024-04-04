import 'package:film_catalog_flutter/models/user.dart';
import 'package:film_catalog_flutter/services/auth_service.dart';
import 'package:film_catalog_flutter/services/user_service.dart';
import 'package:film_catalog_flutter/ui/pages/profile/edit_profile_page.dart';
import 'package:flutter/material.dart';

import '../auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final FirebaseAuthService _auth = FirebaseAuthService();
  final UserService _userService = UserService();

  User _user = User.empty();

  void _fetchUser() async {
    User user = await _userService.getUser(_auth.getCurrentUser()!.email);
    setState(() {
      _user = user;
    });
  }

  void _editUserOnPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
      EditProfilePage(user: _user,)));
  }

  void _signOutOnPressed() {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
      const LoginPage()), (route) => false);
  }

  void _deleteUserOnPressed() async {
    bool result = await _userService.deleteUser(_user.email);
    if (result) {
      _auth.deleteUser();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
        const LoginPage()), (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fetchUser();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.black,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: _editUserOnPressed
                ),
                const SizedBox(width: 10,),
                IconButton(
                  icon: const Icon(
                    Icons.door_sliding,
                    color: Colors.white,
                  ),
                  onPressed: _signOutOnPressed
                ),
                const SizedBox(width: 10,),
                IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                  onPressed: _deleteUserOnPressed
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white12,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "Email"
                  ),
                  Text(
                    _user.email,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                      "Firstname"
                  ),
                  Text(
                    _user.firstname,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                      "Lastname"
                  ),
                  Text(
                    _user.lastname,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                      "Date of Birth"
                  ),
                  Text(
                    _user.dateOfBirth,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                      "City"
                  ),
                  Text(
                    _user.city,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                      "Country"
                  ),
                  Text(
                    _user.county,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                      "Gender"
                  ),
                  Text(
                    _user.gender,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                      "Education"
                  ),
                  Text(
                    _user.education,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                      "Description"
                  ),
                  Text(
                    _user.description,
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}