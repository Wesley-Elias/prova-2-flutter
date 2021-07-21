class Musicas {
  String id = "";
  String nomeMusica = "";
  String duracao = "";
  String estilo = "";

  Musicas({
    required this.id,
    required this.nomeMusica,
    required this.duracao,
    required this.estilo,
  });

  Musicas.fromJson(Map<String, dynamic> json, String key) {
    id = key;
    nomeMusica = json["nomeMusica"].toString();
    duracao = json["duracao"].toString();
    estilo = json["estilo"].toString();
  }
}
