import 'package:injectable/injectable.dart';

import 'StoryLocationModel.dart';

@singleton
class StoryLocationsService {

  final List<StoryLocationModel> locations = [
    StoryLocationModel(id: 1, levels: [1, 2, 3], backgroundFileName: "green.jpg", title: "Welcome party", coinReward: 100),
    StoryLocationModel(id: 2, levels: [4, 5, 6, 7], backgroundFileName: "mountains_day.jpg", title: "Highest peak", coinReward: 200),
    StoryLocationModel(id: 3, levels: [8, 9, 10, 11, 12], backgroundFileName: "jungles.jpg", title: "Wild jungle", coinReward: 300),
    StoryLocationModel(id: 4, levels: [13, 14, 15, 16, 17, 18], backgroundFileName: "blue.jpg", title: "Foggy lands", coinReward: 400),
    StoryLocationModel(id: 5, levels: [19, 20, 21, 22, 23, 24], backgroundFileName: "mountains_night.jpg", title: "Night travel", coinReward: 500),
    StoryLocationModel(id: 6, levels: [25, 26, 27, 28, 29, 30, 31, 1000], backgroundFileName: "beach_with_boat.jpg", title: "Mystery island", coinReward: 600),
    //stub
    StoryLocationModel(id: 7, levels: [31], backgroundFileName: "green.jpg", title: "Coming soon", coinReward: 600),
  ];

  List<StoryLocationModel> get allLocations => locations;

  Future<StoryLocationModel> getLocationConfigById(int id) async {
    return locations.firstWhere((element) => element.id == id);
  }

  Future<StoryLocationModel> getLocationConfigByLevelId(int levelId) async {
    return locations.firstWhere((element) => element.levels.contains(levelId));
  }
}