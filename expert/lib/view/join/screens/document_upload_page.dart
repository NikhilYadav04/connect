import 'package:expert/controllers/controller_expert.dart';
import 'package:expert/view/join/screens/file_uplaod_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Page 3: Document Verification
class DocumentVerificationPage extends StatefulWidget {
  final double sh;
  final double sw;
  const DocumentVerificationPage(
      {super.key, required this.sh, required this.sw});

  @override
  State<DocumentVerificationPage> createState() =>
      _DocumentVerificationPageState();
}

class _DocumentVerificationPageState extends State<DocumentVerificationPage> {
 
  @override
  Widget build(BuildContext context) {
    double sh = widget.sh;
    double sw = widget.sw;

    return Consumer<ExpertProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(sw * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with circular badge
                Row(
                  children: [
                    Container(
                      width: sw * 0.08,
                      height: sw * 0.08,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6C63FF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "3",
                          style: TextStyle(
                            fontSize: sh * 0.018,
                            fontFamily: "Jakarta-Bold",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: sw * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Document Verification",
                          style: TextStyle(
                            fontSize: sh * 0.022,
                            fontFamily: "Jakarta-Bold",
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Verify your credentials",
                          style: TextStyle(
                            fontSize: sh * 0.014,
                            fontFamily: "Jakarta-Light",
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.04),

                // Security Info Box
                Container(
                  padding: EdgeInsets.all(sw * 0.04),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FF),
                    borderRadius: BorderRadius.circular(sw * 0.03),
                    border: Border.all(
                      color: const Color(0xFFE0E7FF),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.06),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(sw * 0.02),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.security,
                          color: Colors.blue[700],
                          size: sw * 0.045,
                        ),
                      ),
                      SizedBox(width: sw * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your documents are secure:",
                              style: TextStyle(
                                fontSize: sh * 0.016,
                                fontFamily: "Jakarta-Medium",
                                color: Color.fromARGB(255, 14, 102, 190),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: sh * 0.008),
                            Text(
                              "All uploaded files are encrypted and stored securely. We only use them for verification purposes and never share them with third parties.",
                              style: TextStyle(
                                fontSize: sh * 0.015,
                                fontFamily: "Jakarta-Light",
                                color: Color.fromARGB(255, 12, 110, 209),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sh * 0.04),

                // Document Upload Sections - Using provider methods
                Column(
                  children: [
                    //* Company ID Card
                    FileUploadCard(
                      sh: sh,
                      sw: sw,
                      icon: Icons.badge_outlined,
                      title: "Company ID Card",
                      subtitle: "Employee Identification",
                      description:
                          "Upload your current company ID card or employee badge",
                      onFileSelected: provider.updateCompanyIdCard,
                      required: true,
                    ),
                    SizedBox(height: sh * 0.03),

                    //* Joining Letter
                    FileUploadCard(
                      sh: sh,
                      sw: sw,
                      icon: Icons.work_outline,
                      title: "Joining Letter",
                      subtitle: "Employment Verification",
                      description:
                          "Upload your joining letter, offer letter, or employment contract",
                      onFileSelected: provider.updateJoiningLetter,
                      required: true,
                    ),
                    SizedBox(height: sh * 0.03),

                    //* Degree Certificate
                    FileUploadCard(
                      sh: sh,
                      sw: sw,
                      icon: Icons.school_outlined,
                      title: "Degree Certificate",
                      subtitle: "Educational Qualification",
                      description:
                          "Upload your highest degree, diploma, or professional certificate",
                      onFileSelected: provider.updateDegree,
                      required: true,
                    ),
                    SizedBox(height: sh * 0.03),

                    //* Other Certificates (Optional)
                    FileUploadCard(
                      sh: sh,
                      sw: sw,
                      icon: Icons.workspace_premium_outlined,
                      title: "Other Certificates",
                      subtitle: "Additional Qualifications",
                      description:
                          "Upload any additional certifications, awards, or professional credentials",
                      onFileSelected: provider.updateOtherCertificates,
                      optional: true,
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.04),

                // Document Upload Status - Using provider data
                Container(
                  padding: EdgeInsets.all(sw * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(sw * 0.02),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.upload_file,
                              color: Colors.grey[600], size: sw * 0.05),
                          SizedBox(width: sw * 0.02),
                          Text(
                            "Document Upload Status",
                            style: TextStyle(
                              fontSize: sh * 0.016,
                              fontFamily: "Jakarta-Medium",
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sh * 0.01),
                      Text(
                        "${provider.uploadedDocumentsCount}/3 required documents uploaded",
                        style: TextStyle(
                          fontSize: sh * 0.014,
                          fontFamily: "Jakarta-Light",
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: sh * 0.02),

                      // Progress indicator
                      Container(
                        width: double.infinity,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: provider.uploadedDocumentsCount / 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: provider.uploadedDocumentsCount == 3
                                  ? Colors.green
                                  : const Color(0xFF6C63FF),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: sh * 0.02),

                      Wrap(
                        spacing: sw * 0.02,
                        runSpacing: sh * 0.01,
                        children: [
                          _buildStatusChip(
                              "ID Card", provider.companyIdCardUploaded),
                          _buildStatusChip(
                              "Letter", provider.joiningLetterUploaded),
                          _buildStatusChip("Degree", provider.degreeUploaded),
                          _buildStatusChip(
                              "Others", provider.otherCertificatesUploaded,
                              optional: true),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sh * 0.04),

                // Validation Status
                if (provider.validateDocuments())
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(sw * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(sw * 0.02),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle,
                            color: Colors.green, size: sw * 0.05),
                        SizedBox(width: sw * 0.02),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "All required documents uploaded!",
                                style: TextStyle(
                                  fontSize: sh * 0.016,
                                  fontFamily: "Jakarta-Medium",
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "You can now proceed to submit your application",
                                style: TextStyle(
                                  fontSize: sh * 0.014,
                                  fontFamily: "Jakarta-Light",
                                  color: Colors.green[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(sw * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(sw * 0.02),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: Colors.orange, size: sw * 0.05),
                        SizedBox(width: sw * 0.02),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Complete document upload",
                                style: TextStyle(
                                  fontSize: sh * 0.016,
                                  fontFamily: "Jakarta-Medium",
                                  color: Colors.orange[700],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Please upload all required documents to proceed",
                                style: TextStyle(
                                  fontSize: sh * 0.014,
                                  fontFamily: "Jakarta-Light",
                                  color: Colors.orange[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: sh * 0.02),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String label, bool isUploaded,
      {bool optional = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.sw * 0.03,
        vertical: widget.sh * 0.01,
      ),
      decoration: BoxDecoration(
        color: isUploaded
            ? Colors.green.withOpacity(0.1)
            : (optional ? Colors.orange.withOpacity(0.1) : Colors.grey[100]),
        borderRadius: BorderRadius.circular(widget.sw * 0.02),
        border: Border.all(
          color: isUploaded
              ? Colors.green
              : (optional ? Colors.orange : Colors.grey[400]!),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUploaded ? Icons.check_circle : Icons.circle_outlined,
            size: widget.sw * 0.04,
            color: isUploaded
                ? Colors.green
                : (optional ? Colors.orange : Colors.grey[500]),
          ),
          SizedBox(width: widget.sw * 0.01),
          Text(
            label,
            style: TextStyle(
              fontSize: widget.sh * 0.013,
              fontFamily: "Jakarta-Medium",
              color: isUploaded
                  ? Colors.green[700]
                  : (optional ? Colors.orange[700] : Colors.grey[600]),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (optional && !isUploaded) ...[
            SizedBox(width: widget.sw * 0.01),
            Text(
              "(Optional)",
              style: TextStyle(
                fontSize: widget.sh * 0.010,
                fontFamily: "Jakarta-Light",
                color: Colors.orange[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
