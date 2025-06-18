import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../dependencies.dart';
import '../bloc/profile_image/profile_image_bloc.dart';
import '../bloc/view_profile/profile_bloc.dart';
import 'profile_page.dart';

class ProfileImageUploadPage extends StatefulWidget {
  const ProfileImageUploadPage({Key? key}) : super(key: key);

  @override
  State<ProfileImageUploadPage> createState() => _ProfileImageUploadPageState();
}

class _ProfileImageUploadPageState extends State<ProfileImageUploadPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error taking photo: $e')),
      );
    }
  }

  void _uploadImage() {
    if (_selectedImage != null) {
      context.read<ProfileImageBloc>().add(UploadProfileImageEvent(_selectedImage!));
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _takePhoto();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Profile Picture'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<ProfileImageBloc, ProfileImageState>(
        listener: (context, state) {
          if (state is ProfileImageUploaded) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => getIt<ProfileBloc>(),
                  // or your DI method
                  child: const ProfilePage(),
                ),
              ),
            );
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('Profile picture uploaded successfully!'),
            //     backgroundColor: Colors.green,
            //   ),
            // );
            // Optionally navigate back or refresh profile
            // Navigator.pop(context, true);
          } else if (state is ProfileImageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Image Preview Section
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                    color: Colors.grey[100],
                  ),
                  child: _selectedImage != null
                      ? ClipOval(
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  )
                      : const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // Select Image Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: state is ProfileImageLoading ? null : _showImageSourceDialog,
                    icon: const Icon(Icons.add_a_photo),
                    label: Text(_selectedImage == null ? 'Select Image' : 'Change Image'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Upload Button
                if (_selectedImage != null)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: state is ProfileImageLoading ? null : _uploadImage,
                      icon: state is ProfileImageLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : const Icon(Icons.cloud_upload),
                      label: Text(state is ProfileImageLoading ? 'Uploading...' : 'Upload'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Progress Indicator
                if (state is ProfileImageLoading)
                  const Column(
                    children: [
                      LinearProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Uploading your profile picture...'),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}