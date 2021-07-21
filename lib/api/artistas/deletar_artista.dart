import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class DeletarArtista extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> deleteDeletarArtista({
    required Artista artista,
  }) async {

    loading = true;

    try{

      final response = await dio.delete(
        api_artistas_delete+artista.id.toString()+".json",
      );

      if(response.statusCode == 200){

      }

    }catch(e){

    }

    loading = false;

  }

}