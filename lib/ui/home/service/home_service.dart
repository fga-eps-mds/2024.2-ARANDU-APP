import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/home/model/home_model.dart';
import 'package:aranduapp/ui/home/model/home_request.dart';
import 'package:dio/dio.dart';

class HomeService {
  Future<List<HomeModel>> getKnowledges(HomeRequest homeRequest) async {
    try {
      final Response response = await StudioMakerApi.getInstance().get(
        path: '/knowledges',
        queryParameters: {
          'name': homeRequest.name, // Usando o parâmetro da requisição
        },
      );

      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Status code inválido: ${response.statusCode}',
        );
      }

      final List<dynamic> responseData = response.data is List
          ? response.data as List<dynamic>
          : throw FormatException('Resposta da API em formato inválido');

      Log.i('Dados recebidos: $responseData');

      final List<HomeModel> knowledges = [];

      for (final item in responseData) {
        try {
          final Map<String, dynamic> jsonItem = item as Map<String, dynamic>;

          knowledges.add(HomeModel(
            id: jsonItem['id']?.toString() ??
                '0', // Conversão segura para String
            name: jsonItem['name']?.toString() ?? 'Nome não disponível',
          ));
        } catch (e) {
          Log.e('Erro ao converter item: $item', error: e);
        }
      }

      return knowledges;
    } on DioException catch (e) {
      Log.e('Erro na requisição à API', error: e);
      throw Exception('Falha ao buscar conhecimentos: ${e.message}');
    } catch (e) {
      Log.e('Erro inesperado', error: e);
      throw Exception('Erro inesperado: $e');
    }
  }
}
