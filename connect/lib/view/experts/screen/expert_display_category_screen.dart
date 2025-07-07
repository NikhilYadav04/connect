import 'dart:async';

import 'package:connect/core/router/appRouter.dart';
import 'package:connect/model/experts/expert_detail_card_model.dart';
import 'package:connect/model/home/home_expert_model.dart';
import 'package:connect/view/experts/widgets/expert_List_search_field.dart';
import 'package:connect/view/home/widgets/home_expert_card.dart';
import 'package:flutter/material.dart';

import 'package:connect/core/constants/colors.dart';
import 'package:connect/core/constants/fontfamily.dart';

class ExpertDisplayCategoryScreen extends StatefulWidget {
  final String category;
  const ExpertDisplayCategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ExpertDisplayCategoryScreen> createState() =>
      _ExpertDisplayCategoryScreenState();
}

class _ExpertDisplayCategoryScreenState
    extends State<ExpertDisplayCategoryScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Developer> _filteredDevelopers = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _filteredDevelopers = List.from(developers);
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _applyFilter();
    });
  }

  void _applyFilter() {
    final query = _controller.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredDevelopers = List.from(developers);
      } else {
        _filteredDevelopers = developers.where((dev) {
          final nameMatch = dev.name.toLowerCase().contains(query);
          final subtitleMatch = dev.subtitle.toLowerCase().contains(query);
          final expertiseMatch = dev.expertise.any(
            (skill) => skill.toLowerCase().contains(query),
          );
          return nameMatch || subtitleMatch || expertiseMatch;
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_applyFilter);
    _controller.dispose();
    super.dispose();
  }

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
      reviews: reviews,
    );
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

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: sh * 0.074,
                backgroundColor: AppColors.colorPurple,
                flexibleSpace: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sh * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: sh * 0.03,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Text(
                                widget.category,
                                style: textStyle2.copyWith(
                                  wordSpacing: 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: sh * 0.027,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
              child: Column(
                children: [
                  SizedBox(height: 18),

                  //* Search Field
                  ExpertListSearchField(
                    label: "Search experts, skills...",
                    controller: _controller,
                    verticalPadding: sh * 0.018,
                    horizontalPadding: sw * 0.035,
                  ),
                  SizedBox(height: 25),

                  //* Cards List
                  _filteredDevelopers.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: sh * 0.1),
                          child: Center(
                            child: Text(
                              "No experts found.",
                              style: textStyle2.copyWith(
                                fontSize: sh * 0.022,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _filteredDevelopers.length,
                          itemBuilder: (context, index) {
                            final dev = _filteredDevelopers[index];
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
                                expertise: dev.expertise,
                                profileImageUrl: dev.profileImageUrl,
                                languages: dev.languages,
                                experience: dev.experience,
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
