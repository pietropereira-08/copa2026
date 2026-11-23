enum Grupo { A, B, C, D, E, F, G, H, I, J, K, L }

class Selecao {
  final String nome;
  final Grupo grupo;
  final int rankingFifa;

  int pontos;
  int golsPro;
  int golsSofridos;
  int cartoesAmarelos;
  int cartoesVermelhos;
  final Map<String, int> confrontoDireto = {};

  Selecao({
    required this.nome,
    required this.grupo,
    required this.rankingFifa,
    this.pontos = 0,
    this.golsPro = 0,
    this.golsSofridos = 0,
    this.cartoesAmarelos = 0,
    this.cartoesVermelhos = 0,
  });

  int get saldoGols => golsPro - golsSofridos;

  // Amarelo = 1 pt | Vermelho = 4 pts (menor pontuação vence no Fair Play)
  int get pontosCartoes => cartoesAmarelos + (cartoesVermelhos * 4);

  factory Selecao.fromJson(Map<String, dynamic> json, Grupo grupo) {
    return Selecao(
      nome: json['nome'] as String,
      grupo: grupo,
      rankingFifa: json['rankingFifa'] as int,
    );
  }
}
