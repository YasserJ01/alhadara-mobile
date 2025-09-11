import '../../../../core/constants/app_scaffold.dart';
import '../../../../dependencies.dart';
import 'package:project2/features/complaints/presentation/pages/complaint_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/complaint_bloc.dart';
import '../widgets/complaint_card.dart';

class ComplaintsListPage extends StatelessWidget {
  const ComplaintsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text('My Complaints'),
    //   ),
    //   body: BlocProvider(
    //     create: (context) => getIt<ComplaintBloc>()..add(LoadComplaints()),
    //     child: BlocBuilder<ComplaintBloc, ComplaintState>(
    //       builder: (context, state) {
    //         if (state is ComplaintLoading) {
    //           return const Center(child: CircularProgressIndicator());
    //         } else if (state is ComplaintError) {
    //           return Center(child: Text(state.message));
    //         } else if (state is ComplaintsLoaded) {
    //           return ListView.builder(
    //             itemCount: state.complaints.length,
    //             itemBuilder: (context, index) {
    //               return ComplaintCard(complaint: state.complaints[index]);
    //             },
    //           );
    //         }
    //         return const Center(child: Text('No complaints found'));
    //       },
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => BlocProvider.value(
    //             value: BlocProvider.of<ComplaintBloc>(context),
    //             child: ComplaintPage(enrollmentId: 1), // استبدل بالقيمة الفعلية
    //           ),
    //         ),
    //       );
    //     },
    //     child: const Icon(Icons.add),
    //   ),
    // );
    AppScaffold(title: 'My Complaints',
    body:
      BlocProvider(
        create: (context) => getIt<ComplaintBloc>()..add(LoadComplaints()),
        child: BlocBuilder<ComplaintBloc, ComplaintState>(
          builder: (context, state) {
            if (state is ComplaintLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ComplaintError) {
              return Center(child: Text(state.message));
            } else if (state is ComplaintsLoaded) {
              return ListView.builder(
                itemCount: state.complaints.length,
                itemBuilder: (context, index) {
                  return ComplaintCard(complaint: state.complaints[index]);
                },
              );
            }
            return const Center(child: Text('No complaints found'));
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => BlocProvider.value(
      //           value: BlocProvider.of<ComplaintBloc>(context),
      //           child: ComplaintPage(enrollmentId: 1), // استبدل بالقيمة الفعلية
      //         ),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
