import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarefa7/lista.dart'; // Import the ItemListPage class from the lista.dart file
import 'package:tarefa7/main.dart';
class WelcomeScreen extends StatefulWidget {
  final String nome;
  final String email;

  WelcomeScreen({required this.nome, required this.email});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  String _savedNome = '';
  String _savedDataNascimento = '';
  String _savedTelefone = '';

  @override
  void initState() {
    super.initState();

    _widgetOptions = <Widget>[
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo(a), ${widget.nome}!',
              style: TextStyle(fontSize: 24.0),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Voltar para a tela anterior
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
      ItemListPage(nome: widget.nome), // Adiciona a página ItemListPage
      _buildProfileScreen(), // Use the custom profile screen
    ];

    _getUserInfo();
  }

  void _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _savedNome = prefs.getString('nome') ?? '';
      _savedDataNascimento = prefs.getString('dataNascimento') ?? '';
      _savedTelefone = prefs.getString('telefone') ?? '';
    });
  }

  Widget _buildProfileScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profile Screen',
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 16.0),
          Text('Nome: $_savedNome'),
          Text('E-mail: ${widget.email}'),
          Text('Data de Nascimento: $_savedDataNascimento'),
          Text('Telefone: $_savedTelefone'),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItemListPage(nome: widget.nome),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
