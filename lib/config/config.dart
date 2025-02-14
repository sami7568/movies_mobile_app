import 'package:stacked_shared/stacked_shared.dart';

class Config {
  final String _env = Environment.test;
  final String _stageBaseUrl = 'https://api.themoviedb.org/3';
  final String _testBaseUrl = "";
  final String _productionBaseUrl = "";
  late String _baseUrl = "";

  /// Getters
  String get env => _env;
  String get baseUrl => _baseUrl;

  /// Constructor
  Config({Environment? env}) {
    _setupBaseUrl();
  }

  _setupBaseUrl() {
    if (_env == Environment.prod) {
      _baseUrl = _productionBaseUrl;
    } else if (_env == Environment.dev) {
      _baseUrl = _testBaseUrl;
    } else if (_env == Environment.test) {
      _baseUrl = _stageBaseUrl;
    }
  }
}
