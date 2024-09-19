
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>> pickImages({int maxImages = 10}) async {
    final List<XFile>? images = await _picker.pickMultiImage(
      imageQuality: 85,
    );

    if (images != null && images.length > maxImages) {
      return images.sublist(0, maxImages);
    }

    return images ?? [];
  }

  Future<List<XFile>> pickVideos({int maxVideos = 1}) async {
    List<XFile> videos = [];

    for (int i = 0; i < maxVideos; i++) {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 20),
      );

      if (video != null) {
        videos.add(video);
      }
    }

    return videos;
  }
}
