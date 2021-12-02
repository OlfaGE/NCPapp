import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  ///
  /// https://developer.box.com/reference/post-files-content/
  /// Parent id is the folder id, 0 means root folder
  /// This will upload to entreprise folder, not personal folder
  /// https://app.box.com/master > Content > NCP Application
  uploadFile(
    File file,
  ) async {
    var multipartFile = await http.MultipartFile.fromPath("file", file.path);
    return await uploadMultipart(multipartFile);
  }

  uploadImage(Image image) async {
    final bytes = await image.toByteData(format: ImageByteFormat.png);
    if (bytes == null) return;
    var pic = http.MultipartFile.fromBytes("file", bytes.buffer.asInt8List(),
        filename: "test.png",
        contentType: MediaType("application", "octet-stream"));
    return await uploadMultipart(pic);
  }

  /// Warning, the multiPartFile if coming from Byte does not have filename, will always file on any provider
  /// filename must not be null will uploading
  uploadMultipart(MultipartFile multiPartFile) async {
    print(multiPartFile.filename);
    print(multiPartFile.length);
    print(multiPartFile.contentType);
    print(multiPartFile.field);
    print(multiPartFile.isFinalized);

    final accessToken = await _getAccessToken();

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
    request.files.add(multiPartFile);

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

  uploadFileIO(MultipartFile file) async {
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse('https://file.io/'));
    //add text fields
    final expiration = DateTime.now().add(Duration(hours: 1));
    request.fields.addAll({
      'expires': expiration.toIso8601String(),
      'maxDownloads': '1',
      'autoDelete': 'true'
    });
    //add multipart to request
    request.files.add(file);
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
