import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class EditarArtista extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> patchEditarArtista({
    required Artista artista,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {

    loading = true;

    var corpo = json.encode({
      "nome":artista.nome,
      "imagemPerfil":artista.imagemPerfil,
      "email":artista.email,
    });

    try{

      final response = await dio.patch(
        api_artistas_editar+artista.id+".json",
        data: corpo,
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);
        if(data.containsKey('nome')){
          onSuccess("Artista atualizado com sucesso!");
        }else{
          onFail("Erro ao atualizar Artista!");
        }
      }else{
        onFail("Erro ao atualizar Artista!");
      }

    }catch(e){
      onFail("Erro ao atualizar Artista!");
    }

    loading = false;

  }

}