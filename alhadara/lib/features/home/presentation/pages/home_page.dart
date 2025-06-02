import 'package:alhadara/core/constants/notification_badge.dart';
import 'package:alhadara/features/home/presentation/bloc/home_bloc.dart';
import 'package:alhadara/features/home/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/home/presentation/widgets/home_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(LoadHomeData()),
      child: Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: Color(0xffF4F8FB),
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
              child: NotificationBadge(count: 3,)
            ),
          ],
        ),
        body: const HomeForm(),
      ),
    );
  }
}
