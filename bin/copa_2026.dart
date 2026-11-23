import 'package:copa_2026/classificacao_service.dart';
import 'package:copa_2026/dados_service.dart';
import 'package:copa_2026/gerenciador_partidas.dart';
import 'package:copa_2026/selecao.dart';

Future<void> main() async {
  const grupoAtual = Grupo.A;
  final dadosService = DadosService();
  final gerenciador = GerenciadorPartidas();
  final classificacao = ClassificacaoService();

  final selecoes = await dadosService.carregarSelecoes(grupoAtual);

  while (true) {
    print('\n=== SIMULADOR GRUPO ${grupoAtual.name} - COPA 2026 ===');
    print('1. Registrar Resultado de Jogo');
    print('2. Ver Classificação Atual');
    print('3. Sair');

    final opcao = DadosService.lerInteiro(
      '\nOpção: ',
      mensagemErro: 'Erro: Digite 1, 2 ou 3!',
      min: 1,
      max: 3,
    );

    if (opcao == 1) {
      print('\nEscolha os times:');
      for (int i = 0; i < selecoes.length; i++) {
        print('${i + 1}. ${selecoes[i].nome}');
      }

      final idxA = DadosService.lerInteiro(
            'Time A (1-4): ',
            mensagemErro: 'Erro: Escolha um time de 1 a 4!',
            min: 1,
            max: selecoes.length,
          ) -
          1;

      int idxB;
      while (true) {
        idxB = DadosService.lerInteiro(
              'Time B (1-4): ',
              mensagemErro: 'Erro: Escolha um time de 1 a 4!',
              min: 1,
              max: selecoes.length,
            ) -
            1;
        if (idxB != idxA) break;
        print('Erro: Selecione um adversário diferente!');
      }

      gerenciador.registrarJogo(selecoes[idxA], selecoes[idxB]);
    } else if (opcao == 2) {
      classificacao.exibirTabela(selecoes, grupoAtual);
    } else {
      print('Saindo...');
      break;
    }
  }
}
