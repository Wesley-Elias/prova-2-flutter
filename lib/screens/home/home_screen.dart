import 'package:avaliacao2/screens/cadastrar_artista/cadastrar_artista_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';

import 'componenes/card_artista.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListaArtistas>(
      builder: (_, listaArtistas, __) {
        return Scaffold(
          backgroundColor: Color(0xFF14213d),
          appBar: AppBar(
            title: Text(
              "Avaliação 2",
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
            tooltip: "Adicionar Artista",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CadastrarArtistaScreen(),
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
            itemCount: listaArtistas.listaArtistas.length,
            itemBuilder: (context, index) {
              return CardArtista(
                artista: listaArtistas.listaArtistas[index],
              );
            },
          ),
        );
      },
    );
  }
}
