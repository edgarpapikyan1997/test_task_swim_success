import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/user_model.dart';
import '../widgets/user_detail_section.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(user.username, style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.xl),
          UserDetailSection(
            title: 'CONTACT',
            rows: [
              UserDetailRow(label: 'Email', value: user.email),
              UserDetailRow(label: 'Phone', value: user.phone),
              UserDetailRow(label: 'Website', value: user.website),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          UserDetailSection(
            title: 'ADDRESS',
            rows: [
              UserDetailRow(label: 'Street', value: user.address.street),
              UserDetailRow(label: 'City', value: user.address.city),
              UserDetailRow(label: 'Zip', value: user.address.zipcode),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          UserDetailSection(
            title: 'COMPANY',
            rows: [
              UserDetailRow(label: 'Name', value: user.company.name),
            ],
          ),
        ],
      ),
    );
  }
}
