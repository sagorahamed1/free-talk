import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/custom_network_image.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final List<String> maleAvatars = [
    'https://www.icon0.com/free/static2/preview2/stock-photo-avatar-male-in-glasses-people-icon-character-cartoon-33223.jpg',
    'https://www.icon0.com/free/static2/preview2/stock-photo-avatar-man-people-icon-character-cartoon-32597.jpg',
    'https://www.icon0.com/free/static2/preview2/stock-photo-men-in-futuristic-fashion-avatar-people-icon-character-cartoon-33002.jpg',
    'https://www.icon0.com/free/static2/preview2/stock-photo-avatar-man-people-icon-character-cartoon-32593.jpg',
    'https://static.vecteezy.com/system/resources/previews/004/476/164/original/young-man-avatar-character-icon-free-vector.jpg',
    'https://img.freepik.com/free-vector/smiling-young-man-illustration_1308-173524.jpg',
    'https://img.freepik.com/free-vector/young-man-with-glasses-illustration_1308-174706.jpg',
    'https://img.freepik.com/free-vector/young-man-black-shirt_1308-173618.jpg',
    'https://img.freepik.com/premium-photo/anime-male-avatar_950633-917.jpg',
    'https://img.freepik.com/premium-photo/anime-male-avatar_950633-935.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkRXkzsMiktb7eSeJBM9-CAasHV63nzvcqaUvbaE120spEl22s_ueWVIJ7eh_rRy1qTpA&usqp=CAU',
    'https://img.freepik.com/premium-photo/anime-male-avatar_950633-904.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz2xs75rI3wEmHJ1GzYsfGgrMjXRc2bsPV4qckSvMfIkx8K_wv0GSDFhv4fWV0nuCai4Q&usqp=CAU',
  ];

  final List<String> femaleAvatars = [
    'https://img.freepik.com/free-photo/woman-with-black-dress-gold-ring-her-left-eye_1340-37539.jpg',
    'https://img.freepik.com/free-photo/digital-art-selected_1340-37659.jpg',
    'https://t3.ftcdn.net/jpg/06/49/36/36/360_F_649363606_DxINGavthJcaBzFuQk7Z3OOcbVOBTQyH.jpg',
    'https://img.freepik.com/premium-photo/photo_1087825-10473.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCgvln6o0CPgeTZ-wNxqNLxBW8dy9dJ68ibtVTqakC6CIfVIyHTxMJnGbV-wEfQBkrR8s&usqp=CAU',
    'https://img.freepik.com/premium-photo/cute-girl-avatar-model-style-with-tshirt-print-full-body-hd-image-portrait-photo-vector-art_231078-274.jpg',
    'https://img.freepik.com/premium-photo/cute-girl-3d-avatar-model-style-with-tshirt-print-full-body-hd-image-portrait-photo-vector-art_231078-265.jpg',
    'https://img.freepik.com/premium-vector/vector-muslim-woman-avatar-female-vector-arab-people-icon-saudi-character-minimalistic-simple-flat_615232-2336.jpg',
    'https://img.freepik.com/premium-vector/vector-muslim-woman-avatar-female-vector-arab-people-icon-saudi-character-minimalistic-simple-flat_615232-2336.jpg',
    'https://t4.ftcdn.net/jpg/07/91/83/55/360_F_791835517_6f3ytbGWYrbVbzqc8vnGLrWIGqFMU12X.jpg',
    'https://static.vecteezy.com/system/resources/thumbnails/029/796/026/small_2x/asian-girl-anime-avatar-ai-art-photo.jpg',
    'https://img.freepik.com/free-photo/beautiful-cartoon-woman-portrait_23-2151839661.jpg',
    'https://a0.anyrgb.com/pngimg/956/254/retro-girl-avatar-hair-accessories-avatar-retro-girl-painted-girl-silhouette-sexy-girls-retro-style-fashion-girl-thumbnail.png',
    'https://cdn.imgbin.com/25/16/25/imgbin-sexy-girls-788xeXZMU96FvLhbXvEPgaXwu.jpg',
  ];

  String? selectedAvatarUrl;
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          'Select Avatar',
          style: TextStyle(
            fontSize: 20.h,
            fontWeight: FontWeight.bold,
            color:
            Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Top Image Display
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: selectedAvatarUrl != null
                  ? CustomNetworkImage(
                  boxShape: BoxShape.circle,
                  border: Border.all(color: Colors.greenAccent, width: 0.5),
                  imageUrl: selectedAvatarUrl.toString() , height: 100.h, width: 100.w)
                  : Container(
                height: 100,
                width: 100,
                color: Colors.grey[300],
                child: const Center(child: Text('Select an Avatar')),
              ),
            ),


            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select',
                style: TextStyle(
                  fontSize: 20.h,
                  fontWeight: FontWeight.bold,
                  color:
                  Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: selectedGender == 'Male'
                    ? maleAvatars.length
                    : femaleAvatars.length,
                itemBuilder: (context, index) {
                  final avatarUrl = selectedGender == 'Male'
                      ? maleAvatars[index]
                      : femaleAvatars[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatarUrl = avatarUrl;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedAvatarUrl == avatarUrl
                              ? Colors.blue
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: Image.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Save Profile Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Save the selected avatar or other profile details
                  print('Selected Avatar: $selectedAvatarUrl');
                },
                child: Text('Save Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
