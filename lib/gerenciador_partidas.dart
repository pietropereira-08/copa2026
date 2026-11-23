import 'package:copa_2026/dados_service.dart';
import 'package:copa_2026/selecao.dart';

class GerenciadorPartidas {
  void registrarJogo(Selecao timeA, Selecao timeB) {
    print('\n--- ${timeA.nome} x ${timeB.nome} ---');

    final golsA = DadosService.lerInteiro('Gols ${timeA.nome}: ');
    final golsB = DadosService.lerInteiro('Gols ${timeB.nome}: ');

    final amarelosA = DadosService.lerInteiro(
      'Cartões Amarelos ${timeA.nome}: ',
      mensagemErro: 'Erro: Digite um número válido de cartões!',
    );
    final vermelhosA = DadosService.lerInteiro(
      'Cartões Vermelhos ${timeA.nome}: ',
      mensagemErro: 'Erro: Digite um número válido de cartões!',
    );

    final amarelosB = DadosService.lerInteiro(
      'Cartões Amarelos ${timeB.nome}: ',
      mensagemErro: 'Erro: Digite um número válido de cartões!',
    );
    final vermelhosB = DadosService.lerInteiro(
      'Cartões Vermelhos ${timeB.nome}: ',
      mensagemErro: 'Erro: Digite um número válido de cartões!',
    );

    timeA.golsPro += golsA;
    timeA.golsSofridos += golsB;
    timeA.cartoesAmarelos += amarelosA;
    timeA.cartoesVermelhos += vermelhosA;

    timeB.golsPro += golsB;
    timeB.golsSofridos += golsA;
    timeB.cartoesAmarelos += amarelosB;
    timeB.cartoesVermelhos += vermelhosB;

    if (golsA > golsB) {
      timeA.pontos += 3;
      timeA.confrontoDireto[timeB.nome] = (timeA.confrontoDireto[timeB.nome] ?? 0) + 3;
    } else if (golsB > golsA) {
      timeB.pontos += 3;
      timeB.confrontoDireto[timeA.nome] = (timeB.confrontoDireto[timeA.nome] ?? 0) + 3;
    } else {
      timeA.pontos += 1;
      timeB.pontos += 1;
      timeA.confrontoDireto[timeB.nome] = (timeA.confrontoDireto[timeB.nome] ?? 0) + 1;
      timeB.confrontoDireto[timeA.nome] = (timeB.confrontoDireto[timeA.nome] ?? 0) + 1;
    }

    print('\nPlacar salvo: ${timeA.nome} $golsA x $golsB ${timeB.nome}');
  }
}
