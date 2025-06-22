import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/notification_badge.dart';
import '../../../../dependencies.dart';
import '../bloc/home_bloc.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/home_form.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(LoadHomeData()),
      child: Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: const Color(0xffF4F8FB),
        appBar: AppBar(
          toolbarHeight: AppSizes.screenHeight(context) * 0.09,
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          title: Text(
            'Hadara',
            style: TextStyle(
              color: AppColors.mainColor,
              fontSize: AppSizes.responsiveFontSize(context,
                  mobile: 32, tablet: 36, desktop: 40),
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColors.mainColor,
                size: AppSizes.screenWidth(context) * 0.09,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding:
                  EdgeInsets.only(right: AppSizes.screenWidth(context) * 0.03),
              child: const NotificationBadge(count: 3,)
            ),
          ],
        ),
        body: const HomeForm(),
      ),
    );
  }
}
