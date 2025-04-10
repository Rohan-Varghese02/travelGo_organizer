import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  Future<String> getUploadUrl(String imagePath) async {
    try {
      const cloudinaryUrl =
          "https://api.cloudinary.com/v1_1/dvmrt0wfv/image/upload";
      const uploadPreset = "TravLGo_users";
      String imageUrl = '';

      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = json.decode(await response.stream.bytesToString());
        imageUrl = responseData['secure_url'];
      } else {
        print(response.statusCode);
      }
      return imageUrl;
    } catch (e) {
      return e.toString();
    }
  }
}
