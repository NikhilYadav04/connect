import 'package:flutter/material.dart';

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
  // File upload states
  bool _idProofUploaded = false;
  bool _educationCertUploaded = false;
  bool _employmentProofUploaded = false;

  @override
  Widget build(BuildContext context) {
    double sh = widget.sh;
    double sw = widget.sw;

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

            // Document Upload Sections
            Column(
              children: [
                //* ID Proof
                _buildUploadCard(
                    sh,
                    sw,
                    Icons.badge_outlined,
                    "ID Proof",
                    "Government-issued ID",
                    "Upload your driver's license, passport, or national ID",
                    _idProofUploaded,
                    () => setState(() => _idProofUploaded = !_idProofUploaded),
                    required: true),
                SizedBox(height: sh * 0.03),

                //* Education Certificate
                _buildUploadCard(
                    sh,
                    sw,
                    Icons.school_outlined,
                    "Education Certificate",
                    "Degree or Certificate",
                    "Upload your highest degree, diploma, or professional certificate",
                    _educationCertUploaded,
                    () => setState(
                        () => _educationCertUploaded = !_educationCertUploaded),
                    required: true),
                SizedBox(height: sh * 0.03),

                //* Employment Proof (Optional)
                _buildUploadCard(
                    sh,
                    sw,
                    Icons.work_outline,
                    "Employment Proof",
                    "Current Employment",
                    "Upload your employment letter, pay stub, or LinkedIn profile screenshot",
                    _employmentProofUploaded,
                    () => setState(() =>
                        _employmentProofUploaded = !_employmentProofUploaded),
                    optional: true),
              ],
            ),
            SizedBox(height: sh * 0.04),

            // Verification Process Section
            Container(
              padding: EdgeInsets.all(sw * 0.04),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F9F1),
                borderRadius: BorderRadius.circular(sw * 0.03),
                border: Border.all(
                  color: const Color(0xFFE8F5E9),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(sw * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_outlined,
                          color: Colors.green,
                          size: sw * 0.045,
                        ),
                      ),
                      SizedBox(width: sw * 0.03),
                      Text(
                        "Verification Process",
                        style: TextStyle(
                          fontSize: sh * 0.018,
                          fontFamily: "Jakarta-Medium",
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sh * 0.02),
                  _buildBulletPoint(
                      sh, "Our team reviews all documents within 24-48 hours"),
                  _buildBulletPoint(sh,
                      "We verify your identity and credentials to ensure platform quality"),
                  _buildBulletPoint(sh,
                      "You'll receive email updates on your application status"),
                  _buildBulletPoint(sh,
                      "Once approved, you can start accepting consultations immediately"),
                ],
              ),
            ),
            SizedBox(height: sh * 0.04),

            // Document Upload Status
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
                    "Required documents for verification",
                    style: TextStyle(
                      fontSize: sh * 0.014,
                      fontFamily: "Jakarta-Light",
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: sh * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatusIndicator("ID", _idProofUploaded,
                          optional: true),
                      _buildStatusIndicator("Degree", _educationCertUploaded,
                          optional: true),
                      _buildStatusIndicator(
                          "Employment", _employmentProofUploaded,
                          optional: true),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: sh * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadCard(double sh, double sw, IconData icon, String title,
      String subtitle, String description, bool isUploaded, VoidCallback onTap,
      {bool required = false, bool optional = false}) {
    return Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular container for icon
              Container(
                padding: EdgeInsets.all(sw * 0.025),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon,
                    color: const Color(0xFF6C63FF), size: sw * 0.045),
              ),
              SizedBox(width: sw * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with required/optional indicators
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: sh * 0.016,
                            fontFamily: "Jakarta-Medium",
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (required) ...[
                          SizedBox(width: sw * 0.01),
                          Text(
                            "*",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: sh * 0.016,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        if (optional) ...[
                          SizedBox(width: sw * 0.01),
                          Text(
                            "(Optional)",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: sh * 0.014,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: sh * 0.005),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: sh * 0.014,
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
          SizedBox(height: sh * 0.015),

          // Description text
          Text(
            description,
            style: TextStyle(
              fontSize: sh * 0.013,
              fontFamily: "Jakarta-Light",
              color: Colors.grey[600],
              height: 1.3,
            ),
            overflow: TextOverflow.visible,
            maxLines: 3,
          ),
          SizedBox(height: sh * 0.02),

          // Upload Area
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: sh * 0.12,
                maxHeight: sh * 0.22,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isUploaded
                      ? const Color(0xFF6C63FF)
                      : Colors.grey.shade400,
                  style: BorderStyle.solid,
                  width: isUploaded ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(sw * 0.02),
                color: isUploaded
                    ? const Color(0xFF6C63FF).withOpacity(0.05)
                    : Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(sw * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isUploaded ? Icons.check_circle : Icons.upload_outlined,
                      size: sw * 0.08,
                      color: isUploaded
                          ? const Color(0xFF6C63FF)
                          : Colors.grey[500],
                    ),
                    SizedBox(height: sh * 0.012),
                    Text(
                      isUploaded
                          ? "File uploaded successfully"
                          : "Click to upload or drag and drop",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Jakarta-Medium",
                        fontSize: sh * 0.014,
                        color: isUploaded
                            ? const Color(0xFF6C63FF)
                            : Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: sh * 0.005),
                    Text(
                      "JPG, JPEG, PNG, PDF files up to 10MB",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Jakarta-Light",
                        fontSize: sh * 0.012,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: sh * 0.015),
                    ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey[700],
                        elevation: 0,
                        side: BorderSide(
                          color: Colors.grey[400]!,
                          width: 1,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.05, vertical: sh * 0.01),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sw * 0.015),
                        ),
                      ),
                      child: Text(
                        "Choose File",
                        style: TextStyle(
                          fontSize: sh * 0.013,
                          fontFamily: "Jakarta-Medium",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(double sh, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sh * 0.005),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: sh * 0.006),
            width: widget.sw * 0.015,
            height: widget.sw * 0.015,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: widget.sw * 0.03),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: sh * 0.014,
                fontFamily: "Jakarta-Light",
                color: Colors.green[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool isSelected,
      {bool optional = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: widget.sw * 0.12,
            height: widget.sw * 0.12,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.green
                  : (optional
                      ? Colors.orange.withOpacity(0.8)
                      : Colors.grey[400]),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? Colors.green[700]!
                    : (optional ? Colors.orange[700]! : Colors.grey[500]!),
                width: 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              isSelected
                  ? Icons.check
                  : (optional ? Icons.info_outline : Icons.upload_file),
              color: Colors.white,
              size: widget.sw * 0.06,
            ),
          ),
          SizedBox(height: widget.sh * 0.008),
          Text(
            label,
            style: TextStyle(
              fontSize: widget.sh * 0.014,
              fontFamily: "Jakarta-Medium",
              color: isSelected ? Colors.green : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          if (optional && !isSelected)
            Text(
              "(Optional)",
              style: TextStyle(
                fontSize: widget.sh * 0.010,
                fontFamily: "Jakarta-Light",
                color: Colors.orange[700],
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }
}
