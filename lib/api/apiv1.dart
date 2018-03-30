import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ApiV1 {
  static ApiV1 _instance = ApiV1();

  static ApiV1 get() {
    return _instance;
  }

  DataV1 _data;

  var url = 'https://islove.wener.me/v1';
  var httpClient = new HttpClient();

  DataV1 getDataNow() {
    return _data;
  }

  Future<DataV1> getData() async {
    if (_data != null) {
      return _data;
    }
    try {
      var request = await httpClient.getUrl(Uri.parse('${url}/data.json'));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        Map data = await JSON.decode(json);
        print('Data version ${data['version']}');
        return _data = DataV1.fromJson(data);
      } else {
        print('Failed to get data ${response.statusCode}');
        throw Exception("抱歉网络请求失败");
      }
    } catch (exception) {
      print('Failed to get data ${exception}');
      throw Exception("抱歉网络请求失败");
    }
  }
}

class DataV1 {
  final String title;
  final String version;
  final List<FlashV1> flashes;

  DataV1(this.title, this.version, this.flashes);

  DataV1.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        version = json['version'],
        flashes = (json['flashes'] as List).map((m) => FlashV1.fromJson(m)).toList();
}

class FlashV1 {
  final String title;
  final String description;
  final String image;

  FlashV1(this.title, this.description, this.image);

  FlashV1.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        image = json['image'];
}
