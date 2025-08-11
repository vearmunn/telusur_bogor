enum PlaceType {
  restaurant,
  hotel,
  nature,
  museum,
  shop,
  themePark,
  cafe,
  hospital,
  police,
  other,
}

class Place {
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

  // Optional fields for specific types
  final List<String>? cuisine; // For restaurants
  final String? priceRange; // For restaurants & hotels
  final String? openingHours; // For restaurants, shops
  final String? menuUrl; // Restaurants

  final int? stars; // For hotels
  final int? pricePerNight; // Hotels
  final List<String>? amenities; // Hotels
  final String? bookingUrl; // Hotels

  final String? difficulty; // Nature (e.g., hiking trails)
  final String? bestSeason; // Nature

  final String? contactNumber;

  Place({
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
}

// List<Place> bogorPlaces = [
//   Place(
//     id: '1',
//     name: 'Taman Safari Indonesia Bogor',
//     description:
//         'Kebun binatang dan taman rekreasi dengan pengalaman safari dan satwa dari seluruh dunia.',
//     type: PlaceType.themePark,
//     latitude: -6.717299,
//     longitude: 106.948392,
//     images: [
//       'https://img.jakpost.net/c/2018/09/28/2018_09_28_55011_1538134470._large.jpg',
//     ],
//     rating: 4.7,
//     address: 'Jl. Kapten Harun Kabir No.724, Cisarua, Bogor',
//     openingHours: '08:30 - 17:00',
//     tag: 'Popular',
//   ),
//   Place(
//     id: '2',
//     name: 'Kebun Raya Bogor',
//     description:
//         'Kebun botani bersejarah dengan koleksi tanaman tropis terbesar di Asia Tenggara.',
//     type: PlaceType.nature,
//     latitude: -6.5971,
//     longitude: 106.7990,
//     images: [
//       'https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Kebun_Raya_Bogor_19.jpg/1280px-Kebun_Raya_Bogor_19.jpg',
//     ],
//     rating: 4.7,
//     address: 'Jl. Ir. H. Juanda No.13, Bogor',
//     tag: 'Popular',
//   ),
//   Place(
//     id: '3',
//     name: 'Hotel Salak The Heritage',
//     description:
//         'Hotel bintang 4 bergaya kolonial, dekat Istana dan Kebun Raya Bogor.',
//     type: PlaceType.hotel,
//     latitude: -6.594722,
//     longitude: 106.793056,
//     images: ['https://www.hotelsalak.co.id/slider/images/front.jpg'],
//     rating: 4.5,
//     address: 'Jl. Ir. H. Juanda No.8, Bogor',
//     tag: 'Popular',
//     amenities: [
//       'WiFi Gratis',
//       'Kolam Renang',
//       'Restoran',
//       'Spa',
//       'Center Bisnis',
//     ],
//   ),

//   Place(
//     id: '4',
//     name: 'Cimory Riverside',
//     description:
//         'Restoran keluarga dengan pemandangan sungai dan area bermain anak.',
//     type: PlaceType.restaurant,
//     latitude: -6.6696,
//     longitude: 106.9416,
//     images: [
//       'https://cimory.com/uploads/hospitality/filename_gsgreb1630997005.jpg',
//     ],
//     rating: 4.5,
//     address: 'Jl. Raya Puncak, Cisarua, Bogor',
//     openingHours: '08:00 - 21:00',
//     tag: 'Popular',
//   ),
//   Place(
//     id: '5',
//     name: 'Kopi Daong',
//     description:
//         'Kafe outdoor di tengah hutan pinus yang populer untuk suasana natural.',
//     type: PlaceType.cafe,
//     latitude: -6.690851,
//     longitude: 106.935321,
//     images: [
//       'https://awsimages.detik.net.id/visual/2021/02/24/kopi-daong-tangkapan-layar-instgaram-kopidaongid_169.jpeg?w=650',
//     ],
//     rating: 4.4,
//     address: 'Jl. Pancawati, Caringin, Bogor',
//     openingHours: '09:00 - 21:00',
//     tag: 'Popular',
//   ),
//   Place(
//     id: '6',
//     name: 'Curug Cilember',
//     description:
//         'Kompleks air terjun seven-tier dengan suasana sejuk dan pinus sekitar.',
//     type: PlaceType.nature,
//     latitude: -6.6886,
//     longitude: 106.9343,
//     images: [
//       'https://asset.kompas.com/crops/60Af5XeJJtYx_Oj0XKPHRRwHIyo=/0x429:1080x1149/1200x800/data/photo/2022/02/20/6211c0000290e.jpeg',
//     ],
//     rating: 4.4,
//     address: 'Jl. Raya Puncak KM.15, Bogor',
//     tag: 'Near Me',
//   ),
//   Place(
//     id: '7',
//     name: 'De Voyage Bogor',
//     description: 'Taman wisata bertema Eropa dengan spot foto estetik.',
//     type: PlaceType.themePark,
//     latitude: -6.6355,
//     longitude: 106.8361,
//     images: [
//       'https://akcdn.detik.net.id/visual/2023/06/14/wisata-devoyage-bogor_169.jpeg?w=1200',
//     ],
//     rating: 4.3,
//     address: 'JL. Boulevard CBD, Bogor Nirwana Residence',
//     openingHours: '09:00 - 18:00',
//     tag: 'Near Me',
//   ),
//   Place(
//     id: '8',
//     name: 'Museum Zoologi Bogor',
//     description:
//         'Museum yang menampilkan koleksi fauna Indonesia, termasuk kerangka paus biru.',
//     type: PlaceType.museum,
//     latitude: -6.597217,
//     longitude: 106.799157,
//     images: [
//       'https://zjglidcehtsqqqhbdxyp.supabase.co/storage/v1/object/public/atourin/images/destination/bogor/museum-zoologi-profile1695489301.jpeg?x-image-process=image/resize,p_100,limit_1/imageslim',
//     ],
//     rating: 4.5,
//     address: 'Jl. Ir. H. Juanda No.9, Bogor',
//     openingHours: '08:00 - 16:00',
//     tag: 'Near Me',
//   ),
//   Place(
//     id: '9',
//     name: 'Highland Park Resort Bogor',
//     description:
//         'Resor glamping gaya Mongolia dengan pemandangan Gunung Salak.',
//     type: PlaceType.hotel,
//     latitude: -6.6539,
//     longitude: 106.7395,
//     images: [
//       'https://thehighlandparkresortbogor.com/Indonesia/wp-content/uploads/slider/cache/200a712b869a7ebe8f1fc6ec6baff42d/20200229_085729.jpg',
//     ],
//     rating: 4.6,
//     address: 'Jl. Curug Nangka, Bogor',
//     amenities: ['WiFi Gratis', 'Kolam Renang', 'Area BBQ', 'Outbound'],
//     tag: 'Near Me',
//   ),
//   Place(
//     id: '10',
//     name: 'Two Stories Cafe',
//     description: 'Kafe modern dengan dua lantai dan atmosfer nyaman.',
//     type: PlaceType.cafe,
//     latitude: -6.5942,
//     longitude: 106.8016,
//     images: [
//       'https://www.taysbakers.com/wp-content/uploads/2017/07/two-stories-cafe.jpg',
//     ],
//     rating: 4.5,
//     address: 'Jl. Pajajaran Indah V, Bogor',
//     openingHours: '08:00 - 22:00',
//     tag: 'Near Me',
//   ),
//   Place(
//     id: '11',
//     name: 'Royal Tulip Gunung Geulis Resort',
//     description: 'Resor mewah dengan lapangan golf dan area spa.',
//     type: PlaceType.hotel,
//     latitude: -6.675317,
//     longitude: 106.884466,
//     images: ['https://media.iceportal.com/77983/photos/72463564_XL.jpg'],
//     rating: 4.7,
//     address: 'Jl. Pasir Angin, Gadog, Bogor',
//     amenities: ['WiFi Gratis', 'Kolam Renang', 'Spa', 'Golf Course'],
//     tag: 'Hidden Gems',
//   ),
//   Place(
//     id: '12',
//     name: 'Museum Perjuangan Bogor',
//     description:
//         'Museum yang mengisahkan sejarah perjuangan kemerdekaan Indonesia di Bogor.',
//     type: PlaceType.museum,
//     latitude: -6.595,
//     longitude: 106.793,
//     images: [
//       'https://zjglidcehtsqqqhbdxyp.supabase.co/storage/v1/object/public/atourin/images/destination/bogor/museum-perjuangan-bogor-profile1639211289.png?x-image-process=image/resize,p_100,limit_1/imageslim',
//     ],
//     rating: 4.2,
//     address: 'Jl. Merdeka No.56, Bogor',
//     openingHours: '09:00 - 17:00',
//     tag: 'Hidden Gems',
//   ),
//   Place(
//     id: '13',
//     name: 'Curug Bidadari',
//     description:
//         'Air terjun cantik dengan kolam alami, dikelilingi tebing hijau.',
//     type: PlaceType.nature,
//     latitude: -6.627222,
//     longitude: 106.857778,
//     images: [
//       'https://edensorhills.com/wp-content/uploads/2022/12/Sentul-Paradise-Park-Curug-Bidadari.jpg',
//     ],
//     rating: 4.3,
//     address: 'Sentul Paradise Park, Bogor',
//     tag: 'Hidden Gems',
//   ),
//   Place(
//     id: '14',
//     name: 'Kuntum Farmfield',
//     description: 'Wisata edukasi pertanian dan peternakan untuk keluarga.',
//     type: PlaceType.nature,
//     latitude: -6.6472,
//     longitude: 106.8275,
//     images: [
//       'https://asset.kompas.com/crops/7tq6O19DBvLYrYYq_RyxcHRMEBA=/0x64:768x576/1200x800/data/photo/2024/06/07/6662f3ef66116.jpg',
//     ],
//     rating: 4.5,
//     address: 'Jl. Raya Tajur No.291, Bogor',
//     tag: 'Hidden Gems',
//   ),
//   Place(
//     id: '15',
//     name: 'Aston Bogor Hotel & Resort',
//     description:
//         'Hotel bintang 4 dengan fasilitas lengkap dan lokasi strategis.',
//     type: PlaceType.hotel,
//     latitude: -6.6296,
//     longitude: 106.8284,
//     images: [
//       'https://cf.bstatic.com/xdata/images/hotel/max1024x768/661185300.jpg?k=e93c76ecbd691eddf132a4d3d297d26845e6fb56a5523f30b7ec8d1bf1c41e3a&o=&hp=1',
//     ],
//     rating: 4.6,
//     address: 'Jl. Dreded Pahlawan No.35, Bogor',
//     amenities: ['WiFi Gratis', 'Kolam Renang', 'Pusat Kebugaran', 'Restoran'],
//     tag: 'Hidden Gems',
//   ),
//   Place(
//     id: '16',
//     name: 'RSUD Kota Bogor',
//     description:
//         'Rumah Sakit Umum Daerah Kota Bogor, tipe B, fasilitas rawat inap, IGD, MCU lengkap.',
//     type: PlaceType.hospital,
//     latitude: -6.5883,
//     longitude: 106.7910,
//     images: [
//       'https://cdn.antaranews.com/cache/1200x800/2020/03/26/RSUD-Kota-Bogor-02.jpg',
//     ],
//     rating: 4.2,
//     address: 'Jl. Dr. Sumeru No.120, Menteng, Bogor Barat',
//     tag: '',
//   ),

//   // Hospital 2 — RS Hermina Bogor
//   Place(
//     id: '17',
//     name: 'RS Hermina Bogor',
//     description:
//         'Rumah sakit tipe B dengan layanan ICU/NICU, perinatologi, gigi spesialistik, USG 4D.',
//     type: PlaceType.hospital,
//     latitude: -6.5730,
//     longitude: 106.7810,
//     images: [
//       'https://lh4.googleusercontent.com/-L95HkiagjCw/T05U9F2xO6I/AAAAAAAAK04/CXQtnyxZOm8/s980/IMG_4464.JPG',
//     ],
//     rating: 4.3,
//     address: 'Jl. Ring Road I Kav. 23-27, Perum Taman Yasmin, Bogor',
//     tag: '',
//   ),

//   // Police Post 1 — Polres Bogor Kota
//   Place(
//     id: '18',
//     name: 'Polres Bogor Kota',
//     description:
//         'Markas Kepolisian Resor Bogor Kota, bekas bangunan kolonial Belanda.',
//     type: PlaceType.police,
//     latitude: -6.5920,
//     longitude: 106.7890,
//     images: [
//       'https://cdn.antaranews.com/cache/1200x800/2022/12/07/IMG20221207120834.jpg',
//     ],
//     rating: 4.0,
//     address: 'Jl. Kapten Muslihat No.18-21, Bogor Tengah',
//     tag: '',
//   ),

//   // Police Post 2 — Polsek Bogor Utara (placeholder)
//   Place(
//     id: '19',
//     name: 'Polsek Bogor Utara',
//     description: 'Kantor Polisi Sektor di wilayah Bogor Utara.',
//     type: PlaceType.police,
//     latitude: -6.5640,
//     longitude: 106.7880,
//     images: [
//       'https://polrinews.com/storage/2022/08/22-Nomor-Telepon-dan-Kantor-Polisi-Terdekat-Bogor.png',
//     ],
//     rating: 4.0,
//     address: 'Jl. Raya Pajajaran, Bogor Utara',
//     tag: '',
//   ),
// ];
