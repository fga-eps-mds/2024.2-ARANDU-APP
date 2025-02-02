import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/trails/model/trails_model.dart';
import 'package:aranduapp/ui/trails/model/trails_request.dart';
import 'package:aranduapp/ui/trails/service/trails_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TrailsViewmodel extends ChangeNotifier {
  late Command1<List<TrailsModel>, String> getTrailsCommand;

  TrailsViewmodel() {
    getTrailsCommand = Command1(getTrails);
  }

  Future<Result<List<TrailsModel>>> getTrails(String journeyId) async {
    List<TrailsModel> res = await GetIt.instance<TrailsService>()
        .getTrails(TrailsRequest(journeyId: journeyId));

    return Result.value(res);
  }
}
