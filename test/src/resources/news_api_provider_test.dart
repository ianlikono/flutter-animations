import 'dart:convert';

import 'package:animations/src/resources/news_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import "package:test/test.dart";

void main() {
  test('FetchTopIds returns a list of Ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((Request request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });
    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('Fetch Item returns an item model', () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((Request request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}
