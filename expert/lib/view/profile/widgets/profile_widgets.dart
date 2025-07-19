import 'package:cached_network_image/cached_network_image.dart';
import 'package:expert/controllers/controller_expert.dart';
import 'package:expert/core/constants/colors.dart';
import 'package:expert/core/constants/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//* Jakarta font helpers
TextStyle light(double size, [Color? color]) => TextStyle(
      fontFamily: 'Jakarta-Light',
      fontSize: size,
      color: color ?? Colors.black,
    );
TextStyle medium(double size, [Color? color]) => TextStyle(
      fontFamily: 'Jakarta-Medium',
      fontSize: size,
      color: color ?? Colors.black,
    );
TextStyle bold(double size, [Color? color]) => TextStyle(
      fontFamily: 'Jakarta-Bold',
      fontSize: size,
      color: color ?? Colors.black,
    );

Widget profileCard(
    double sw, double sh, bool isOnline, ExpertProvider provider) {
  return Container(
    padding: EdgeInsets.all(sw * 0.04),
    margin: EdgeInsets.symmetric(vertical: sh * 0.00, horizontal: sw * 0.04),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF4A6CF7), Color(0xFF8D4CF7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Top Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Avatar with Border + Camera Icon
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.6),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(sw * 0.12),
                    child: CachedNetworkImage(
                      imageUrl: provider.expertData?.profilePicture ??
                          "https://randomuser.me/api/portraits/men/46.jpg",
                      width: sw * 0.24,
                      height: sw * 0.24,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Center(
                        child: SpinKitRotatingCircle(
                          color: AppColors.colorPurple,
                          size: 35,
                        ),
                      ),
                      errorWidget: (_, __, ___) =>
                          Icon(Icons.error, size: sw * 0.1),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: sh * 0.018,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      size: sw * 0.05,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: sw * 0.04),

            //* Info Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Name + Verified Tick
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                provider.expertData?.fullName ?? "Name Error",
                                style: textStyle3.copyWith(
                                  fontSize: sh * 0.024,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: sw * 0.015),
                            provider.expertData?.isVerified ?? false
                                ? Icon(
                                    Icons.verified,
                                    color:
                                        const Color.fromARGB(255, 131, 238, 9),
                                    size: sh * 0.025,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sh * 0.012),

                  //* Subtitle in pill box
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: sw * 0.03,
                      vertical: sh * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FittedBox(
                      child: Text(
                        provider.expertData?.subcategory ?? "Expert",
                        style: medium(sh * 0.016, Colors.black87),
                      ),
                    ),
                  ),
                  SizedBox(height: sh * 0.008),

                  //* Rating
                  Text(
                    '⭐ ${provider.expertData?.rating ?? 5.0}  (${provider.expertData?.reviewsCount ?? "5"} reviews)',
                    style: medium(sh * 0.018, Colors.white),
                  ),
                  SizedBox(height: sh * 0.008),

                  //* Online Status + Switch
                  Row(
                    children: [
                      Text(
                        'Online Status:',
                        style: medium(sh * 0.019, Colors.white),
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: isOnline,
                          onChanged: (val) {},
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          activeTrackColor:
                              const Color.fromARGB(255, 131, 238, 9),
                          inactiveTrackColor: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),

                  //* Rate
                  Text(
                    'Rate: ₹${provider.expertData?.ratePerMinute}/minute',
                    style: medium(sh * 0.02, Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: sh * 0.018),

        //* Buttons Row
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _transparentButton(
                icon: Icons.edit,
                label: 'Edit',
                onTap: () {},
                sw: sw,
                sh: sh,
              ),
              SizedBox(width: sw * 0.03),
              _transparentButton(
                icon: Icons.visibility,
                label: 'Preview',
                onTap: () {},
                sw: sw,
                sh: sh,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

//* Transparent Button Widget
Widget _transparentButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required double sw,
  required double sh,
}) {
  return TextButton.icon(
    style: TextButton.styleFrom(
      backgroundColor: Colors.white.withOpacity(0.15),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: sw * 0.04,
        vertical: sh * 0.012,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.white.withOpacity(0.25)),
      ),
    ),
    icon: Icon(icon, size: sh * 0.021),
    label: Text(
      label,
      style: TextStyle(
        fontSize: sh * 0.019,
        fontFamily: 'Jakarta-Medium',
      ),
    ),
    onPressed: onTap,
  );
}

Widget expertiseTagsCard(double sw, double sh, ExpertProvider provider) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 0, vertical: sh * 0.015),
    padding: EdgeInsets.all(sw * 0.04),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expertise Tags",
          style: TextStyle(
            fontFamily: 'Jakarta-Light',
            fontSize: sh * 0.023,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: sh * 0.018),
        Wrap(
          spacing: sw * 0.025,
          runSpacing: sh * 0.012,
          children: provider.expertData!.expertise!.split("").map((tag) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: sw * 0.03,
                vertical: sh * 0.008,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontFamily: 'Jakarta-Medium',
                  fontSize: sh * 0.0185,
                  color: Colors.blue.shade900,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: sh * 0.028),
        TextButton.icon(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade800),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: sw * 0.038,
              vertical: sh * 0.012,
            ),
          ),
          icon: Icon(Icons.edit_note_sharp, size: sh * 0.028),
          label: Text(
            'Edit Tags',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Jakarta-Medium',
              fontWeight: FontWeight.bold,
              fontSize: sh * 0.018,
            ),
          ),
        ),
      ],
    ),
  );
}
