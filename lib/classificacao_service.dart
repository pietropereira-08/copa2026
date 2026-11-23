import 'package:copa_2026/selecao.dart';

class ClassificacaoService {
  List<Selecao> ordenar(List<Selecao> selecoes) {
    final lista = List<Selecao>.from(selecoes);

    lista.sort((a, b) {
      // Pontos
      if (b.pontos != a.pontos) return b.pontos.compareTo(a.pontos);
      // 1º Saldo de Gols
      if (b.saldoGols != a.saldoGols) return b.saldoGols.compareTo(a.saldoGols);
      // 2º Gols Pró
      if (b.golsPro != a.golsPro) return b.golsPro.compareTo(a.golsPro);
      // 3º Confronto Direto
      final ptsA = a.confrontoDireto[b.nome] ?? 0;
      final ptsB = b.confrontoDireto[a.nome] ?? 0;
      if (ptsB != ptsA) return ptsB.compareTo(ptsA);
      // 4º Menos Cartões (Fair Play)
      if (a.pontosCartoes != b.pontosCartoes) {
        return a.pontosCartoes.compareTo(b.pontosCartoes);
      }
      // 5º Ranking da FIFA (menor posição vence)
      return a.rankingFifa.compareTo(b.rankingFifa);
    });

    return lista;
  }

  void exibirTabela(List<Selecao> selecoes, Grupo grupo) {
    final tabela = ordenar(selecoes);

    print('\n=== CLASSIFICAÇÃO GRUPO ${grupo.name} - COPA 2026 ===');
    print('Pos | Seleção      | Pts | SG  | GP | Ranking FIFA');
    print('--------------------------------------------------');

    for (int i = 0; i < tabela.length; i++) {
      final s = tabela[i];
      final pos = '${i + 1}º'.padRight(3);
      final nome = s.nome.padRight(12);
      final pts = s.pontos.toString().padLeft(3);
      final sgTxt = s.saldoGols > 0 ? '+${s.saldoGols}' : '${s.saldoGols}';
      final sg = sgTxt.padLeft(3);
      final gp = s.golsPro.toString().padLeft(2);
      final rank = '${s.rankingFifa}º'.padLeft(4);

      String tag = '';
      if (i == 2) {
        tag = ' <-- Disputa 8 melhores 3ºs';
        if (s.pontos == tabela[1].pontos &&
            s.saldoGols == tabela[1].saldoGols &&
            s.golsPro == tabela[1].golsPro) {
          tag = ' <-- Definido nos critérios de desempate!';
        }
      }

      print('$pos | $nome | $pts | $sg | $gp | $rank$tag');

      if (i == 1) {
        print('-------------------------------------------------- (Zona de Classificação)');
      }
    }
    print('--------------------------------------------------\n');
  }
}
