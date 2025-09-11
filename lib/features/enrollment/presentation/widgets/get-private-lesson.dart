import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/enrollment/presentation/widgets/privete-lesson_card.dart';
import '../../domain/entities/private_lesson_request.dart';
import '../bloc/get_private_lesson/private_lesson_requests_list_bloc.dart';

class PrivateLessonRequestsListView extends StatelessWidget {
  const PrivateLessonRequestsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrivateLessonRequestsListBloc,
        PrivateLessonRequestsListState>(
      listener: (context, state) {
        if (state.showSuccess != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Operation completed successfully!'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case PrivateLessonRequestsListStatus.initial:
          case PrivateLessonRequestsListStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case PrivateLessonRequestsListStatus.success:
            return _buildRequestsList(context, state.requests);
          case PrivateLessonRequestsListStatus.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.errorMessage}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<PrivateLessonRequestsListBloc>()
                          .add(LoadPrivateLessonRequests());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
        }
      },
    );
  }

  Widget _buildRequestsList(
      BuildContext context, List<PrivateLessonRequest> requests) {
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_note, size: 60, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No requests found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create a new request to get started',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<PrivateLessonRequestsListBloc>()
            .add(LoadPrivateLessonRequests());
      },
      child: AnimatedList(
        padding: const EdgeInsets.all(16),
        initialItemCount: requests.length,
        itemBuilder: (context, index, animation) {
          final request = requests[index];
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutQuart,
            )),
            child: FadeTransition(
              opacity: animation,
              child: PrivateLessonRequestCard(request: request),
            ),
          );
        },
      ),
    );
  }
}
