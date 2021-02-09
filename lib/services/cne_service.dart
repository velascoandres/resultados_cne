import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:resultados_cne/models/result_response.dart';


class CneService {


   // Singleton
  CneService._privateContructor();

  static final CneService _instance = CneService._privateContructor();


  factory CneService() {
    return _instance;
  }

  // http client
  final dio = new Dio();
  
  final String _domain = 'https://resultados2021.cne.gob.ec';

  
  Future<ResultResponse> getVotes({
    int numProvincia = -1,
    int codDignidad = 1,
    int codCanton = -1,
    int codCircunscripcion = -1,
  }) async {
      final formDataMap = {
        'request[intCodDignidad]': codDignidad,
        'request[intCodProvincia]': numProvincia,
        'request[intCodCanton]': codCanton,
        'request[intCodCircunscripcion]': codCircunscripcion,
      };

      FormData formData = FormData.fromMap(formDataMap);

      final url = '$_domain/Home/ConsultarResultados';

      final rawResponse = await this.dio.post(url, data: formData);

      final response = ResultResponse.fromJson(rawResponse.data);

      return response;
  }
}
