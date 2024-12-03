import 'package:logger/logger.dart';

class Log {

  static Log? _instance;
  final Logger _logger;

  Log._internal() : _logger = Logger();


  static Log getInstance() => _instance ??= Log._internal();

  static f(dynamic mensage){
    getInstance()._logger.f(mensage);
  }

  static t(dynamic mensage){
    getInstance()._logger.t(mensage);
  }

  static d(dynamic mensage){
    getInstance()._logger.d(mensage);
  }

  static i(dynamic mensage){
    getInstance()._logger.i(mensage);
  }

  static w(dynamic mensage){
    getInstance()._logger.w(mensage);
  }

  static e(dynamic mensage){
    getInstance()._logger.e(mensage);
  }

}
