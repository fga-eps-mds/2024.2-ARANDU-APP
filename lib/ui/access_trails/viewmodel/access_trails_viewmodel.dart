import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/access_trails/model/access_trails_model.dart';
import 'package:aranduapp/ui/access_trails/service/access_trails_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AccessTrailsViewmodel extends ChangeNotifier {
  List<AccessTrailsModel> trails = [];

  late Command0<List<AccessTrailsModel>> trailsCommand;

  AccessTrailsViewmodel() {
    trailsCommand = Command0(_getTrails);
    trailsCommand.execute();
  }

  // Corrigi a assinatura da função, ela agora retorna um Future<Result> corretamente.
  Future<Result<List<AccessTrailsModel>>> _getTrails() async {
    try {
      final res = await GetIt.instance<AccessTrailsService>().getTrails();
      return Result.value(res);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<List<AccessTrailsModel>> getTrails() async {
    final result = await trailsCommand.execute();
    return result.asValue?.value ?? [];
  }
}
