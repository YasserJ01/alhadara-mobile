// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../bloc/feedback_bloc.dart';
// import '../../domain/entities/feedback_entity.dart';

// class FeedbackForm extends StatefulWidget {
//   final int scheduleSlotId;
//   final int studentId;

//   const FeedbackForm({
//     Key? key,
//     required this.scheduleSlotId,
//     required this.studentId,
//   }) : super(key: key);

//   @override
//   _FeedbackFormState createState() => _FeedbackFormState();
// }

// class _FeedbackFormState extends State<FeedbackForm> {
//   final _formKey = GlobalKey<FormState>();
//   int _teacherRating = 0;
//   int _materialRating = 0;
//   int _facilitiesRating = 0;
//   int _appRating = 0;
//   String _notes = '';

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<FeedbackBloc, FeedbackState>(
//       listener: (context, state) {
//         if (state is FeedbackSubmitted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Feedback submitted successfully!')),
//           );
//           Navigator.of(context).pop();
//         } else if (state is FeedbackError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         }
//       },
//       builder: (context, state) {
//         return Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 _buildRatingField(
//                   label: 'Teacher Rating',
//                   value: _teacherRating,
//                   onChanged: (value) => setState(() => _teacherRating = value),
//                 ),
//                 _buildRatingField(
//                   label: 'Material Rating',
//                   value: _materialRating,
//                   onChanged: (value) => setState(() => _materialRating = value),
//                 ),
//                 _buildRatingField(
//                   label: 'Facilities Rating',
//                   value: _facilitiesRating,
//                   onChanged: (value) => setState(() => _facilitiesRating = value),
//                 ),
//                 _buildRatingField(
//                   label: 'App Rating',
//                   value: _appRating,
//                   onChanged: (value) => setState(() => _appRating = value),
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Notes'),
//                   maxLines: 3,
//                   onChanged: (value) => _notes = value,
//                 ),
//                 const SizedBox(height: 20),
//                 state is FeedbackLoading
//                     ? const CircularProgressIndicator()
//                     : ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             final feedback = FeedbackEntity(
//                               scheduleslot: widget.scheduleSlotId,
//                               student: widget.studentId,
//                               teacherRating: _teacherRating,
//                               materialRating: _materialRating,
//                               facilitiesRating: _facilitiesRating,
//                               appRating: _appRating,
//                               notes: _notes,
//                             );
//                             context.read<FeedbackBloc>().add(SubmitFeedbackEvent(feedback));
//                           }
//                         },
//                         child: const Text('Submit Feedback'),
//                       ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildRatingField({
//     required String label,
//     required int value,
//     required ValueChanged<int> onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('$label: $value'),
//         Slider(
//           min: 0,
//           max: 100,
//           divisions: 10,
//           value: value.toDouble(),
//           onChanged: (newValue) => onChanged(newValue.toInt()),
//         ),
//       ],
//     );
//   }
// }