import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/features/complaints/presentation/pages/complaints_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../dependencies.dart';
import '../bloc/complaint_bloc.dart';
import '../widgets/complaint_form.dart';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ComplaintBloc>(),
      child: AppScaffold(
        icon: Icons.article_outlined,
        onPressedEndIcon: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => 
                 const ComplaintsListPage(),
              ),
            
          );
        },
        title: 'Complaint',
        body: MultiBlocListener(
          listeners: [
            BlocListener<ComplaintBloc, ComplaintState>(
              listener: (context, state) {
                if (state is ComplaintSubmitted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Complaint submitted successfully!')),
                  );
                } else if (state is ComplaintError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
            ),
          ],
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ComplaintForm(),
              ),
              BlocBuilder<ComplaintBloc, ComplaintState>(
                builder: (context, state) {
                  if (state is ComplaintLoading) {
                    return Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}