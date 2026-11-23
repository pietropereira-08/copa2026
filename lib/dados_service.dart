import 'dart:convert';
import 'dart:io';
import 'package:copa_2026/selecao.dart';

class DadosService {
  Future<List<Selecao>> carregarSelecoes(Grupo grupo) async {
    print('Carregando seleções do Grupo ${grupo.name}...');
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final arquivo = File('dados_copa.json');
      final conteudo = await arquivo.readAsString();
      final Map<String, dynamic> mapa = jsonDecode(conteudo);
      final lista = mapa[grupo.name] as List<dynamic>;

      return lista
          .map((item) => Selecao.fromJson(item as Map<String, dynamic>, grupo))
          .toList();
    } catch (e) {
      print('Aviso: Lendo dados padrão ($e)');
      return [
        Selecao(nome: 'México', grupo: grupo, rankingFifa: 15),
        Selecao(nome: 'África Sul', grupo: grupo, rankingFifa: 59),
        Selecao(nome: 'Rep. Checa', grupo: grupo, rankingFifa: 36),
        Selecao(nome: 'Coreia Sul', grupo: grupo, rankingFifa: 22),
      ];
    }
  }

  static int lerInteiro(
    String prompt, {
    String mensagemErro = 'Erro: Digite um placar válido!',
    int min = 0,
    int? max,
  }) {
    while (true) {
      stdout.write(prompt);
      final entrada = stdin.readLineSync();

      try {
        if (entrada == null || entrada.trim().isEmpty) {
          throw const FormatException();
        }
        final valor = int.parse(entrada.trim());
        if (valor < min || (max != null && valor > max)) {
          print(mensagemErro);
          continue;
        }
        return valor;
      } catch (_) {
        print(mensagemErro);
      }
    }
  }
}
