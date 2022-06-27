import 'package:injectable/injectable.dart';

import 'StoryLocationModel.dart';

@singleton
class StoryLocationsService {

  final List<StoryLocationModel> locations = [
    StoryLocationModel(id: 1, levels: [1], backgroundFileName: "green.jpg", title: "Welcome party", coinReward: 100),
    StoryLocationModel(id: 2, levels: [2, 3, 4], backgroundFileName: "mountains_day.jpg", title: "Highest peak", coinReward: 200),
    StoryLocationModel(id: 3, levels: [5, 6, 7], backgroundFileName: "jungles.jpg", title: "Wild jungle", coinReward: 300),
    StoryLocationModel(id: 4, levels: [8, 9], backgroundFileName: "blue.jpg", title: "Foggy lands", coinReward: 400),
    StoryLocationModel(id: 5, levels: [10, 11], backgroundFileName: "mountains_night.jpg", title: "Night adventure", coinReward: 500),
    StoryLocationModel(id: 6, levels: [12], backgroundFileName: "beach_with_boat.jpg", title: "Mystery iceland", coinReward: 600),
  ];

  List<StoryLocationModel> get allLocations => locations;

  Future<StoryLocationModel> getLocationConfigById(int id) async {
    return locations.firstWhere((element) => element.id == id);
  }

  Future<StoryLocationModel> getLocationConfigByLevelId(int levelId) async {
    return locations.firstWhere((element) => element.levels.contains(levelId));
  }
}