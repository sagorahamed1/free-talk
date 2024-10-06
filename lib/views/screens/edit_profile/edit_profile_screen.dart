import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final List<String> maleAvatars = [
    'https://example.com/male_avatar1.png',
    'https://example.com/male_avatar2.png',
    'https://example.com/male_avatar3.png',
    'https://example.com/male_avatar4.png',
    'https://example.com/male_avatar5.png',
  ];

  final List<String> femaleAvatars = [
    'https://example.com/female_avatar1.png',
    'https://example.com/female_avatar2.png',
    'https://example.com/female_avatar3.png',
    'https://example.com/female_avatar4.png',
    'https://example.com/female_avatar5.png',
  ];

  late String selectedAvatarUrl;
  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Column(
        children: [
          // Top Image Display
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: selectedAvatarUrl != null
                ? Image.network(
              selectedAvatarUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )
                : Container(
              height: 100,
              width: 100,
              color: Colors.grey[300],
              child: Center(child: Text('Select an Avatar')),
            ),
          ),
          // Gender Dropdown
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: DropdownButton<String>(
          //     value: selectedGender,
          //     // onChanged: (String newValue) {
          //     //   setState(() {
          //     //     selectedGender = newValue;
          //     //     selectedAvatarUrl = null; // Reset selected avatar
          //     //   });
          //     // },
          //     items: <String>['Male', 'Female']
          //         .map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ),
          // Avatar Selection Grid
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
    );
  }
}
