import 'dart:async';

import 'package:connect/core/constants/colors.dart';
import 'package:connect/view/experts/widgets/expert_widget.dart';
import 'package:flutter/material.dart';
import 'package:connect/core/constants/fontfamily.dart';
import 'package:connect/core/router/appRouter.dart';
import 'package:connect/model/experts/expert_detail_card_model.dart';
import 'package:connect/model/home/home_expert_model.dart';
import 'package:connect/view/experts/widgets/expert_List_search_field.dart';
import 'package:connect/view/experts/widgets/filter_card.dart';
import 'package:connect/view/home/widgets/home_expert_card.dart';

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

  //* FILTER STATE
  final List<String> _priceRanges = [
    'All Prices',
    '\$0 - \$10',
    '\$11 - \$30',
    '\$31 - \$50',
    '\$50 - \$100',
    '\$101+',
  ];
  final List<String> _minRatings = [
    'All Ratings',
    '★ 1+',
    '★ 2+',
    '★ 3+',
    '★ 4+',
    '★ 5',
  ];
  final List<String> _sortOptions = [
    'Highest',
    'Lowest',
    'Most',
  ];

  String _selectedPrice = 'All Prices';
  String _selectedRating = 'All Ratings';
  String _selectedSort = 'Highest';

  @override
  void initState() {
    super.initState();
    _filteredDevelopers = List.from(developers);
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _filterAndSort);
  }

  void _filterAndSort() {
    final query = _controller.text.toLowerCase();

    //* 1) FILTER
    List<Developer> temp = developers.where((dev) {
      //*–– TEXT MATCH
      final textMatch = dev.name.toLowerCase().contains(query) ||
          dev.subtitle.toLowerCase().contains(query) ||
          dev.expertise.any((s) => s.toLowerCase().contains(query));

      //*–– PRICE MATCH
      bool priceMatch;
      switch (_selectedPrice) {
        case '\$0 - \$10':
          priceMatch = dev.rate >= 0 && dev.rate <= 10;
          break;
        case '\$11 - \$30':
          priceMatch = dev.rate > 11 && dev.rate <= 30;
          break;
        case '\$31 - \$50':
          priceMatch = dev.rate > 31 && dev.rate <= 50;
          break;
        case '\$51 - \$100':
          priceMatch = dev.rate > 51 && dev.rate <= 100;
          break;
        case '\$101+':
          priceMatch = dev.rate > 101;
          break;
        default:
          priceMatch = true;
      }

      //*–– RATING MATCH
      bool ratingMatch;
      if (_selectedRating.startsWith('★')) {
        final minR =
            int.parse(_selectedRating.replaceAll(RegExp(r'[^0-9]'), ''));
        ratingMatch = dev.rating >= minR;
      } else {
        ratingMatch = true;
      }

      return textMatch && priceMatch && ratingMatch;
    }).toList();

    //* 2) SORT
    switch (_selectedSort) {
      case 'Highest':
        temp.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Lowest':
        temp.sort((a, b) => a.rate.compareTo(b.rate));
        break;
      case 'Most':
        temp.sort((a, b) => b.experience.compareTo(a.experience));
        break;
    }

    //* 3) APPLY
    setState(() {
      _filteredDevelopers = temp;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

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
        backgroundColor: AppColors.colorLightGrayBG,
        body: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: sh * 0.08,
              backgroundColor: AppColors.colorPurple,
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: sw * 0.04,right: sw*0.02),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: sh * 0.03,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(right: sw*0.1),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: WalletAmountBadge(sh: sh, sw: sw),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ExpertListSearchField(
                    label: "Search experts, skills...",
                    controller: _controller,
                    verticalPadding: sh * 0.018,
                    horizontalPadding: sw * 0.035,
                  ),
                  SizedBox(height: 18),
                  FilterBar(
                    w: sw,
                    h: sh,
                    priceRanges: _priceRanges,
                    selectedPrice: _selectedPrice,
                    onPriceChanged: (val) {
                      setState(() => _selectedPrice = val!);
                      _filterAndSort();
                    },
                    ratingOptions: _minRatings,
                    selectedRating: _selectedRating,
                    onRatingChanged: (val) {
                      setState(() => _selectedRating = val!);
                      _filterAndSort();
                    },
                    sortOptions: _sortOptions,
                    selectedSort: _selectedSort,
                    onSortChanged: (val) {
                      setState(() => _selectedSort = val!);
                      _filterAndSort();
                    },
                  ),
                  SizedBox(height: 15),
                  _filteredDevelopers.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: sh * 0.1),
                          child: Text(
                            "No experts found.",
                            style: textStyle2.copyWith(
                              fontSize: sh * 0.022,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _filteredDevelopers.length,
                          itemBuilder: (ctx, i) {
                            final dev = _filteredDevelopers[i];
                            return GestureDetector(
                              onTap: () => _handleNav(dev),
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
