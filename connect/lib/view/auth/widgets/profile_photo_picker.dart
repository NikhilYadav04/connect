import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePhotoPicker extends StatefulWidget {
  final Function(File?) onImageSelected;
  final File? selectedImage;

  const ProfilePhotoPicker({
    Key? key,
    required this.onImageSelected,
    this.selectedImage,
  }) : super(key: key);

  @override
  State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _showImageSourceDialog() async {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: sw * 0.05,
            vertical: sh * 0.1,
          ),
          child: Container(
            width: sw * 0.9,
            padding: EdgeInsets.all(sw * 0.06),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sw * 0.04),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Select Profile Photo",
                        style: TextStyle(
                          fontSize: sh * 0.024,
                          fontFamily: "Jakarta-Bold",
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(sw * 0.015),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.grey[600],
                          size: sw * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.008),
                Text(
                  "Choose how you'd like to select your profile photo",
                  style: TextStyle(
                    fontSize: sh * 0.016,
                    fontFamily: "Jakarta-Light",
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: sh * 0.025),

                // Camera Option
                GestureDetector(
                  onTap: () => _pickImage(ImageSource.camera),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(sw * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(sw * 0.02),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(sw * 0.03),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: const Color(0xFF6C63FF),
                            size: sw * 0.06,
                          ),
                        ),
                        SizedBox(width: sw * 0.04),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Camera",
                                style: TextStyle(
                                  fontSize: sh * 0.018,
                                  fontFamily: "Jakarta-Medium",
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: sh * 0.004),
                              Text(
                                "Take a new photo",
                                style: TextStyle(
                                  fontSize: sh * 0.014,
                                  fontFamily: "Jakarta-Light",
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[500],
                          size: sw * 0.04,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: sh * 0.015),

                // Gallery Option
                GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(sw * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(sw * 0.02),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(sw * 0.03),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.photo_library_outlined,
                            color: const Color(0xFF6C63FF),
                            size: sw * 0.06,
                          ),
                        ),
                        SizedBox(width: sw * 0.04),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gallery",
                                style: TextStyle(
                                  fontSize: sh * 0.018,
                                  fontFamily: "Jakarta-Medium",
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: sh * 0.004),
                              Text(
                                "Choose from your photos",
                                style: TextStyle(
                                  fontSize: sh * 0.014,
                                  fontFamily: "Jakarta-Light",
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[500],
                          size: sw * 0.04,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: sh * 0.02),

                // Skip Option
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onImageSelected(null);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: sh * 0.01),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(sw * 0.02),
                    ),
                  ),
                  child: Text(
                    "Skip for now",
                    style: TextStyle(
                      fontSize: sh * 0.016,
                      fontFamily: "Jakarta-Medium",
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        Navigator.of(context).pop(); // Close the dialog
        widget.onImageSelected(File(image.path));
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close the dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: _showImageSourceDialog,
      child: Container(
        width: sw * 0.25,
        height: sw * 0.25,
        decoration: BoxDecoration(
          color: widget.selectedImage != null 
              ? Colors.transparent 
              : Colors.grey[100],
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.selectedImage != null 
                ? const Color(0xFF6C63FF) 
                : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: widget.selectedImage != null
            ? ClipOval(
                child: Image.file(
                  widget.selectedImage!,
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: sw * 0.08,
                    color: Colors.grey[500],
                  ),
                  SizedBox(height: sh * 0.008),
                  Text(
                    "Add Photo",
                    style: TextStyle(
                      fontSize: sh * 0.012,
                      fontFamily: "Jakarta-Medium",
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}