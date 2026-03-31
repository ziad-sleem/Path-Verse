import 'package:flutter/material.dart';
import 'package:social_media_app_using_firebase/core/widgets/app_text.dart';
import 'package:social_media_app_using_firebase/features/create_video/presentation/pages/create_vistas_page.dart';

class VistasAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VistasAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText(text: 'Vistas', fontWeight: FontWeight.bold, fontSize: 30),
      actions: [
        // upload new post button
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateVistasPage()),
            );
          },
          child: AppText(text: "Create Vistas"),
        ),
      ],
    );
  }
}
