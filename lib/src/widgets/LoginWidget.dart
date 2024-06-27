import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/Auth/AuthService.dart';
import 'package:good_dentist_mobile/src/models/LoginResponseDTO.dart';
import 'package:good_dentist_mobile/src/screens/layout/MainLayout.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginWidgetState();
  }
}

class LoginWidgetState extends State<LoginWidget> {
  late bool passwordVisible;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      LoginResponseDTO response = await AuthService.login(username, password);
      if (!mounted) return;

      if (response.isSuccess) {
        // Giải mã JWT
        final jwt = JWT.decode(response.accessToken!);
        final payload = jwt.payload as Map<String, dynamic>;

        // Lấy role từ claim
        final role = payload[
            'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
        if (role == 'Dentist') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainLayoutScreen()),
            (Route<dynamic> route) => false,
          );
        } else {
          setState(() {
            _errorMessage = "Username or password is not correct";
          });
        }
      } else {
        setState(() {
          _errorMessage = response.message;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = "$e";
      });
    }

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text('User name', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter a user name",
                ),
              ),
              const SizedBox(height: 20),
              const Text('Password', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (_errorMessage != null) ...[
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[300],
                  foregroundColor: Colors.black,
                ),
                child: const Text('Sign In',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        if (_isLoading) ...[
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ],
    );
  }
}
