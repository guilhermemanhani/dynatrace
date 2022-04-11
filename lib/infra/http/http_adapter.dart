import 'dart:convert';

import 'package:dynatrace_flutter_plugin/dynatrace_flutter_plugin.dart';
import 'package:dynatrace_test/data/http/http.dart';
import 'package:http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;
  HttpAdapter(this.client);

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    DynatraceRootAction action =
        Dynatrace().enterAction("MyButton tapped - Web Action Override");
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    try {
      if (method == 'post') {
        response =
            await client.post(Uri.parse(url), headers: headers, body: jsonBody);
      } else if (method == 'get') {
        response = await client.get(Uri.parse(url), headers: headers);
      }
      action.leaveAction();
    } catch (error) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
