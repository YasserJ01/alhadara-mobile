// pages/bulletin_post_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../dependencies.dart';
import '../../../domain/entities/bulletin_post_entity.dart';
import '../../../domain/usecases/publish_post_usecase.dart';
import '../../bloc/bulletin_post/bulletin_post_bloc.dart';
import '../../bloc/bulletin_post/bulletin_post_event.dart';
import '../../widgets/teacher/bulletin_post_view.dart';
class BulletinPostPage extends StatelessWidget {
  final int scheduleSlotId;
  const BulletinPostPage({
    Key? key,
    required this.scheduleSlotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BulletinPostBloc(
        publishPostUseCase: getIt<PublishPostUseCase>(),
      )..add(PostTypeChanged(PostType.message)),
      child: BulletinPostView(scheduleSlotId: scheduleSlotId),
    );
  }
}
