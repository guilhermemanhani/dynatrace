import 'package:dynatrace_test/data/http/http_error.dart';
import 'package:dynatrace_test/infra/http/http_adapter.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements http.Client {}

void main() {
  late HttpClientMock client;
  late HttpAdapter sut;
  late String url;
  setUp(() {
    client = HttpClientMock();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });
  test('Should call post with correct values', () async {
    final future = sut.request(url: url, method: 'invalid_method');

    expect(future, throwsA(HttpError.serverError));
  });
}
