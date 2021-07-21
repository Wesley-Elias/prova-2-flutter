class Artista {
  String id = "";
  String nome = "";
  String imagemPerfil = "";
  String email = "";
  String senha = "";

  Artista({
    required this.id,
    required this.nome,
    required this.imagemPerfil,
    required this.email,
    required this.senha,
  });

  Artista.fromJson(Map<String, dynamic> json, String key) {
    id = key;
    nome = json["nome"].toString();
    imagemPerfil = json["imagemPerfil"].toString();
    email = json["email"].toString();
    senha = json["senha"].toString();
  }
}
