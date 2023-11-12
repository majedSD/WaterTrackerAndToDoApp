import 'package:flutter/material.dart';
import 'package:todoproject/ui/screen/edit_profile.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({super.key, this.enableOnTap = true});

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            if (enableOnTap) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(),
                ),
              );
            }
          },
          tileColor: Colors.green,
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(
            'Majedul Islam',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'majedulislam117@gmail.com',
            style: TextStyle(
              color: Colors.white60,
            ),
          ),
          trailing: enableOnTap ? Icon(Icons.arrow_forward) : null,
        ),
      ],
    );
  }
}
