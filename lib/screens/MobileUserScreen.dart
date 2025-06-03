import 'package:flutter/material.dart';
import 'package:untitled/controller/MobileUserController.dart';
import 'package:untitled/models/mobileuser/MobileUser.dart';

class MobileUserScreen extends StatefulWidget {
  const MobileUserScreen({super.key});

  @override
  State<MobileUserScreen> createState() => _MobileUserScreenState();
}

class _MobileUserScreenState extends State<MobileUserScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _getMobileUser() async {
    setState(() {
      _isLoading = true;
    });
    MobileUser? response =  await MobileUserController.getMobileUser();
    setState(() {
      _emailController.text = response!.email;
      _passwordController.text = response!.password;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mobile User')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () => MobileUserController.updateMobileUser(23, _emailController.text, _passwordController.text),
                child: Text('Update Mobile User'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => MobileUserController.deleteMobileUser(24),
                child: Text('Delete Mobile User'),
              ),
              ElevatedButton(
                onPressed: _getMobileUser,
                child: _isLoading ? CircularProgressIndicator() : Text('Get Mobile User'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.pushReplacementNamed(context, '/register')
          }),
    );
  }
}
