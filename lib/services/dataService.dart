import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testbloc/models/postModel.dart';

class DataService {
  static SharedPreferences _storage;
  static const STORSGE_KEY_JSON_CACHE = 'jsonCache';
  static const URI = 'https://jsonplaceholder.typicode.com/posts';

  ///Init Cache in DataService
  static init() async {
    _storage = await SharedPreferences.getInstance();
  }

  ///Caching json string
  static _cacheJson({
    @required String key,
    @required String value,
  }) {
    _storage.setString(
      key,
      value,
    );
  }

  ///Return json in cache
  static String _cachedJson({@required String key}) {
    String resultJson;

    if (_storage.containsKey(key)) {
      try {
        resultJson = _storage.getString(key);
      } catch (e) {
        print("Broked json key=$key");
        //удаляем испорченный кеш
        _storage.remove(key);
      }
    }

    return resultJson;
  }

  Future<List<Post>> getPosts() async {
    List<dynamic> data;
    String dataJson;

    dataJson =
        _isCached(key: URI) ? _cachedJson(key: URI) : await _getHttpJson(URI);

    data = json.decode(dataJson);

    return data.map((json) => Post.fromJson(json)).toList();
  }

  ///Check contains key in cache
  bool _isCached({@required String key}) => _storage.containsKey(key);

  ///Get http data
  Future<String> _getHttpJson(String uri) async {
    String resultJsonData;

    final responcse = await http.get(URI);

    if (responcse.statusCode == 200) {
      resultJsonData = utf8.decode(responcse.bodyBytes);
      _cacheJson(key: URI, value: resultJsonData);
    } else {
      throw Exception('Error fetching users');
    }
    return resultJsonData;
  }
}
