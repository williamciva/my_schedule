import 'dart:html';

class AtitusApi {
  bool _isHttps = true;
  String host;
  String? _path;
  Uri? _currentUrl;

  Uri? _urlBase;

  AtitusApi({bool isHttps = true, required String this.host}) {
    _isHttps = isHttps;
    _isHttps ? this._urlBase = Uri.https('${this.host}') : this._urlBase = Uri.http('${this.host}');
  }

  void setPath({required String path}) {
    _path = path;
    _isHttps ? _currentUrl = Uri.https('${_urlBase?.host}') : Uri.http('${_urlBase?.host}');
  }

  void login({required String username, required String password}) async {
    setPath(path: 'avalogin/Login.aspx');

    var data = {'username': username, 'password': password};
    HttpRequest response = await HttpRequest.postFormData('$_currentUrl', data);

    print(response);
  }
}
