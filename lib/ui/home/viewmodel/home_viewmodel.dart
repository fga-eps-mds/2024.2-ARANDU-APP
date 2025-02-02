import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/home/model/home_model.dart';
import 'package:aranduapp/ui/home/model/home_request.dart';
import 'package:aranduapp/ui/home/service/home_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeViewModel extends ChangeNotifier {
  late Command1<List<HomeModel>, String> getHomeCommand;

  HomeViewModel() {
    getHomeCommand = Command1(getKnowledges);
  }

  Future<Result<List<HomeModel>>> getKnowledges(String name) async {
    List<HomeModel> res = await GetIt.instance<HomeService>()
        .getKnowledges(HomeRequest(name: name));

    return Result.value(res);
  }
}
