import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../home/tempat/domain/models/place.dart';

class SearchCubit extends Cubit<List<Place>> {
  SearchCubit() : super([]);

  Future<void> searchPlaces(String query) async {
    if (query.isEmpty) {
      emit([]);
      return;
    }

    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5',
    );

    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'your-app-name', // Nominatim requires user-agent
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      final results =
          data
              .map(
                (e) => Place(
                  id: e["place_id"].toString(),
                  name: e["name"],
                  type: PlaceType.other,
                  description: 'description',
                  latitude: double.tryParse(e["lat"]) ?? 0.0,
                  longitude: double.tryParse(e["lon"]) ?? 0.0,
                  address: '',
                  images: [],
                  tag: 'tag',
                ),
              )
              .toList();
      emit(results);
    } else {
      emit([]);
    }
  }
}
