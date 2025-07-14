// presentation/widgets/create_lesson_combo_form.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../bloc/lesson_combo/lesson_combo_bloc.dart';
class CreateLessonComboForm extends StatefulWidget {
  const CreateLessonComboForm({super.key});

  @override
  State<CreateLessonComboForm> createState() => _CreateLessonComboFormState();
}

class _CreateLessonComboFormState extends State<CreateLessonComboForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  final _linkController = TextEditingController();
  final _homeworkTitleController = TextEditingController();
  final _homeworkDescriptionController = TextEditingController();
  final _homeworkFormLinkController = TextEditingController();
  final _homeworkMaxScoreController = TextEditingController(text: '10');

  File? _selectedFile;
  String? _status = 'scheduled';
  DateTime? _lessonDate;
  DateTime? _homeworkDeadline;
  bool _isHomeworkMandatory = true;

  // This would come from your app state or API
  final int _courseId = 71;
  final int _scheduleSlotId = 281;
  final List<Map<String, dynamic>> _students = [
    {'enrollment': 1, 'name': 'Student 1', 'present': true},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    _linkController.dispose();
    _homeworkTitleController.dispose();
    _homeworkDescriptionController.dispose();
    _homeworkFormLinkController.dispose();
    _homeworkMaxScoreController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      // For Android 10+ (API 29+), file_picker uses the system document picker
      // which doesn't require explicit storage permissions
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
        withData: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        if (file.path != null) {
          setState(() {
            _selectedFile = File(file.path!);
          });
        } else {
          // Handle case where path is null (can happen on some Android versions)
          // Copy file to app's cache directory
          final tempDir = await getTemporaryDirectory();
          final tempFile = File('${tempDir.path}/${file.name}');

          if (file.bytes != null) {
            await tempFile.writeAsBytes(file.bytes!);
            setState(() {
              _selectedFile = tempFile;
            });
          } else {
            // Try to read the file using readStream if available
            if (file.readStream != null) {
              final bytes = <int>[];
              await for (final chunk in file.readStream!) {
                bytes.addAll(chunk);
              }
              await tempFile.writeAsBytes(bytes);
              setState(() {
                _selectedFile = tempFile;
              });
            } else {
              throw Exception('Unable to access file data');
            }
          }
        }
      }
    } on PlatformException catch (e) {
      print('PlatformException: ${e.code} - ${e.message}');
      if (mounted) {
        String errorMessage = 'Failed to pick file';
        if (e.code == 'read_external_storage_denied') {
          errorMessage = 'File access denied. Please try again and allow file access.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      print('Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }
  Future<void> _selectDate(BuildContext context, bool isLessonDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isLessonDate) {
          _lessonDate = pickedDate;
        } else {
          _homeworkDeadline = pickedDate;
        }
      });
    }
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final attendanceRecords = _status == 'completed'
        ? _students.map((student) {
      return {
        'enrollment': student['enrollment'],
        'attendance': student['present'] ? 'present' : 'absent',
      };
    }).toList()
        : null;

    context.read<LessonComboBloc>().add(
      CreateLessonComboEvent(
        title: _titleController.text,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        file: _selectedFile,
        link: _linkController.text.isNotEmpty ? _linkController.text : null,
        courseId: _courseId,
        scheduleSlotId: _scheduleSlotId,
        lessonDate: _lessonDate != null
            ? DateFormat('yyyy-MM-dd').format(_lessonDate!)
            : DateFormat('yyyy-MM-dd').format(DateTime.now()),
        status: _status!,
        homeworkTitle: _homeworkTitleController.text.isNotEmpty
            ? _homeworkTitleController.text
            : null,
        homeworkDescription: _homeworkDescriptionController.text.isNotEmpty
            ? _homeworkDescriptionController.text
            : null,
        homeworkFormLink: _homeworkFormLinkController.text.isNotEmpty
            ? _homeworkFormLinkController.text
            : null,
        homeworkDeadline: _homeworkDeadline,
        homeworkMaxScore: _homeworkMaxScoreController.text.isNotEmpty
            ? int.tryParse(_homeworkMaxScoreController.text)
            : null,
        homeworkIsMandatory: _homeworkTitleController.text.isNotEmpty
            ? _isHomeworkMandatory
            : null,
        attendanceRecords: attendanceRecords,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LessonComboBloc, LessonComboState>(
      listener: (context, state) {
        if (state is LessonComboSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lesson created successfully')),
          );
          // Navigator.of(context).pop();
        } else if (state is LessonComboFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Lesson Section
              _buildSectionHeader('Lesson Details'),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title*'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _linkController,
                decoration: const InputDecoration(labelText: 'External Link'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _lessonDate == null
                          ? 'Select Lesson Date'
                          : 'Date: ${DateFormat('yyyy-MM-dd').format(_lessonDate!)}',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, true),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                items: const [
                  DropdownMenuItem(value: 'scheduled', child: Text('Scheduled')),
                  DropdownMenuItem(value: 'completed', child: Text('Completed')),
                ],
                onChanged: (value) => setState(() => _status = value),
                decoration: const InputDecoration(labelText: 'Status*'),
              ),
              const SizedBox(height: 16),
              _buildFilePicker(),
              const SizedBox(height: 24),

              // Homework Section
              _buildSectionHeader('Homework (Optional)'),
              TextFormField(
                controller: _homeworkTitleController,
                decoration: const InputDecoration(labelText: 'Homework Title'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _homeworkDescriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _homeworkFormLinkController,
                decoration: const InputDecoration(labelText: 'Form Link'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _homeworkDeadline == null
                          ? 'Select Homework Deadline'
                          : 'Deadline: ${DateFormat('yyyy-MM-dd').format(_homeworkDeadline!)}',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, false),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _homeworkMaxScoreController,
                decoration: const InputDecoration(labelText: 'Max Score'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Mandatory Homework'),
                value: _isHomeworkMandatory,
                onChanged: (value) => setState(() => _isHomeworkMandatory = value),
              ),
              const SizedBox(height: 24),

              // Attendance Section (only shown if status is completed)
              if (_status == 'completed') ...[
                _buildSectionHeader('Attendance'),
                ..._students.map((student) => CheckboxListTile(
                  title: Text(student['name']),
                  value: student['present'],
                  onChanged: (value) => setState(() {
                    student['present'] = value ?? false;
                  }),
                )).toList(),
                const SizedBox(height: 24),
              ],

              // Submit Button
              BlocBuilder<LessonComboBloc, LessonComboState>(
                builder: (context, state) {
                  if (state is LessonComboLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: _onSubmit,
                    child: const Text('Create Lesson'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFilePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Lesson Materials (PDF, DOC, PPT)'),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: _pickFile,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.attach_file),
              const SizedBox(width: 8),
              Text(_selectedFile == null
                  ? 'Select File'
                  : 'Selected: ${_selectedFile!.path.split('/').last}'),
            ],
          ),
        ),
        if (_selectedFile != null) ...[
          const SizedBox(height: 8),
          Text(
            'File ready for upload',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ],
    );
  }
}