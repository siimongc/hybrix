import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1B1B1C),
            Color(0xFF2E2E2F),
            Color(0xFF3A3A3B),
            Color(0xFF474748),
          ],
          stops: [0.0, 0.3, 0.6, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 300, // Ajusta el tamaño según necesites
                height: 300,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              _buildTextField('Correo Electrónico'),
              _buildTextField('Contraseña', obscureText: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
