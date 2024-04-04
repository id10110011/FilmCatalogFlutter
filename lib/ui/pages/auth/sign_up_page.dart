import 'package:film_catalog_flutter/models/user.dart';
import 'package:film_catalog_flutter/services/auth_service.dart';
import 'package:film_catalog_flutter/services/favorites_service.dart';
import 'package:film_catalog_flutter/services/user_service.dart';
import 'package:film_catalog_flutter/ui/pages/auth/login_page.dart';
import 'package:film_catalog_flutter/ui/pages/home_page.dart';
import 'package:film_catalog_flutter/ui/toast/toast.dart';
import 'package:film_catalog_flutter/ui/widgets/input_container_widget.dart';
import 'package:film_catalog_flutter/validator/validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();
  final UserService _userService = UserService();
  final FavoritesService _favoritesService = FavoritesService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Registration",
                      style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 30,
                  ),
                  FormContainerWidget(
                    controller: _emailController,
                    hintText: "Email",
                    isPasswordField: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                    controller: _nameController,
                    hintText: "Name",
                    isPasswordField: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                    controller: _passwordController,
                    hintText: "Password",
                    isPasswordField: true,
                    validator: (value) => Validator.validatePassword(value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                    controller: _rePasswordController,
                    hintText: "Re-password",
                    isPasswordField: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: _signUp,
                    child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text("Sign up",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17))))
                  ),
                  const SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 5,),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                        },
                        child: const Text("Already have an account? Login"),
                      )
                    ],
                  )
                ],
              ),
            )
        )
    );
  }

  void _signUp() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String rePassword = _rePasswordController.text;

    if (_validateFields(email, password, rePassword, name)) {
      User user = User.fromRegistration(email, name);
      firebase.User? fbUser = await _auth.signUpWithEmailAndPassword(
          email, password);

      if (fbUser != null) {
        bool result = await _userService.saveUser(user);
        await _favoritesService.createFavoritesMovies(user.email);
        if (result) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
        }
      }
    }
  }

  bool _validateFields(String email, String password, String rePassword, String name) {
    String? result = Validator.validateEmail(email);
    if (result != null) {
      showToast(message: result);
      return false;
    }
    result = Validator.validateName(name);
    if (result != null) {
      showToast(message: result);
      return false;
    }
    result = Validator.validatePassword(password);
    if (result != null) {
      showToast(message: result);
      return false;
    }
    if (rePassword != password) {
      showToast(message: "Passwords must be same");
      return false;
    }
    return true;
  }

}
