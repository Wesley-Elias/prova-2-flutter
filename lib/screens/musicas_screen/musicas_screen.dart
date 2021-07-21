import 'package:avaliacao2/screens/cadastrar_musicas/cadastrar_musicas_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

import 'componenes/card_musicas.dart';

class MusicasScreen extends StatelessWidget {
  final Artista artista;
  MusicasScreen({required this.artista});

  @override
  Widget build(BuildContext context) {
    return Consumer<ListaMusicas>(
      builder: (_, listaMusicas, __) {
        return Scaffold(
          backgroundColor: Color(0xFF14213d),
          appBar: AppBar(
            title: Text(
              "Lista de Musicas - " + artista.nome,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            tooltip: "Adicionar Musicas",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      CadastrarMusicasScreen(artista: artista),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: listaMusicas.listaMsc.length,
            itemBuilder: (context, index) {
              return CardMusicas(
                musicas: listaMusicas.listaMsc[index],
                artista: artista,
              );
            },
          ),
        );
      },
    );
  }
}
