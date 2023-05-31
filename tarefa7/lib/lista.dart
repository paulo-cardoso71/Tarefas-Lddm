import 'package:flutter/material.dart';

class ItemListPage extends StatelessWidget {
  final List<String> items = List.generate(25, (index) => 'Item ${index + 1}');
  final String nome; // Adicione o parâmetro nome

  ItemListPage({required this.nome}); // Atualize o construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo(a), $nome'), // Atualize o título do AppBar
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Item ${index + 1}'),
                    content: Text('Você clicou no ${items[index]}'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Sim'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
