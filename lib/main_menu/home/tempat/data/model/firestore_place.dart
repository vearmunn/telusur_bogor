import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/place.dart';

class FirestorePlace {
  final String id;
  final String name;
  final PlaceType type;
  final String description;
  final double latitude;
  final double longitude;
  final String address;
  final List<String> images;
  final double? rating;
  final String tag;

  // Optional fields
  final List<String>? cuisine;
  final String? priceRange;
  final String? openingHours;
  final String? menuUrl;

  final int? stars;
  final int? pricePerNight;
  final List<String>? amenities;
  final String? bookingUrl;

  final String? difficulty;
  final String? bestSeason;

  final String? contactNumber;

  FirestorePlace({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.images,
    required this.tag,
    this.rating,
    this.cuisine,
    this.priceRange,
    this.openingHours,
    this.menuUrl,
    this.stars,
    this.pricePerNight,
    this.amenities,
    this.bookingUrl,
    this.difficulty,
    this.bestSeason,
    this.contactNumber,
  });

  /// Convert Place → Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.name, // store enum as string
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'images': images,
      'rating': rating,
      'tag': tag,
      'cuisine': cuisine,
      'priceRange': priceRange,
      'openingHours': openingHours,
      'menuUrl': menuUrl,
      'stars': stars,
      'pricePerNight': pricePerNight,
      'amenities': amenities,
      'bookingUrl': bookingUrl,
      'difficulty': difficulty,
      'bestSeason': bestSeason,
      'contactNumber': contactNumber,
    };
  }

  /// Convert Firestore Map → Place
  factory FirestorePlace.fromMap(Map<String, dynamic> map) {
    return FirestorePlace(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: PlaceType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => PlaceType.other,
      ),
      description: map['description'] ?? '',
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      address: map['address'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      tag: map['tag'] ?? '',
      cuisine:
          map['cuisine'] != null ? List<String>.from(map['cuisine']) : null,
      priceRange: map['priceRange'],
      openingHours: map['openingHours'],
      menuUrl: map['menuUrl'],
      stars: map['stars'],
      pricePerNight: map['pricePerNight'],
      amenities:
          map['amenities'] != null ? List<String>.from(map['amenities']) : null,
      bookingUrl: map['bookingUrl'],
      difficulty: map['difficulty'],
      bestSeason: map['bestSeason'],
      contactNumber: map['contactNumber'],
    );
  }

  /// Helper to create from Firestore DocumentSnapshot
  factory FirestorePlace.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FirestorePlace.fromMap({...data, 'id': doc.id});
  }

  factory FirestorePlace.fromDomain(Place place) {
    return FirestorePlace(
      id: place.id,
      name: place.name,
      type: place.type,
      description: place.description,
      latitude: place.latitude,
      longitude: place.longitude,
      address: place.address,
      images: place.images,
      tag: place.tag,
      rating: place.rating,
      cuisine: place.cuisine,
      priceRange: place.priceRange,
      openingHours: place.openingHours,
      menuUrl: place.menuUrl,
      stars: place.stars,
      pricePerNight: place.pricePerNight,
      amenities: place.amenities,
      bookingUrl: place.bookingUrl,
      difficulty: place.difficulty,
      bestSeason: place.bestSeason,
      contactNumber: place.contactNumber,
    );
  }

  /// Convert data model → domain entity
  Place toDomain() {
    return Place(
      id: id,
      name: name,
      type: type,
      description: description,
      latitude: latitude,
      longitude: longitude,
      address: address,
      images: images,
      tag: tag,
      rating: rating,
      cuisine: cuisine,
      priceRange: priceRange,
      openingHours: openingHours,
      menuUrl: menuUrl,
      stars: stars,
      pricePerNight: pricePerNight,
      amenities: amenities,
      bookingUrl: bookingUrl,
      difficulty: difficulty,
      bestSeason: bestSeason,
      contactNumber: contactNumber,
    );
  }
}
