import 'package:expert/controllers/controller_expert.dart';
import 'package:expert/core/constants/colors.dart';
import 'package:expert/core/constants/fontFamily.dart';
import 'package:expert/http/utils/http_client.dart';
import 'package:expert/view/profile/widgets/profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ExpertProvider _provider = ExpertProvider();
  final HttpClient _httpClient = HttpClient();

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isLoading = true;
      });

      final userId = await _httpClient.getUserData() ?? "";

      if (userId != "") {
        await _provider.getExpertDetails(userId);
      }

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    // Jakarta font helpers
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

    //* Reusable card widget with gradient, shadow, icon
    Widget infoCard({
      required Gradient gradient,
      required IconData icon,
      required String title,
      required String value,
      required double sw,
      required double sh,
    }) {
      return Container(
        width: sw * 0.9,
        height: sh * 0.115,
        margin: EdgeInsets.symmetric(vertical: sh * 0.012),
        padding: EdgeInsets.all(sw * 0.04),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            //* Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: light(sh * 0.021, Colors.white70)),
                  Spacer(),
                  Text(value,
                      style: textStyle3.copyWith(
                          fontSize: sh * 0.028,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            //* Icon
            Icon(
              icon,
              color: Colors.white.withOpacity(0.85),
              size: sh * 0.035,
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.colorLightGrayBG,
          body: Consumer<ExpertProvider>(
            builder: (context, provider, _) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      floating: true,
                      snap: false,
                      automaticallyImplyLeading: false,
                      toolbarHeight: sh * 0.074,
                      backgroundColor: AppColors.colorPurple,
                      flexibleSpace: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: sh * 0.02),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Profile",
                                    style: textStyle2.copyWith(
                                      wordSpacing: 2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: sh * 0.027,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: sh * 0.02),
                  child: Center(
                    child: Column(
                      children: [
                        //* — Header with gradient background —
                        Skeletonizer(
                            enabled: _isLoading,
                            effect: ShimmerEffect(
                                baseColor: Color(0xFF4A6CF7),
                                highlightColor: Color(0xFF8D4CF7),
                                duration: Duration(milliseconds: 1500)),
                            child: profileCard(sw, sh, true, provider)),

                        SizedBox(height: sh * 0.015),

                        Skeletonizer(
                            enabled: _isLoading,
                            effect: ShimmerEffect(
                                // baseColor: Color(0xFF4A6CF7),
                                // highlightColor: Color(0xFF8D4CF7),
                                duration: Duration(milliseconds: 1500)),
                            child: expertiseTagsCard(sw, sh, provider)),

                        // SizedBox(height: sh * 0.00),

                        //* — Stats Cards with Icons —
                        Skeletonizer(
                          enabled: _isLoading,
                          effect: ShimmerEffect(
                              baseColor: Color(0xFF66BB6A),
                              highlightColor: Color(0xFF43A047),
                              duration: Duration(milliseconds: 1500)),
                          child: infoCard(
                            sw: sw,
                            sh: sh,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            icon: Icons.account_balance_wallet_outlined,
                            title: 'Lifetime Earnings',
                            value: '₹2,85,000.00',
                          ),
                        ),
                        Skeletonizer(
                          enabled: _isLoading,
                          effect: ShimmerEffect(
                              baseColor: Color(0xFF42A5F5),
                              highlightColor: Color(0xFF1E88E5),
                              duration: Duration(milliseconds: 1500)),
                          child: infoCard(
                            sw: sw,
                            sh: sh,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            icon: Icons.calendar_month_outlined,
                            title: 'Monthly Earnings',
                            value: '₹45,000.00',
                          ),
                        ),
                        Skeletonizer(
                          enabled: _isLoading,
                          effect: ShimmerEffect(
                              baseColor: Color(0xFFBA68C8),
                              highlightColor: Color(0xFF8E24AA),
                              duration: Duration(milliseconds: 1500)),
                          child: infoCard(
                            sw: sw,
                            sh: sh,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF8E24AA), Color(0xFFBA68C8)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            icon: Icons.group,
                            title: 'Total Sessions',
                            value: '1,247',
                          ),
                        ),
                        Skeletonizer(
                          enabled: _isLoading,
                          effect: ShimmerEffect(
                              baseColor: Color(0xFFFFB74D),
                              highlightColor: Color(0xFFFB8C00),
                              duration: Duration(milliseconds: 1500)),
                          child: infoCard(
                            sw: sw,
                            sh: sh,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFB8C00),
                                Color(0xFFFB8C00),
                                Color(0xFFFFB74D)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            icon: Icons.access_time,
                            title: 'Total Minutes',
                            value: '18,420',
                          ),
                        ),

                        SizedBox(
                          height: sh * 0.01,
                        ),

                        //* — Pending Payout block —
                        Container(
                          width: sw * 0.9,
                          margin: EdgeInsets.symmetric(vertical: sh * 0.01),
                          padding: EdgeInsets.all(sw * 0.045),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFFFFCC80), width: 1.2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Skeletonizer(
                            effect: ShimmerEffect(
                                baseColor: const Color(0xFFFFCC80),
                                highlightColor: const Color(0xFFFFF8E1),
                                duration: Duration(milliseconds: 1500)),
                            enabled: _isLoading,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pending Payout',
                                  style: textStyle3.copyWith(
                                      fontSize: sw * 0.045,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: sh * 0.015),
                                Text(
                                  '₹${provider.payoutAmount}',
                                  style: textStyle3.copyWith(
                                      fontSize: sw * 0.07,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: sh * 0.015),
                                Text(
                                  'Available for withdrawal',
                                  style: light(sw * 0.038),
                                ),
                                SizedBox(height: sh * 0.03),
                                Row(
                                  children: [
                                    //* Withdraw Button
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFFFFB74D), // light orange
                                        foregroundColor:
                                            Colors.white, // icon and text color
                                        padding: EdgeInsets.symmetric(
                                          horizontal: sw * 0.05,
                                          vertical: sh * 0.014,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.download_rounded,
                                        size: sh * 0.026,
                                      ),
                                      label: Text('Withdraw',
                                          style: textStyle2.copyWith(
                                              fontSize: sw * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    SizedBox(width: sw * 0.03),
                                    //* View Details Button
                                    OutlinedButton.icon(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            Colors.black, // icon and text color
                                        side: BorderSide(
                                            color: Colors.grey.shade400),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: sw * 0.04,
                                          vertical: sh * 0.014,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      icon: Icon(Icons.analytics_outlined,
                                          size: sh * 0.027),
                                      label: Text('View Details',
                                          style: textStyle2.copyWith(
                                              fontSize: sw * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade800)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
