import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class CadastrarMusicasScreen extends StatefulWidget {
  final Artista artista;
  CadastrarMusicasScreen({required this.artista});

  @override
  _CadastrarMusicasScreenState createState() => _CadastrarMusicasScreenState();
}

class _CadastrarMusicasScreenState extends State<CadastrarMusicasScreen> {
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
    return Consumer2<CadastrarMusicas, ListaMusicas>(
      builder: (_, cadastrarMusicas, listaMusicas, __) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFF14213d),
          appBar: AppBar(
            title: Text("Cadastrar Musicas"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: cadastrarMusicas.loading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      await cadastrarMusicas.postCadastrarMusicas(
                          artista: widget.artista,
                          musicas: Musicas(
                            id: "",
                            nomeMusica: _nomeMusicaController.text,
                            duracao: _duracaoController.text,
                            estilo: _estiloController.text,
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
                cadastrarMusicas.loading ? Colors.grey : Colors.green,
            elevation: cadastrarMusicas.loading ? 0 : 3,
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
                  if (cadastrarMusicas.loading)
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
                          controller: _nomeMusicaController,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
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
                          controller: _duracaoController,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
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
                        TextFormField(
                          controller: _estiloController,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
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
