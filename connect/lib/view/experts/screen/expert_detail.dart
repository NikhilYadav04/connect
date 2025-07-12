import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/core/constants/colors.dart';
import 'package:connect/model/experts/expert_detail_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpertDetailPage extends StatefulWidget {
  final ExpertDetailModel expert;

  const ExpertDetailPage({Key? key, required this.expert}) : super(key: key);

  @override
  _ExpertDetailPageState createState() => _ExpertDetailPageState();
}

class _ExpertDetailPageState extends State<ExpertDetailPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final h = media.height;
    final w = media.width;
    double fontSize(double m) => m * w;

    const int initialCount = 4;
    const int maxShow = 10;
    final reviews = widget.expert.reviews;
    final int itemCount = _isExpanded
        ? min(reviews.length, maxShow)
        : min(reviews.length, initialCount);

    final visibleReviews = reviews.take(itemCount).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: h * 0.035,
            )),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: w * 0.36,
                  height: w * 0.36,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.expert.profileImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Center(
                          child: SpinKitRotatingCircle(
                        color: AppColors.colorPurple,
                        size: 35,
                      )),
                      errorWidget: (_, __, ___) =>
                          Icon(Icons.error, size: w * 0.1),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),
              Center(
                child: Text(
                  widget.expert.name,
                  style: TextStyle(
                    fontFamily: "Jakarta-Bold",
                    fontSize: fontSize(0.065),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: h * 0.005),
              Center(
                child: Text(
                  widget.expert.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Jakarta-Medium",
                    fontSize: fontSize(0.04),
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: h * 0.005),
              Center(
                child: Text(
                  widget.expert.qualification,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Jakarta-Medium",
                    fontSize: fontSize(0.035),
                    color: Colors.grey[800],
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Expertise in',
                  style: TextStyle(
                    fontFamily: "Jakarta-Bold",
                    fontSize: fontSize(0.052),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: h * 0.015),
              Wrap(
                spacing: w * 0.025,
                runSpacing: h * 0.01,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: widget.expert.expertise.map((item) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04,
                      vertical: h * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Colors.grey.shade200, // background color of the pill
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FittedBox(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontFamily: "Jakarta-Medium",
                          fontSize: fontSize(0.038),
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: h * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About',
                  style: TextStyle(
                    fontFamily: "Jakarta-Bold",
                    fontSize: fontSize(0.05),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: h * 0.01),
              Text(
                widget.expert.about,
                style: TextStyle(
                  fontFamily: "Jakarta-Medium",
                  fontSize: fontSize(0.04),
                  color: Colors.grey[800],
                  height: 1.4,
                ),
              ),
              SizedBox(height: h * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    fontFamily: "Jakarta-Bold",
                    fontSize: fontSize(0.045),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: h * 0.01),
              Row(
                children: [
                  ...List.generate(
                    5,
                    (_) =>
                        Icon(Icons.star, color: Colors.amber, size: w * 0.06),
                  ),
                  SizedBox(width: w * 0.02),
                  Text(
                    widget.expert.overallRating.toStringAsFixed(1),
                    style: TextStyle(
                      fontFamily: "Jakarta-Bold",
                      fontSize: fontSize(0.045),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.03),
              Column(
                children: visibleReviews.map((review) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: h * 0.03),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: w * 0.06,
                          backgroundImage: CachedNetworkImageProvider(
                              review.profileImageUrl),
                        ),
                        SizedBox(width: w * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.name,
                                style: TextStyle(
                                  fontFamily: "Jakarta-Bold",
                                  fontSize: fontSize(0.04),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: h * 0.005),
                              Row(
                                children: List.generate(
                                  review.rating,
                                  (_) => Icon(Icons.star,
                                      color: Colors.amber, size: w * 0.04),
                                ),
                              ),
                              SizedBox(height: h * 0.005),
                              Text(
                                review.review,
                                style: TextStyle(
                                  fontFamily: "Jakarta-Medium",
                                  fontSize: fontSize(0.036),
                                  color: Colors.grey[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isExpanded ? 'Show less' : 'Read more',
                      style: TextStyle(
                        fontFamily: "Jakarta-Bold",
                        fontSize: fontSize(0.045),
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: !_isExpanded ? h * 0.005 : 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.expand_more,
                            color: Colors.deepPurpleAccent,
                            size: w * 0.07,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contact (₹5/min)',
                  style: TextStyle(
                    fontFamily: "Jakarta-Bold",
                    fontSize: fontSize(0.045),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: h * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionCircle(FontAwesomeIcons.video, "Video",
                      width: w * 0.27,
                      height: h * 0.055,
                      onTap: () {},
                      price: "₹ 20/min"),
                  _actionCircle(FontAwesomeIcons.phone, "Audio",
                      width: w * 0.27,
                      height: h * 0.055,
                      onTap: () {},
                      price: "₹ 10/min"),
                  _actionCircle(FontAwesomeIcons.solidComment, "Text",
                      width: w * 0.27,
                      height: h * 0.055,
                      onTap: () {},
                      price: "₹ 5/min"),
                ],
              ),
              SizedBox(height: h * 0.035),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionCircle(IconData icon, String label,
      {required double width,
      required double height,
      required VoidCallback onTap,
      required String price}) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(horizontal: width * 0.05),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurpleAccent.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: height * 0.38),
              SizedBox(width: width * 0.08),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Jakarta-Medium",
                  fontSize: height * 0.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
