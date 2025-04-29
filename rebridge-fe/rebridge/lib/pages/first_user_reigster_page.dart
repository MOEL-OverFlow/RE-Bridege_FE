import 'package:flutter/material.dart';

class FirstUserRegisterPage extends StatefulWidget {
  const FirstUserRegisterPage({super.key});

  @override
  State<FirstUserRegisterPage> createState() => _FirstUserRegisterPageState();
}

class _FirstUserRegisterPageState extends State<FirstUserRegisterPage> {
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController emailDomainController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F3FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text('Email'),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: emailIdController,
                      decoration: const InputDecoration(
                        hintText: '',
                        filled: true,
                        fillColor: Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text('@'),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: emailDomainController,
                      decoration: const InputDecoration(
                        hintText: 'Enter manually',
                        filled: true,
                        fillColor: Color(0xFFE7EBFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9DB6FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'send code',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Verification Code'),
              TextField(
                controller: verificationCodeController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFE7EBFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Password'),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText:
                      'Must be at least 8 characters long, including letters and numbers',
                  filled: true,
                  fillColor: Color(0xFFE7EBFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Password Check'),
              TextField(
                controller: passwordCheckController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Check password',
                  filled: true,
                  fillColor: Color(0xFFE7EBFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Full Name'),
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFE7EBFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Date of Birth'),
              TextField(
                controller: birthController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                  filled: true,
                  fillColor: Color(0xFFE7EBFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                ),
                readOnly: true,
                onTap: () {
                  // TODO: Date picker
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4D65E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
