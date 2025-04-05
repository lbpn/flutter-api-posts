import 'dart:convert'; // Pacote para decodificar JSON.
import 'package:http/http.dart' as http; // Pacote para fazer requisições HTTP.

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com"; // URL base da API.

  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts')); // Faz a requisição GET para obter os posts.

    if (response.statusCode == 200) {
      // Se a requisição foi bem-sucedida, decodifica o corpo da resposta JSON.
      return json.decode(response.body);
    } else {
      // Se a requisição falhar, lança uma exceção com mensagem de erro.
      throw Exception("Falha ao carregar os dados");
    }
  }
}
