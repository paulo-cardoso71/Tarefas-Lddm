import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarefa7/lista.dart';
import 'package:tarefa7/Cadastrotela.dart';
import 'package:tarefa7/WelcomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  bool _rememberMe = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nomeController = TextEditingController(); // Adicionado

  Future<bool> verifyUser(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String storedEmail = prefs.getString('email') ?? '';
    String storedPassword = prefs.getString('senha') ?? '';

    return email == storedEmail && password == storedPassword;
  }

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    bool isValidUser = await verifyUser(email, password);

    if (isValidUser) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen(nome: _nomeController.text, email: email)),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Dados inválidos'),
            content: Text('Usuário e/ou senha incorretos.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _navigateToCadastroTela() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadastroTela()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey, // Replace with your desired background color
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TextField(
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TextField(
                              controller: _nomeController,
                              decoration: InputDecoration(
                                labelText: 'Nome',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                          ),
                          Text('Lembrar de mim'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Login'),
                      onPressed: _login,
                    ),
                    SizedBox(height: 8.0),
                    TextButton(
                      child: Text("É novo aqui? Crie uma conta"),
                      onPressed: _navigateToCadastroTela,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        // Implement your home logic here
                      },
                    ),
                    Text('Home'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        // Implement your login logic here
                      },
                    ),
                    Text('Login'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
