import 'package:flutter/material.dart';
import '../../domain/entity/profile.dart';
import 'interest_chip.dart';

class ProfileContent extends StatefulWidget {
  final Profile profile;

  const ProfileContent({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  void _showFullScreenImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Picture and Edit Button
          Stack(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: GestureDetector(
                  onTap: () => _showFullScreenImage(widget.profile.image!),
                  child: Hero(
                    tag: 'imageHero',
                    child: widget.profile.image == null
                        ? CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.person,
                                size: 60, color: Colors.grey),
                          )
                        : CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                              widget.profile.image!,
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                  ),
                ),
              ),
              // Container(
              //   height: 150,
              //   width: 150,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(100),
              //     color: Colors.red
              //   ),
              //   child: Image.network(
              //     profile.image!,
              //     fit: BoxFit.contain,
              //     loadingBuilder: (context, child, loadingProgress) {
              //       if (loadingProgress == null) return child;
              //       return Container(
              //         color: Colors.grey[200],
              //         child: Center(
              //           child: CircularProgressIndicator(
              //             value: loadingProgress.expectedTotalBytes != null
              //                 ? loadingProgress.cumulativeBytesLoaded /
              //                     loadingProgress.expectedTotalBytes!
              //                 : null,
              //           ),
              //         ),
              //       );
              //     },
              //     errorBuilder: (context, error, stackTrace) {
              //       return Container(
              //         color: Colors.grey[200],
              //         child: const Center(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(
              //                 Icons.broken_image,
              //                 color: Colors.grey,
              //                 size: 40,
              //               ),
              //               SizedBox(height: 8),
              //               Text(
              //                 'Failed to load',
              //                 style: TextStyle(
              //                   color: Colors.grey,
              //                   fontSize: 12,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              //   // child: const Icon(Icons.person, size: 60, color: Colors.grey),
              // ),
              Positioned(
                bottom: 0,
                right: 0,
                // left: 65,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(162, 12, 13, 1.0),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                    onPressed: () {},
                    constraints: const BoxConstraints(
                      minWidth: 42,
                      minHeight: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          // Greeting Text
          Text(
            widget.profile.fullName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 24),

          /*Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child:*/
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Personal Information",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                _buildProfileField(
                  Icons.event_outlined,
                  'Date Of Birth',
                  _formatDate(widget.profile.birthDate),
                ),
                const SizedBox(height: 12),
                _buildProfileField(
                  widget.profile.gender == "male"
                      ? Icons.male_outlined
                      : Icons.female_outlined,
                  'Gender',
                  _capitalizeFirst(widget.profile.gender),
                ),
                const SizedBox(height: 12),
                _buildProfileField(
                  Icons.location_on_outlined,
                  'Address',
                  widget.profile.address,
                ),
                const SizedBox(height: 12),

                // Academic Details Section - Conditionally shown based on academicStatus
                if (widget.profile.academicStatus != "not_studying") ...[
                  const Text(
                    "Academic Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildProfileField(
                    Icons.workspace_premium_outlined,
                    'Academic Status',
                    _capitalizeFirst(widget.profile.academicStatus),
                  ),
                  const SizedBox(height: 12),

                  // Only show university and study field if not high_school
                  if (widget.profile.academicStatus != "high_school") ...[
                    _buildProfileField(
                      Icons.school_outlined,  // Changed icon to be more appropriate
                      'University',
                      widget.profile.universityName ?? "None",
                    ),
                    const SizedBox(height: 12),
                    _buildProfileField(
                      Icons.menu_book_outlined,  // Changed icon to be more appropriate
                      'Study Field',
                      widget.profile.studyfieldName ?? "None",
                    ),
                    const SizedBox(height: 12),
                  ],
                ],

                // Interests Section
                const Text(
                  "Interests",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.profile.interests
                            .map((interest) => InterestChip(interest: interest))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ),
          // Profile Fields

          // Interests Section
        ],
      ),
    );
  }

  Widget _buildProfileField(IconData icon, String label, String value) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(244, 240, 240, 1.0),
          ),
          child: Icon(icon),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Color.fromRGBO(162, 12, 13, 1.0),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
    // return Container(
    //   margin: const EdgeInsets.only(bottom: 16),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         label,
    //         style: TextStyle(
    //           fontSize: 14,
    //           color: Colors.grey[600],
    //           fontWeight: FontWeight.w500,
    //         ),
    //       ),
    //       const SizedBox(height: 8),
    //       Container(
    //         width: double.infinity,
    //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    //         decoration: BoxDecoration(
    //           color: Colors.grey[100],
    //           borderRadius: BorderRadius.circular(8),
    //           border: Border.all(color: Colors.grey[300]!),
    //         ),
    //         child: Text(
    //           value,
    //           style: const TextStyle(
    //             fontSize: 16,
    //             color: Colors.black87,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final months = [
        '',
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      return '${date.day} ${months[date.month]} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
