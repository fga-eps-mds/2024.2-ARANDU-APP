import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/access_trails/model/access_trails_model.dart';
import 'package:aranduapp/ui/access_trails/model/access_trails_request.dart';
import 'package:aranduapp/ui/access_trails/service/access_trails_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AccessTrailsViewmodel extends ChangeNotifier {
  late Command1<List<AccessTrailsModel>, String> getAccessTrailsCommand;

  AccessTrailsViewmodel() {
    getAccessTrailsCommand = Command1(getAccessTrails);
  }

  Future<Result<List<AccessTrailsModel>>> getAccessTrails(String journeyId) async {
    List<AccessTrailsModel> res = await GetIt.instance<AccessTrailsService>()
        .getAccessTrails(AccessTrailsRequest(journeyId: journeyId));

    return Result.value(res);
  }
}
