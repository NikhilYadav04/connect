import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadCard extends StatefulWidget {
  final double sh, sw;
  final IconData icon;
  final String title, subtitle, description;
  final Function(File?) onFileSelected;
  final bool required, optional;

  const FileUploadCard({
    super.key,
    required this.sh,
    required this.sw,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.onFileSelected,
    this.required = false,
    this.optional = false,
  });

  @override
  State<FileUploadCard> createState() => _FileUploadCardState();
}

class _FileUploadCardState extends State<FileUploadCard> {
  File? selectedFile;
  String? fileName;
  String? errorMessage;
  final ImagePicker _picker = ImagePicker();

  bool get isUploaded => selectedFile != null && fileName != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.sw * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(widget.sw * 0.02),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(widget.sw * 0.025),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon,
                    color: const Color(0xFF6C63FF), size: widget.sw * 0.045),
              ),
              SizedBox(width: widget.sw * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleWithIndicators(),
                    SizedBox(height: widget.sh * 0.005),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: widget.sh * 0.014,
                        fontFamily: "Jakarta-Light",
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: widget.sh * 0.015),

          // Description
          Text(
            widget.description,
            style: TextStyle(
              fontSize: widget.sh * 0.013,
              fontFamily: "Jakarta-Light",
              color: Colors.grey[600],
              height: 1.3,
            ),
            overflow: TextOverflow.visible,
            maxLines: 3,
          ),
          SizedBox(height: widget.sh * 0.02),

          // Upload Area
          InkWell(
            onTap: _pickFile,
            borderRadius: BorderRadius.circular(widget.sw * 0.02),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: widget.sh * 0.12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isUploaded
                      ? const Color(0xFF6C63FF)
                      : (errorMessage != null
                          ? Colors.red
                          : Colors.grey.shade400),
                  style: BorderStyle.solid,
                  width: isUploaded ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(widget.sw * 0.02),
                color: isUploaded
                    ? const Color(0xFF6C63FF).withOpacity(0.05)
                    : (errorMessage != null
                        ? Colors.red.withOpacity(0.05)
                        : Colors.white),
              ),
              child: Padding(
                padding: EdgeInsets.all(widget.sw * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isUploaded && fileName != null && selectedFile != null)
                      _fileDisplay()
                    else
                      _uploadPrompt(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleWithIndicators() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: widget.sh * 0.016,
            fontFamily: "Jakarta-Medium",
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (widget.required) ...[
          SizedBox(width: widget.sw * 0.01),
          Text("*",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: widget.sh * 0.016,
                  fontWeight: FontWeight.bold)),
        ],
        if (widget.optional) ...[
          SizedBox(width: widget.sw * 0.01),
          Text(
            "(Optional)",
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: widget.sh * 0.014,
                fontStyle: FontStyle.italic),
          ),
        ],
      ],
    );
  }

  Widget _fileDisplay() {
    bool isPDF = fileName!.toLowerCase().endsWith('.pdf');

    return Column(
      children: [
        // Preview - Image or PDF icon
        if (isPDF)
          Container(
            height: widget.sh * 0.1,
            width: widget.sw * 0.2,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(widget.sw * 0.02),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.picture_as_pdf,
                    color: Colors.red, size: widget.sw * 0.06),
                Text('PDF',
                    style: TextStyle(
                        color: Colors.red, fontSize: widget.sh * 0.01)),
              ],
            ),
          )
        else
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.sw * 0.02),
            child: Image.file(selectedFile!,
                height: widget.sh * 0.1,
                width: widget.sw * 0.2,
                fit: BoxFit.cover),
          ),
        SizedBox(height: widget.sh * 0.01),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(widget.sw * 0.02),
              decoration: BoxDecoration(
                color: (isPDF ? Colors.red : Colors.blue).withOpacity(0.1),
                borderRadius: BorderRadius.circular(widget.sw * 0.015),
              ),
              child: Icon(isPDF ? Icons.picture_as_pdf : Icons.image,
                  size: widget.sw * 0.05,
                  color: isPDF ? Colors.red : Colors.blue),
            ),
            SizedBox(width: widget.sw * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName!,
                    style: TextStyle(
                      fontFamily: "Jakarta-Medium",
                      fontSize: widget.sh * 0.014,
                      color: const Color(0xFF6C63FF),
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  FutureBuilder<int>(
                    future: selectedFile!.length(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        double sizeInMB = snapshot.data! / (1024 * 1024);
                        String size = sizeInMB < 1
                            ? '${(sizeInMB * 1024).toStringAsFixed(0)} KB'
                            : '${sizeInMB.toStringAsFixed(1)} MB';
                        String fileType = isPDF ? "PDF" : "JPG";
                        return Text(
                          "$fileType • $size",
                          style: TextStyle(
                              fontFamily: "Jakarta-Light",
                              fontSize: widget.sh * 0.012,
                              color: Colors.grey[600]),
                        );
                      }
                      return Text(isPDF ? "PDF" : "JPG",
                          style: TextStyle(
                              fontFamily: "Jakarta-Light",
                              fontSize: widget.sh * 0.012,
                              color: Colors.grey[600]));
                    },
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _removeFile,
              icon: Container(
                padding: EdgeInsets.all(widget.sw * 0.01),
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(Icons.close,
                    color: Colors.red[700], size: widget.sw * 0.04),
              ),
            ),
          ],
        ),
        SizedBox(height: widget.sh * 0.015),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: widget.sw * 0.03, vertical: widget.sh * 0.01),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(widget.sw * 0.015),
            border: Border.all(color: Colors.green.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle,
                  size: widget.sw * 0.04, color: Colors.green[700]),
              SizedBox(width: widget.sw * 0.02),
              Text(
                "File ready to upload",
                style: TextStyle(
                  fontFamily: "Jakarta-Medium",
                  fontSize: widget.sh * 0.013,
                  color: Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _uploadPrompt() {
    return Column(
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: widget.sw * 0.1,
          color: errorMessage != null ? Colors.red : const Color(0xFF6C63FF),
        ),
        SizedBox(height: widget.sh * 0.015),
        Text(
          errorMessage ?? "Select image or PDF file",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Jakarta-Medium",
            fontSize: widget.sh * 0.015,
            color: errorMessage != null ? Colors.red : Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: widget.sh * 0.008),
        Text(
          errorMessage != null
              ? "Please choose a smaller file or try again"
              : "Take a photo, choose from gallery, or select PDF\nJPG, PNG, PDF files up to 10MB",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Jakarta-Light",
            fontSize: widget.sh * 0.012,
            color: errorMessage != null ? Colors.red[400] : Colors.grey[500],
            height: 1.3,
          ),
        ),
        SizedBox(height: widget.sh * 0.02),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF),
            borderRadius: BorderRadius.circular(widget.sw * 0.02),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _pickFile,
              borderRadius: BorderRadius.circular(widget.sw * 0.02),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.sw * 0.06, vertical: widget.sh * 0.015),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_a_photo,
                        color: Colors.white, size: widget.sw * 0.045),
                    SizedBox(width: widget.sw * 0.02),
                    Text(
                      "Select File",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: widget.sh * 0.014,
                        fontFamily: "Jakarta-Medium",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickFile() async {
    try {
      setState(() => errorMessage = null);
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => SelectionBottomSheet(
            onCamera: _pickFromCamera,
            onGallery: _pickFromGallery,
            onPDF: _pickPDFFile),
      );
    } catch (e) {
      setState(() => errorMessage = "Error selecting file: ${e.toString()}");
    }
  }

  Future<void> _pickFromCamera() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85);
    if (image != null) await _processSelectedFile(File(image.path), image.name);
  }

  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85);
    if (image != null) await _processSelectedFile(File(image.path), image.name);
  }

  Future<void> _pickPDFFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        String fileName = result.files.single.name;
        File file = File(filePath);
        await _processSelectedFile(file, fileName);
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('PDF Selection'),
          content: Text(
              'PDF selection is not available on this device. Please take a photo of the document or use an image file instead.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('OK')),
          ],
        ),
      );
    }
  }

  Future<void> _processSelectedFile(File file, String name) async {
    try {
      int fileSizeInBytes = await file.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 10) {
        setState(() => errorMessage =
            "File size (${fileSizeInMB.toStringAsFixed(1)}MB) exceeds 10MB limit");
        return;
      }

      String extension = name.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'pdf'].contains(extension)) {
        setState(() => errorMessage =
            "File type not supported. Please select JPG, PNG, or PDF files.");
        return;
      }

      setState(() {
        selectedFile = file;
        fileName = name;
        errorMessage = null;
      });

      widget.onFileSelected(file);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('File selected successfully!')),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      setState(() => errorMessage = "Error processing file: ${e.toString()}");
    }
  }

  void _removeFile() {
    setState(() {
      selectedFile = null;
      fileName = null;
      errorMessage = null;
    });
    widget.onFileSelected(null);
  }
}

class SelectionBottomSheet extends StatelessWidget {
  final VoidCallback onCamera, onGallery, onPDF;

  const SelectionBottomSheet(
      {super.key,
      required this.onCamera,
      required this.onGallery,
      required this.onPDF});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(height: 20),
            Text('Select File Source',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.camera_alt, color: Colors.blue),
              ),
              title: Text('Take Photo'),
              subtitle: Text('Capture document with camera'),
              onTap: () {
                Navigator.pop(context);
                onCamera();
              },
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.photo_library, color: Colors.green),
              ),
              title: Text('Choose from Gallery'),
              subtitle: Text('Select image from gallery'),
              onTap: () {
                Navigator.pop(context);
                onGallery();
              },
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.picture_as_pdf, color: Colors.red),
              ),
              title: Text('Choose PDF'),
              subtitle: Text('Select PDF document'),
              onTap: () {
                Navigator.pop(context);
                onPDF();
              },
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
            ),
          ],
        ),
      ),
    );
  }
}
