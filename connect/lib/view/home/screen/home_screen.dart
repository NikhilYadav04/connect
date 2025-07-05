import 'package:connect/core/constants/colors.dart';
import 'package:connect/core/router/appRouter.dart';
import 'package:connect/model/experts/expert_detail_card_model.dart';
import 'package:connect/model/home/home_expert_model.dart';
import 'package:connect/view/home/widgets/home_expert_card.dart';
import 'package:connect/view/home/widgets/home_screen_widgets.dart';
import 'package:connect/view/home/widgets/home_search_field.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  //* handle navigation
  void _handleNav(Developer dev) {
    final expertDetailModel = ExpertDetailModel(
        name: dev.name,
        title: dev.subtitle,
        qualification: dev.qualification,
        profileImageUrl: dev.profileImageUrl,
        expertise: dev.expertise,
        about: dev.about,
        overallRating: dev.rating,
        reviews: reviews);
    Navigator.pushNamed(
      context,
      '/expert-detail-screen',
      arguments: {
        'transition': TransitionType.fade,
        'expert': expertDetailModel,
        'duration': 300,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.colorLightGrayBG,
          resizeToAvoidBottomInset: false,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: sh * 0.365,
                  backgroundColor: AppColors.colorPurple,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF667CEB),
                            Color(0xFF8A74DA),
                            Color(0xFF8F3EB8),
                          ],
                          stops: [0.0, 0.35, 1.0],
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: sh * 0.05),
                          headerTitle(sh, sw),
                          SizedBox(height: sh * 0.035),

                          //* Header Title
                          titleText("Find Your Expert", sh),
                          SizedBox(height: sh * 0.015),

                          //* Header Subtitle
                          subtitleText(
                              "Connect instantly with professionals", sh),

                          //* Search Field
                          Padding(
                            padding: EdgeInsets.only(
                              top: sh * 0.03,
                              bottom: bottomInset,
                            ),
                            child: SearchTextField(
                              controller: _textEditingController,
                              verticalPadding: sh * 0.018,
                              horizontalPadding: sw * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: sh * 0.03,
                    ),

                    // //* category Slider
                    // CategorySlider(
                    //   label: "Categories",
                    //   items: categoryItems,
                    //   sh: sh,
                    //   sw: sw,
                    // ),

                    // SizedBox(
                    //   height: sh * 0.035,
                    // ),

                    //* Wallet Balance Card
                    walletButton(sh, sw),

                    SizedBox(
                      height: sh * 0.032,
                    ),

                    //* Trending Experts

                    expertsLabel(sh),

                    SizedBox(
                      height: sh * 0.025,
                    ),

                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: developers.length,
                      itemBuilder: (context, index) {
                        final dev = developers[index];
                        return GestureDetector(
                          onTap: () async {
                            _handleNav(dev);
                          },
                          child: DeveloperCard(
                            sh: sh,
                            sw: sw,
                            name: dev.name,
                            subtitle: dev.subtitle,
                            rate: dev.rate,
                            rating: dev.rating,
                            reviewCount: dev.reviewCount,
                            profileImageUrl: dev.profileImageUrl,
                            languages: dev.languages,
                            experience: dev.experience,
                          ),
                        );
                      },
                    ),

                    SizedBox(
                      height: sh * 0.01,
                    ),

                    // label1(sh, "Recent Consultations", Colors.grey.shade900,
                    //     sh * 0.025),

                    // SizedBox(
                    //   height: sh * 0.025,
                    // ),

                    // HomeRecentConsultCard(
                    //   sh: sh,
                    //   sw: sw,
                    //   name: "Emily Carter",
                    //   subtitle: "Digital Marketing Expert",
                    //   rate: 120.0,
                    //   profileImageUrl:
                    //       "https://randomuser.me/api/portraits/women/32.jpg",
                    // ),
                    // HomeRecentConsultCard(
                    //   sh: sh,
                    //   sw: sw,
                    //   name: "Daniel Smith",
                    //   subtitle: "Business Consultant at Deloitte",
                    //   rate: 250.0,
                    //   profileImageUrl:
                    //       "https://randomuser.me/api/portraits/men/52.jpg",
                    // ),

                    SizedBox(
                      height: sh * 0.015,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
