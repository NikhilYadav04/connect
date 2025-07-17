import 'package:expert/controllers/controller_expert.dart';
import 'package:expert/view/join/screens/basic_info_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Page 2: Professional Details
class ProfessionalDetailsPage extends StatefulWidget {
  final double sh;
  final double sw;
  const ProfessionalDetailsPage(
      {super.key, required this.sh, required this.sw});

  @override
  State<ProfessionalDetailsPage> createState() =>
      _ProfessionalDetailsPageState();
}

class _ProfessionalDetailsPageState extends State<ProfessionalDetailsPage> {
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
                          "2",
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
                          "Professional Details",
                          style: TextStyle(
                            fontSize: sh * 0.022,
                            fontFamily: "Jakarta-Bold",
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Share your experience",
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

                // Current Position Section
                _buildSectionCard(
                  icon: Icons.work_outline,
                  title: "Current Position",
                  children: [
                    buildTextField(
                        "Job Title", provider.jobTitleController, sw, sh,
                        hintText: "e.g., Senior Software Engineer",
                        required: true),
                    SizedBox(height: sh * 0.025),
                    buildTextField(
                        "Company", provider.companyController, sw, sh,
                        hintText: "e.g., Google, Microsoft, Freelance",
                        required: true),
                    SizedBox(height: sh * 0.025),
                    _buildDropdownField(
                        "Years of Experience",
                        provider.selectedExperience,
                        provider.experienceOptions,
                        provider.updateExperience,
                        sw,
                        sh,
                        required: true),
                  ],
                ),
                SizedBox(height: sh * 0.03),

                // Expertise Category Section
                _buildSectionCard(
                  title: "Expertise Category",
                  children: [
                    _buildDropdownField(
                        "Primary Category",
                        provider.selectedCategory,
                        provider.categoryOptions,
                        provider.updateCategory,
                        sw,
                        sh,
                        required: true),
                    SizedBox(height: sh * 0.025),
                    _buildDropdownField(
                        "Subcategory",
                        provider.selectedSubcategory,
                        provider.subcategoryOptions,
                        provider.updateSubcategory,
                        sw,
                        sh,
                        required: true),
                  ],
                ),
                SizedBox(height: sh * 0.03),

                //* Expertise Tags Section
                _buildSectionCard(
                  title: "Expertise Tags",
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              fontSize: sh * 0.017,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Jakarta-Regular",
                              color: Colors.black87,
                            ),
                            controller: provider.tagController,
                            decoration: InputDecoration(
                              hintText:
                                  "Add a skill or expertise (e.g., React, Python, Strategy)",
                              hintStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: sh * 0.016,
                                fontFamily: "Jakarta-Light",
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(sw * 0.02),
                                borderSide: BorderSide(
                                    color: Colors.grey[300]!, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(sw * 0.02),
                                borderSide: BorderSide(
                                    color: Colors.grey[300]!, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(sw * 0.02),
                                borderSide: const BorderSide(
                                    color: Color(0xFF6C63FF), width: 2),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: sw * 0.04, vertical: sh * 0.018),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            onSubmitted: provider.addTag,
                          ),
                        ),
                        SizedBox(width: sw * 0.02),
                        Container(
                          height: sh * 0.05,
                          width: sh * 0.05,
                          decoration: const BoxDecoration(
                            color: Color(0xFF6C63FF),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () =>
                                provider.addTag(provider.tagController.text),
                            icon: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    if (provider.tags.isNotEmpty) ...[
                      SizedBox(height: sh * 0.02),
                      Wrap(
                        spacing: sw * 0.02,
                        runSpacing: sh * 0.01,
                        children: provider.tags
                            .map((tag) => _buildTagChip(tag, provider))
                            .toList(),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: sh * 0.03),

                //* Professional Bio Section
                _buildSectionCard(
                  title: "Professional Bio",
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Tell us about yourself",
                            style: TextStyle(
                              fontFamily: "Jakarta-Medium",
                              fontSize: sh * 0.016,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                            children: const [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: sh * 0.008),
                        TextField(
                          autocorrect: true,
                          controller: provider.bioController,
                          maxLines: 6,
                          maxLength: 200,
                          decoration: InputDecoration(
                            hintText:
                                "Describe your professional background, achievements, and what makes you unique as an expert. This will be visible to potential clients.",
                            hintStyle: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: sh * 0.016,
                              fontFamily: "Jakarta-Light",
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                              borderSide: BorderSide(
                                  color: Colors.grey[300]!, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                              borderSide: BorderSide(
                                  color: Colors.grey[300]!, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                              borderSide: const BorderSide(
                                  color: Color(0xFF6C63FF), width: 2),
                            ),
                            contentPadding: EdgeInsets.all(sw * 0.04),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(
                            fontSize: sh * 0.017,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Jakarta-Regular",
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: sh * 0.025),
                    buildTextField("LinkedIn Profile",
                        provider.linkedinUrlController, sw, sh,
                        hintText: "Enter LinkedIn URL", required: true),
                  ],
                ),
                SizedBox(height: sh * 0.03),

                //* Pricing & Availability Section
                _buildSectionCard(
                  icon: Icons.attach_money,
                  title: "Pricing & Availability",
                  iconColor: Colors.green,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Rate per Minute (INR)",
                            style: TextStyle(
                              fontFamily: "Jakarta-Medium",
                              fontSize: sh * 0.016,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                            children: const [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        SizedBox(height: sh * 0.008),
                        TextField(
                          controller: provider.rateController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.currency_rupee,
                                color: Colors.grey[600]),
                            hintText: "5.00",
                            hintStyle: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: sh * 0.02,
                              fontFamily: "Jakarta-Light",
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                              borderSide: BorderSide(
                                  color: Colors.grey[300]!, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                              borderSide: BorderSide(
                                  color: Colors.grey[300]!, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                              borderSide: const BorderSide(
                                  color: Color(0xFF6C63FF), width: 2),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: sw * 0.04, vertical: sh * 0.018),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(
                            fontSize: sh * 0.02,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Jakarta-Regular",
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: sh * 0.005),
                        Text(
                          "Average rate: ₹3-15/minute depending on expertise",
                          style: TextStyle(
                            fontSize: sh * 0.013,
                            fontFamily: "Jakarta-Light",
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: sh * 0.025),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available for Consultations",
                          style: TextStyle(
                            fontFamily: "Jakarta-Medium",
                            fontSize: sh * 0.016,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: sh * 0.008),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.9,
                              child: Switch(
                                value: provider.isAvailable,
                                onChanged: provider.updateAvailability,
                                activeColor: Colors.grey[700],
                              ),
                            ),
                            SizedBox(width: sw * 0.02),
                            Text(
                              provider.isAvailable
                                  ? "Available"
                                  : "Not Available",
                              style: TextStyle(
                                fontSize: sh * 0.02,
                                fontFamily: "Jakarta-Medium",
                                color: provider.isAvailable
                                    ? Colors.grey.shade900
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: sh * 0.005),
                        Text(
                          "You can change this anytime after approval",
                          style: TextStyle(
                            fontSize: sh * 0.013,
                            fontFamily: "Jakarta-Light",
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.02),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionCard(
      {IconData? icon,
      String? title,
      Color? iconColor,
      required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.all(widget.sw * 0.03),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(widget.sw * 0.02),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon,
                      color: iconColor ?? const Color(0xFF6C63FF),
                      size: widget.sw * 0.05),
                  SizedBox(width: widget.sw * 0.02),
                ],
                Text(
                  title,
                  style: TextStyle(
                    fontSize: widget.sh * 0.018,
                    fontFamily: "Jakarta-Medium",
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: widget.sh * 0.02),
          ],
          ...children,
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String? value, List<String> options,
      Function(String?) onChanged, double sw, double sh,
      {bool required = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontFamily: "Jakarta-Medium",
              fontSize: sh * 0.016,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            children: required
                ? [
                    const TextSpan(
                        text: ' *', style: TextStyle(color: Colors.red))
                  ]
                : [],
          ),
        ),
        SizedBox(height: sh * 0.008),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            label: Text(
              'Select ${label.toLowerCase()}',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: sh * 0.016,
                fontFamily: "Jakarta-Light",
              ),
            ),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(sw * 0.02),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(sw * 0.02),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(sw * 0.02),
              borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: sw * 0.04, vertical: sh * 0.018),
            filled: true,
            fillColor: Colors.white,
          ),
          items: options
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: onChanged,
          style: TextStyle(
            fontFamily: "Jakarta-Medium",
            fontSize: sh * 0.016,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTagChip(String tag, ExpertProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.sw * 0.03, vertical: widget.sh * 0.01),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(widget.sw * 0.04),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: TextStyle(
                fontSize: widget.sh * 0.014,
                fontFamily: "Jakarta-Medium",
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(width: widget.sw * 0.01),
          GestureDetector(
            onTap: () => provider.removeTag(tag),
            child: Icon(
              Icons.close,
              size: widget.sw * 0.04,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
