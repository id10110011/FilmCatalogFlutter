import 'package:film_catalog_flutter/services/user_service.dart';
import 'package:film_catalog_flutter/ui/toast/toast.dart';
import 'package:film_catalog_flutter/validator/validator.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../widgets/input_container_widget.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UserService _userService = UserService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _backOnPressed() {
    Navigator.pop(context);
  }

  void _saveUserOnPressed() {
    String? result = Validator.validateName(_firstnameController.text);
    if (result == null) {
      User user = User(
          _emailController.text,
          _firstnameController.text,
          _lastnameController.text,
          _dateOfBirthController.text,
          _cityController.text,
          _countryController.text,
          _genderController.text,
          _educationController.text,
          _descriptionController.text);
      _userService.saveUser(user);
      _backOnPressed();
    } else {
      showToast(message: result);
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.user.email;
    _firstnameController.text = widget.user.firstname;
    _lastnameController.text = widget.user.lastname;
    _dateOfBirthController.text = widget.user.dateOfBirth;
    _cityController.text = widget.user.city;
    _countryController.text = widget.user.county;
    _genderController.text = widget.user.gender;
    _educationController.text = widget.user.education;
    _descriptionController.text = widget.user.description;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _dateOfBirthController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _genderController.dispose();
    _educationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: _backOnPressed),
                  const SizedBox(width: 17,),
                  const Text(
                    "Edit profile",
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.white),
                    onPressed: _saveUserOnPressed,
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white12,
              padding: const EdgeInsets.all(20),
              child: Expanded(
                child: SingleChildScrollView (
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormContainerWidget(
                        maxLength: 80,
                        isEnabled: false,
                        hintText: "Email",
                        controller: _emailController,
                        isPasswordField: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormContainerWidget(
                        maxLength: 80,
                        controller: _firstnameController,
                        hintText: "Firstname",
                        isPasswordField: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormContainerWidget(
                        maxLength: 80,
                        controller: _lastnameController,
                        hintText: "Lastname",
                        isPasswordField: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormContainerWidget(
                        maxLength: 80,
                        controller: _dateOfBirthController,
                        hintText: "Date of Birth",
                        isPasswordField: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormContainerWidget(
                        maxLength: 80,
                        controller: _cityController,
                        hintText: "City",
                        isPasswordField: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormContainerWidget(
                        maxLength: 80,
                        controller: _countryController,
                        hintText: "Country",
                        isPasswordField: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormContainerWidget(
                        maxLength: 80,
                        controller: _genderController,
                        hintText: "Gender",
                        isPasswordField: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormContainerWidget(
                        maxLength: 80,
                        controller: _educationController,
                        hintText: "Education",
                        isPasswordField: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormContainerWidget(
                        maxLength: 2000,
                        controller: _descriptionController,
                        hintText: "Description",
                        isPasswordField: false,
                      ),
                    ]
                  )
                )
              ),
            )
          ]
        )
      )
    );
  }
}
