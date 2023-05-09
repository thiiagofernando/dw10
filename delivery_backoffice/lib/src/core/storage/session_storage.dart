import 'storage.dart';
import 'dart:html';

class SessionStorage extends Storage {
  @override
  void clean() => window.sessionStorage.clear();

  @override
  String getData(String key) => window.sessionStorage[key] ?? '';

  @override
  void setData(String key, String value) => window.sessionStorage[key] = value;
}
