import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class CadastrarMusicas extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> postCadastrarMusicas({
    required Artista artista,
    required Musicas musicas,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {

    loading = true;

    var corpo = json.encode({
      "nomeMusica":musicas.nomeMusica,
      "duracao":musicas.duracao,
      "estilo":musicas.estilo,
    });

    try{

      final response = await dio.post(
        api_musicas+artista.id+"/musicas/.json",
        data: corpo,
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);
        if(data.containsKey('name')){
          onSuccess("Musica cadastrada com sucesso!");
        }else{
          onFail("Erro ao cadastrar Musica!");
        }
      }else{
        onFail("Erro ao cadastrar Musica!");
      }

    }catch(e){
      onFail("Erro ao cadastrar Musica!");
    }

    loading = false;

  }

}