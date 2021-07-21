import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class EditarMusicasScreen extends StatefulWidget {
  final Artista artista;
  final Musicas musicas;
  EditarMusicasScreen({required this.artista, required this.musicas});

  @override
  _EditarMusicasScreenState createState() => _EditarMusicasScreenState();
}

class _EditarMusicasScreenState extends State<EditarMusicasScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeMusicaController = TextEditingController();
  final _duracaoController = TextEditingController();
  final _estiloController = TextEditingController();

  void limparCampos() {
    _nomeMusicaController.clear();
    _duracaoController.clear();
    _estiloController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<EditarMusicas, ListaMusicas>(
      builder: (_, editarMusicas, listaMusicas, __) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFF14213d),
          appBar: AppBar(
            title: Text("Editar Musicas"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: editarMusicas.loading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      await editarMusicas.patchEditarMusicas(
                          artista: widget.artista,
                          musicas: Musicas(
                            id: widget.musicas.id,
                            nomeMusica: _nomeMusicaController.text.isNotEmpty
                                ? _nomeMusicaController.text
                                : widget.musicas.nomeMusica,
                            duracao: _duracaoController.text.isNotEmpty
                                ? _duracaoController.text
                                : widget.musicas.duracao,
                            estilo: _estiloController.text.isNotEmpty
                                ? (_estiloController.text)
                                : widget.musicas.estilo,
                          ),
                          onSuccess: (text) async {
                            listaMusicas.getListaMusicas(
                                idArtista: widget.artista.id);

                            scaffoldKey.currentState!.showSnackBar(SnackBar(
                              content: Text(
                                text,
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ));

                            Future.delayed(Duration(seconds: 2)).then((_) {
                              Navigator.pop(context);
                            });
                          },
                          onFail: (text) {
                            scaffoldKey.currentState!.showSnackBar(SnackBar(
                              content: Text(
                                text,
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 3),
                            ));
                          });
                    }
                  },
            tooltip: 'Salvar Artista',
            backgroundColor:
                editarMusicas.loading ? Colors.grey : Colors.green,
            elevation: editarMusicas.loading ? 0 : 3,
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (editarMusicas.loading)
                    LinearProgressIndicator(
                      // color: colorBlueJeans,
                      backgroundColor: Colors.white,
                      minHeight: 5,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 36,
                        ),
                        TextFormField(
                          initialValue: widget.musicas.nomeMusica,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                          onChanged: (text) {
                            _nomeMusicaController.text = text;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Nome da Musica",
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          initialValue: widget.musicas.estilo,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                          onChanged: (text) {
                            _estiloController.text = text;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Estilo",
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          initialValue: widget.musicas.duracao,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                          onChanged: (text) {
                            _duracaoController.text = text;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Duração",
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
