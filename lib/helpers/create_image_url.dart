import 'package:property_client_finder_app/helpers/api_url.dart';

class CreateImageUrl {
  late List<String> imageUrls = [];
  List<String> generateImageUrl(String images) {
    List<String> result = images.split(',');
    for (var path in result) {
      var imageName = path.split('/');
      // print(imagePath);
      // "https://propertyclientfinder.herokuapp.com/api/v1/";

      String url = API.localApiUrl + "files/" + imageName[1];
      imageUrls.add(url);
    }
    return imageUrls;
  }
}
