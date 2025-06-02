import 'package:flutter/material.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/app_size.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = AppSizes.screenWidth(context) * 0.06;
    final containerSize = AppSizes.screenWidth(context) * 0.12;
    final padding = AppSizes.screenWidth(context) * 0.03;
    final dividerIndent = AppSizes.screenWidth(context) * 0.05;
    final closeIconSize = AppSizes.screenWidth(context) * 0.07;

    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              // User Profile Section
              Container(
                padding: EdgeInsets.only(
                  top: AppSizes.paddingTop(context) +
                      AppSizes.screenHeight(context) * 0.02,
                  bottom: AppSizes.screenHeight(context) * 0.02,
                ),
                child: Column(
                  children: [
                    Container(
                      width: AppSizes.screenWidth(context) * 0.25,
                      height: AppSizes.screenWidth(context) * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.mainColor,
                      ),
                      child: Icon(
                        Icons.person,
                        size: iconSize,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: AppSizes.screenHeight(context) * 0.01),
                    Text(
                      'Aya Al Issa',
                      style: TextStyle(
                        fontSize: AppSizes.screenWidth(context) * 0.045,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(height: AppSizes.screenHeight(context) * 0.005),
                    Text(
                      '0951750316',
                      style: TextStyle(
                        fontSize: AppSizes.screenWidth(context) * 0.035,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                indent: dividerIndent,
                endIndent: dividerIndent,
                height: AppSizes.screenHeight(context) * 0.002,
                color: const Color.fromARGB(255, 149, 143, 143),
                thickness: AppSizes.screenHeight(context) * 0.001,
              ),

              // Main Navigation Items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding,
                    vertical: AppSizes.screenHeight(context) * 0.01,
                  ),
                  children: [
                    _buildDrawerCardItem(
                      context,
                      icon: Icons.home_outlined,
                      title: 'Home',
                      onTap: () => Navigator.pop(context),
                      containerSize: containerSize,
                      iconSize: iconSize,
                    ),
                    _buildDrawerCardItem(
                      context,
                      icon: Icons.person_outline,
                      title: 'Profile',
                      onTap: () => Navigator.pop(context),
                      containerSize: containerSize,
                      iconSize: iconSize,
                    ),
                    _buildDrawerCardItem(
                      context,
                      icon: Icons.location_on_outlined,
                      title: 'Location',
                      onTap: () => Navigator.pop(context),
                      containerSize: containerSize,
                      iconSize: iconSize,
                    ),
                  ],
                ),
              ),

              Divider(
                indent: dividerIndent,
                endIndent: dividerIndent,
                height: AppSizes.screenHeight(context) * 0.002,
                color: const Color.fromARGB(255, 145, 137, 137),
                thickness: AppSizes.screenHeight(context) * 0.001,
              ),

              // Bottom Navigation Items
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: AppSizes.screenHeight(context) * 0.01,
                ),
                child: Column(
                  children: [
                    _buildDrawerCardItem(
                      context,
                      icon: Icons.contact_support_outlined,
                      title: 'Contact Info',
                      onTap: () => Navigator.pop(context),
                      containerSize: containerSize,
                      iconSize: iconSize,
                    ),
                    _buildDrawerCardItem(
                      context,
                      icon: Icons.account_circle_outlined,
                      title: 'Account',
                      onTap: () => Navigator.pop(context),
                      containerSize: containerSize,
                      iconSize: iconSize,
                    ),
                    _buildDrawerCardItem(
                      context,
                      icon: Icons.exit_to_app_outlined,
                      title: 'Exit',
                      onTap: () => Navigator.pop(context),
                      containerSize: containerSize,
                      iconSize: iconSize,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Close (X) Icon Button
          Positioned(
            top: AppSizes.paddingTop(context) +
                AppSizes.screenHeight(context) * 0.01,
            right: AppSizes.screenWidth(context) * 0.03,
            child: Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(containerSize),
                color: const Color.fromARGB(255, 247, 222, 224),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: closeIconSize,
                  color: AppColors.mainColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerCardItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double containerSize,
    required double iconSize,
  }) {
    return Card(
      color: const Color.fromARGB(255, 245, 245, 245),
      margin: EdgeInsets.symmetric(
        vertical: AppSizes.screenHeight(context) * 0.008,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppSizes.screenWidth(context) * 0.02),
      ),
      elevation: 0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenWidth(context) * 0.04,
          vertical: AppSizes.screenHeight(context) * 0.01,
        ),
        leading: Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(containerSize),
            color: const Color.fromARGB(255, 247, 222, 224),
          ),
          child: Icon(
            icon,
            size: iconSize,
            color: AppColors.mainColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.screenWidth(context) * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
