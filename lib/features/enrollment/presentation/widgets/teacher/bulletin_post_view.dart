import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../../domain/entities/bulletin_post_entity.dart';
import '../../bloc/bulletin_post/bulletin_post_bloc.dart';
import '../../bloc/bulletin_post/bulletin_post_event.dart';
import '../../bloc/bulletin_post/bulletin_post_state.dart';
class BulletinPostView extends StatefulWidget {
  final int scheduleSlotId;

  const BulletinPostView({
    Key? key,
    required this.scheduleSlotId,
  }) : super(key: key);

  @override
  State<BulletinPostView> createState() => _BulletinPostViewState();
}

class _BulletinPostViewState extends State<BulletinPostView> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publish to Bulletin Board'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: BlocListener<BulletinPostBloc, BulletinPostState>(
        listener: (context, state) {
          if (state is BulletinPostSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Post published successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<BulletinPostBloc, BulletinPostState>(
          builder: (context, state) {
            if (state is BulletinPostFormState) {
              return _buildForm(context, state);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, BulletinPostFormState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostTypeSelector(state),
            const SizedBox(height: 16),
            _buildTitleField(state),
            const SizedBox(height: 16),
            _buildContentField(state),
            const SizedBox(height: 16),
            if (state.type == PostType.file) _buildFileSelector(state),
            if (state.type == PostType.image) _buildImageSelector(state),
            const SizedBox(height: 16),
            if (state.errorMessage != null) _buildErrorMessage(state),
            const SizedBox(height: 24),
            _buildPublishButton(state),
          ],
        ),
      ),
    );
  }

  Widget _buildPostTypeSelector(BulletinPostFormState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Post Type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<PostType>(
                    title: const Text('Message'),
                    value: PostType.message,
                    groupValue: state.type,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<BulletinPostBloc>().add(PostTypeChanged(value));
                      }
                    },
                    dense: true,
                  ),
                ),
                Expanded(
                  child: RadioListTile<PostType>(
                    title: const Text('File'),
                    value: PostType.file,
                    groupValue: state.type,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<BulletinPostBloc>().add(PostTypeChanged(value));
                      }
                    },
                    dense: true,
                  ),
                ),
                Expanded(
                  child: RadioListTile<PostType>(
                    title: const Text('Image'),
                    value: PostType.image,
                    groupValue: state.type,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<BulletinPostBloc>().add(PostTypeChanged(value));
                      }
                    },
                    dense: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField(BulletinPostFormState state) {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: 'Title *',
        border: OutlineInputBorder(),
        hintText: 'Enter post title',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
      onChanged: (value) {
        context.read<BulletinPostBloc>().add(TitleChanged(value));
      },
    );
  }

  Widget _buildContentField(BulletinPostFormState state) {
    return TextFormField(
      controller: _contentController,
      decoration: const InputDecoration(
        labelText: 'Content *',
        border: OutlineInputBorder(),
        hintText: 'Enter post content',
      ),
      maxLines: 5,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter content';
        }
        return null;
      },
      onChanged: (value) {
        context.read<BulletinPostBloc>().add(ContentChanged(value));
      },
    );
  }

  Widget _buildFileSelector(BulletinPostFormState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select File',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (state.filePath != null) ...[
              Text('Selected: ${state.filePath!.split('/').last}'),
              const SizedBox(height: 8),
            ],
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.any,
                  allowMultiple: false,
                );
                if (result != null && result.files.isNotEmpty) {
                  context.read<BulletinPostBloc>().add(
                    FileSelected(result.files.first.path),
                  );
                }
              },
              icon: const Icon(Icons.attach_file),
              label: const Text('Choose File'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSelector(BulletinPostFormState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Image',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (state.imagePath != null) ...[
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(state.imagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  allowMultiple: false,
                );
                if (result != null && result.files.isNotEmpty) {
                  context.read<BulletinPostBloc>().add(
                    ImageSelected(result.files.first.path),
                  );
                }
              },
              icon: const Icon(Icons.image),
              label: const Text('Choose Image'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage(BulletinPostFormState state) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              state.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPublishButton(BulletinPostFormState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state.isPublishing || !state.isFormValid
            ? null
            : () {
          if (_formKey.currentState!.validate()) {
            context.read<BulletinPostBloc>().add(
              PublishPost(widget.scheduleSlotId),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: state.isPublishing
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : const Text(
          'Publish Post',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}