import 'package:avaliacao2/screens/editar_artista/editar_artista_screen.dart';
import 'package:avaliacao2/screens/musicas_screen/musicas_screen.dart';
import 'package:flutter/material.dart';

import 'package:brasil_fields/brasil_fields.dart';

import 'package:provider/provider.dart';

import '../../../api/api.dart';
import '../../../helpers/helpers.dart';
import '../../../models/models.dart';

class CardArtista extends StatelessWidget {
  final Artista artista;
  CardArtista({required this.artista});

  @override
  Widget build(BuildContext context) {
    return Consumer3<DeletarArtista, ListaArtistas, ListaMusicas>(
      builder: (_, deletarArtista, listaArtistas, listaMusicas, __) {
        return GestureDetector(
          onTap: () {
            listaMusicas.getListaMusicas(idArtista: artista.id);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MusicasScreen(artista: artista),
              ),
            );
          },
          child: Card(
            elevation: 3,
            color: Colors.green,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: deletarArtista.loading
                          ? null
                          : () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditarArtistaScreen(artista: artista),
                                ),
                              );
                            },
                      tooltip: "Editar",
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: deletarArtista.loading
                          ? null
                          : () async {
                              await deletarArtista.deleteDeletarArtista(
                                  artista: artista);
                              listaArtistas.getListaArtistas();
                            },
                      tooltip: "Deletar",
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  artista.nome,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                Image.network(
                  artista.imagemPerfil,
                  fit: BoxFit.cover,
                  width: 400,
                  height: 200,
                ),
                const SizedBox(height: 16),
                Text(
                  artista.email,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
