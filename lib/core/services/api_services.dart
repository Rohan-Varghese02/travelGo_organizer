import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:http/http.dart' as http;

class ApiServices {
  // Future<String> getUploadUrl(String imagePath) async {
  //   try {
  //     const cloudinaryUrl =
  //         "https://api.cloudinary.com/v1_1/dvmrt0wfv/image/upload";
  //     const uploadPreset = "TravLGo_users";
  //     String imageUrl = '';

  //     var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
  //     request.fields['upload_preset'] = uploadPreset;
  //     request.files.add(await http.MultipartFile.fromPath('file', imagePath));

  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       var responseData = json.decode(await response.stream.bytesToString());
  //       imageUrl = responseData['secure_url'];
  //     } else {
  //       print(response.statusCode);
  //     }
  //     return imageUrl;
  //   } catch (e) {
  //     return e.toString();
  //   }
  Future<Map<String, String>> getUploadUrl(String imagePath) async {
    try {
      const cloudinaryUrl =
          "https://api.cloudinary.com/v1_1/dvmrt0wfv/image/upload";
      const uploadPreset = "TravLGo_users";

      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = json.decode(await response.stream.bytesToString());
        return {
          'imageUrl': responseData['secure_url'],
          'publicId': responseData['public_id'],
        };
      } else {
        print("Upload failed with status code: ${response.statusCode}");
        return {};
      }
    } catch (e) {
      print("Error uploading image: $e");
      return {};
    }
  }


      static const cloudName = 'dvmrt0wfv';
  static const apiKey = '983528927447469';
  static const apiSecret = 'lHeJAJqfNMSEjZrp7eHU1hSyu9I';

   Future<bool> deleteImageFromCloudinary(String publicId) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // Create the signature: "public_id=xyz&timestamp=12345<apiSecret>"
      final signatureString = 'public_id=$publicId&timestamp=$timestamp$apiSecret';
      final signature = sha1.convert(utf8.encode(signatureString)).toString();

      final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/destroy');

      final response = await http.post(url, body: {
        'public_id': publicId,
        'api_key': apiKey,
        'timestamp': timestamp.toString(),
        'signature': signature,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['result'] == 'ok';
      } else {
        print("Failed to delete image: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error deleting image: $e");
      return false;
    }
  }


}
