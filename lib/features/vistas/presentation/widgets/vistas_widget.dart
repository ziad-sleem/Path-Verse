import 'package:flutter/material.dart';
import 'package:social_media_app_using_firebase/core/widgets/app_text.dart';
import 'package:social_media_app_using_firebase/features/create_video/domain/entities/video_entity.dart';
import 'package:social_media_app_using_firebase/features/vistas/presentation/pages/vistas_details_page.dart';

class VistasWidget extends StatelessWidget {
  final VideoEntity video;
  const VistasWidget({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VistasDetailsPage(video: video),
        ),
      ),
      child: Column(
        children: [
          // image
          videoCover(video.videoCover),
          // profile image & caption & video info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // profile image
                    profileImage(video.userImage),

                    SizedBox(width: 10),

                    // user name
                    AppText(
                      text: video.userName,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(height: 20),

                AppText(text: video.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// profile image
  Widget profileImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(100),
      child: Image.network(image, height: 40),
    );
  }

  /// video cover
  Widget videoCover(String cover) {
    return Image.network(
      cover,
      height: 200,
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}
