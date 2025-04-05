import 'package:apirestapp/services/api_service.dart'; // Serviço para consumir a API REST.
import 'package:flutter/material.dart'; // Pacote principal para construir interfaces no Flutter.

// Função principal que inicia o aplicativo Flutter
void main() {
  runApp(MyApp());
}

// Define o widget principal do aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retorna um MaterialApp, que é o contêiner padrão para apps Flutter
    return MaterialApp(
      home: TelaPrincipal(), // Define a tela inicial como "TelaPrincipal".
    );
  }
}

// Widget para a tela principal, que tem estado (stateful)
class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState(); // Cria o estado da tela principal.
}

// Estado da tela principal
class _TelaPrincipalState extends State<TelaPrincipal> {
  late Future<List<dynamic>> futurePosts; // Variável para armazenar o resultado da chamada da API.

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService().fetchPosts(); // Chama o método da API ao inicializar o widget.
  }

  @override
  Widget build(BuildContext context) {
    // Estrutura principal da interface da tela principal
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Posts")), // Barra superior com título.
      body: FutureBuilder<List<dynamic>>( // Widget que lida com dados assíncronos da API.
        future: futurePosts, // Define o futuro que será monitorado.
        builder: (context, snapshot) {
          // Verifica o estado da conexão e exibe a interface apropriada.
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mostra um indicador de carregamento enquanto os dados estão sendo buscados.
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Mostra uma mensagem de erro se algo der errado.
            return Center(child: Text("Erro ao carregar os dados"));
          } else {
            // Exibe os dados retornados da API em uma lista.
            return ListView.builder(
              itemCount: snapshot.data!.length, // Define o número de itens na lista.
              itemBuilder: (context, index) {
                // Monta cada item da lista como um ListTile (título e subtítulo).
                return ListTile(
                  title: Text(snapshot.data![index]['title']), // Título do post.
                  subtitle: Text(snapshot.data![index]['body']), // Corpo do post.
                );
              },
            );
          }
        },
      ),
    );
  }
}
