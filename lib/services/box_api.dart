import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class BoxApi {
  final Client _client = Client();

  ///
  /// Create an API key here https://app.box.com/developers/console
  /// Choose Custome App > Server Authentication
  /// 2FA will be required to obtain client_secret (Google authenticator would work)
  /// Then use this https://developer.box.com/guides/authentication/client-credentials/
  ///
  /// If you get invalid grant, go the the App > Authorization tab > Submit for review
  /// Check you email, (you're the admin) then Authorize app
  ///
  _getAccessToken() async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var body = {
      'client_id': 'b43p9eo7obu4agrdxzr62kyz5yl8oecl',
      'client_secret': '3tI6kjQ7zOP7jN07gKRhG9mry1kxyLlJ',
      'grant_type': 'client_credentials',
      'box_subject_type': 'enterprise',
      'box_subject_id': '862304212'
    };
    final _url = 'https://api.box.com/oauth2/token';
    final url = Uri.parse(_url);
    final response = await _client.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body["access_token"];
    }
  }

  uploadFilePost(
    File file,
  ) async {
    final accessToken = await _getAccessToken();
    final fileBinary = base64Encode(file.readAsBytesSync());

    final filename = "${DateTime.now().millisecondsSinceEpoch}.jpg";
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var body = {
      'attributes': '{"name":$filename, "parent":{"id":0}}',
      'file': fileBinary
    };
    final _url = 'https://upload.box.com/api/2.0/files/content';
    final url = Uri.parse(_url);
    final response = await _client.post(url, headers: headers, body: body);
    print(response.body);
    print(response.statusCode);
    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body["access_token"];
    }
    // var request = MultipartRequest(
    //     'POST', Uri.parse('https://upload.box.com/api/2.0/files/content'));
    // request.fields.addAll({
    //   'attributes': '{"name":$filename, "parent":{"id":0}}',
    //   // 'file': fileBinary
    // });
    // // request.fields.addAll({'file': fileBinary});
    // // request.files.add(
    // //   new MultipartFile.fromBytes(
    // //     'file',
    // //     await file.readAsBytes(),
    // //   ),
    // // );
    //
    // print(request.files);
    // print(request.fields);
    // request.headers.addAll(headers);
    //
    // StreamedResponse response = await request.send();
    // print(await response.stream.bytesToString());
    //
    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
  }

  ///
  /// https://developer.box.com/reference/post-files-content/
  /// Parent id is the folder id, 0 means root folder
  /// This will upload to entreprise folder, not personal folder
  /// https://app.box.com/master > Content > NCP Application
  uploadFile(
    File file,
  ) async {
    print(file.path);
    final accessToken = await _getAccessToken();
    final fileBinary = base64Encode(file.readAsBytesSync());

    final filename = "${DateTime.now().millisecondsSinceEpoch}.jpg";
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'multipart/form-data',
    };
    var request = MultipartRequest(
        'POST', Uri.parse('https://upload.box.com/api/2.0/files/content'));
    request.fields.addAll({
      'attributes': '{"name": "$filename", "parent":{"id":0}}',
      // 'file': fileBinary
    });

    var pic = await http.MultipartFile.fromPath("file", file.path);
    request.files.add(pic);

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();
    final responseTxt = await response.stream.bytesToString();
    print(responseTxt);

    if (response.statusCode == 201) {
      print(responseTxt);
    } else {
      print(response.reasonPhrase);
      throw response.reasonPhrase ?? "Error";
    }
  }

  uploadFileIO2(File file) async {
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse('https://file.io/'));
    //add text fields
    request.fields.addAll({
      'expires': '2021-12-02T23:04:53.872Z',
      'maxDownloads': '1',
      'autoDelete': 'true',
      'file': '@test.png;type=image/png'
    });
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("file", file.path);
    //add multipart to request
    request.files.add(pic);
    // var response = await request.send();
    //
    // //Get the response from the server
    // var responseData = await response.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);
    // print(responseString);

    StreamedResponse response = await request.send();
    final responseTxt = await response.stream.bytesToString();
    print(responseTxt);

    if (response.statusCode == 201) {
      print(responseTxt);
    } else {
      print(response.reasonPhrase);
      throw response.reasonPhrase ?? "Error";
    }
  }
}
