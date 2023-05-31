import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroTela extends StatefulWidget {
  @override
  _CadastroTelaState createState() => _CadastroTelaState();
}

class _CadastroTelaState extends State<CadastroTela> {
  bool _obscurePassword = true;
  bool _isEmailNotificationEnabled = false;
  bool _isPhoneNotificationEnabled = false;
  bool _isMaleSelected = false;
  bool _isFemaleSelected = false;
  double _fontSize = 16.0;

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _dataNascimentoController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  void saveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String nome = _nomeController.text;
    String dataNascimento = _dataNascimentoController.text;
    String telefone = _telefoneController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    await prefs.setString('nome', nome);
    await prefs.setString('dataNascimento', dataNascimento);
    await prefs.setString('telefone', telefone);
    await prefs.setString('email', email);
    await prefs.setString('senha', senha);
    await prefs.setBool('isEmailNotificationEnabled', _isEmailNotificationEnabled);
    await prefs.setBool('isPhoneNotificationEnabled', _isPhoneNotificationEnabled);
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _nomeController.text = prefs.getString('nome') ?? '';
      _dataNascimentoController.text = prefs.getString('dataNascimento') ?? '';
      _telefoneController.text = prefs.getString('telefone') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _senhaController.text = prefs.getString('senha') ?? '';
      _isEmailNotificationEnabled = prefs.getBool('isEmailNotificationEnabled') ?? false;
      _isPhoneNotificationEnabled = prefs.getBool('isPhoneNotificationEnabled') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar conta'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Nome:',
              style: TextStyle(fontSize: _fontSize),
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(hintText: 'Digite seu nome'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Data de Nascimento:',
              style: TextStyle(fontSize: _fontSize),
            ),
            TextField(
              controller: _dataNascimentoController,
              decoration: InputDecoration(hintText: 'Digite sua data de nascimento'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Telefone:',
              style: TextStyle(fontSize: _fontSize),
            ),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(hintText: 'Digite seu telefone'),
            ),
            SizedBox(height: 16.0),
            Text(
              'E-mail:',
              style: TextStyle(fontSize: _fontSize),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Digite seu e-mail'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Senha:',
              style: TextStyle(fontSize: _fontSize),
            ),
            TextField(
              controller: _senhaController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: 'Digite sua senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Notificações:',
              style: TextStyle(fontSize: _fontSize),
            ),
            CheckboxListTile(
              title: Text('E-mail'),
              value: _isEmailNotificationEnabled,
              onChanged: (value) {
                setState(() {
                  _isEmailNotificationEnabled = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Telefone'),
              value: _isPhoneNotificationEnabled,
              onChanged: (value) {
                setState(() {
                  _isPhoneNotificationEnabled = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                saveUser(); // Salvar os dados do usuário

                // Restante do código
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CadastroTela(),
  ));
}
