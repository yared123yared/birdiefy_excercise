import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Repository {
  final http.Client httpClient;
  Repository({
    required this.httpClient,
  });

  Future<Response> getNearbyCourse() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw  Exception('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        throw  Exception("'Location permissions are permanently denied");
      } else {
        print("GPS Location service is granted");

      }
    } else {
      print("GPS Location permission granted.");
    }

    print("Repository get called");
    try {
      Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
      String long = position.longitude.toString();
      String lat = position.latitude.toString();
      print("Lat and Loong$lat $long");
      final queryParameters = {
        'key': 'AIzaSyA55o9J4wrj_PZ75U-1zdv82YyftE15l7g',
        'keyword': 'golf course',
        'location': '$lat, $long',
        'radius': '150000',
        'type': 'sport',
      };
      print("Before parsing the url");
      final uri = Uri.parse(
        'https://maps.googleapis.com//maps/api/place/nearbysearch/json',
      ).replace(queryParameters: queryParameters);
      print("After parsing the uri with $uri");
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      print("Response data: $response");
      return response;
    } catch (e) {
      print("Exception occured $e");
      throw Exception(e);
    }
  }
}
