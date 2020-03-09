import 'package:learn_test/main.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var server = MockWebServer(port: 8081);

  setUp(() async {
    await server.start();
  });
  tearDown(() async {
    await server.shutdown();
  });

  test('http通信の単体テスト', () async {
    var expected = '{ "title": "This is title." , "text": "This is text." }';

    server.enqueue(body: expected, httpCode: 200);

    final target = HttpClient(url: 'http://127.0.0.1:8081');

    // 非同期のテスト
    var resCode = await target.getResponseCode();
    var resBody = await target.getBody();

    expect(resCode, equals(200));
    expect(resBody, equals(expected));
  });
}
