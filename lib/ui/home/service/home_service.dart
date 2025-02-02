import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/home/model/home_model.dart';
import 'package:aranduapp/ui/home/model/home_request.dart';
import 'package:dio/dio.dart';

class HomeService {
  Future<List<HomeModel>> getKnowledges(HomeRequest homeRequest) async {
    Response response =
        await StudioMakerApi.getInstance().get(path: '/knowledges');

    List<dynamic> nameList = response.data as List<dynamic>;

    Log.i(nameList);

    var res = nameList.map((e) {
      final Map<String, dynamic> nameMap = e as Map<String, dynamic>;

      return HomeModel(
        name: nameMap['name']! as String,
      );
    }).toList();

    return res;
  }
}
