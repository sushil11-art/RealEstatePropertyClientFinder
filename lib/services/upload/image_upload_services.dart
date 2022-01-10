import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_client_finder_app/helpers/api_url.dart';

final box = GetStorage();
var token = box.read('token');

class ImageUploadServices {
  static Future uploadImages(List<XFile> images) async {
    try {
      var base_url = API.localApiUrl + "upload";
      var url = Uri.parse(base_url);
      var request = http.MultipartRequest("POST", url);

      // request.files.addAll(newList);
      request.headers['authorization'] = token;

      for (var file in images) {
        // print(file);
        // String fileName = file.path.split("/").last;
        var stream = http.ByteStream(file.openRead())..cast();
        // var picture = http.MultipartFile.fromBytes('image', file.buffer.asUint8List()),

        var length = await file.length(); //imageFile is your image file

        // multipart that takes file
        var multipartFileSign =
            http.MultipartFile('files', stream, length, filename: file.name);

        request.files.add(multipartFileSign);
      }

      var response = await request.send();
      // print(response);

      return response;
    } catch (e) {
      return e;
    }

    // var responseData = await response.stream.toBytes();

    // var result = String.fromCharCodes(responseData);
  }
}
