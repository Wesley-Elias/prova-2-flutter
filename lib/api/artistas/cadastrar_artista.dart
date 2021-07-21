import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class CadastrarArtista extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> postCadastrarArtista({
    required Artista artista,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {

    loading = true;

    var corpo = json.encode({
      "nome":artista.nome,
      "imagemPerfil":artista.imagemPerfil,
      "email":artista.email,
      "senha":artista.senha,
    });

    try{

      final response = await dio.post(
        api_artistas,
        data: corpo,
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);
        if(data.containsKey('name')){
          onSuccess("Artista cadastrado com sucesso!");
        }else{
          onFail("Erro ao cadastrar Artista!");
        }
      }else{
        onFail("Erro ao cadastrar Artista!");
      }

    }catch(e){
      onFail("Erro ao cadastrar Artista!");
    }

    loading = false;

  }

}