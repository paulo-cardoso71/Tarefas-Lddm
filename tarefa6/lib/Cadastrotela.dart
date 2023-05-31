import 'package:flutter/material.dart';

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
            TextField(
              controller: _nomeController,
              maxLength: 50,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _dataNascimentoController,
              decoration: InputDecoration(
                labelText: 'Data de Nascimento',
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _telefoneController,
              maxLength: 11,
              decoration: InputDecoration(
                labelText: 'Telefone',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _senhaController,
              maxLength: 20,
              decoration: InputDecoration(
                labelText: 'Senha',
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
              obscureText: _obscurePassword,
            ),
            SizedBox(height: 16.0),
            Text(
              'Notificações',
              style: TextStyle(fontSize: _fontSize),
            ),
            CheckboxListTile(
              title: Text('Receber notificações via e-mail'),
              value: _isEmailNotificationEnabled,
              onChanged: (bool? value) {
                setState(() {
                  _isEmailNotificationEnabled = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Receber notificações via telefone'),
              value: _isPhoneNotificationEnabled,
              onChanged: (bool? value) {
                setState(() {
                  _isPhoneNotificationEnabled = value ?? false;
                });
              },
            ),

            SizedBox(height: 16.0),
            Text(
              'Tamanho da Fonte',
              style: TextStyle(fontSize: _fontSize),
            ),
            Slider(
              value: _fontSize,
              min: 12.0,
              max: 24.0,
              onChanged: (newValue) {
                setState(() {
                  _fontSize = newValue;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para processar o cadastro aqui
                String nome = _nomeController.text;
                String dataNascimento = _dataNascimentoController.text;
                String telefone = _telefoneController.text;
                String email = _emailController.text;
                String senha = _senhaController.text;

                // Exemplo de exibição dos dados
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Dados do Cadastro'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Nome: $nome'),
                          Text('Data de Nascimento: $dataNascimento'),
                          Text('Telefone: $telefone'),
                          Text('E-mail: $email'),
                          Text('Senha: $senha'),
                          Text('Gênero: ${_isMaleSelected ? 'Masculino' : 'Feminino'}'),
                          Text('Receber notificações via e-mail: ${_isEmailNotificationEnabled ? 'Sim' : 'Não'}'),
                          Text('Receber notificações via telefone: ${_isPhoneNotificationEnabled ? 'Sim' : 'Não'}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Fechar'),
                        ),
                      ],
                    );
                  },
                );
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
