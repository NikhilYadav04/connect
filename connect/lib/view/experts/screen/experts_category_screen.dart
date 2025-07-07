import 'package:connect/core/constants/colors.dart';
import 'package:connect/model/experts/category_card.dart';
import 'package:connect/view/experts/widgets/category_card.dart';
import 'package:connect/view/experts/widgets/expert_search_field.dart';
import 'package:flutter/material.dart';

class ExpertsCategoryScreen extends StatefulWidget {
  const ExpertsCategoryScreen({super.key});

  @override
  State<ExpertsCategoryScreen> createState() => _ExpertsCategoryScreenState();
}

class _ExpertsCategoryScreenState extends State<ExpertsCategoryScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Category> _filtered = [];

  @override
  void initState() {
    super.initState();
    //* initialize filtered list to all
    _filtered = List.from(categories);
    //* whenever text changes, rebuild with new filter
    _textEditingController.addListener(_applyFilter);
  }

  void _applyFilter() {
    final query = _textEditingController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filtered = List.from(categories);
      } else {
        _filtered = categories
            .where((c) => c.title.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _textEditingController
      ..removeListener(_applyFilter)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorLightGrayBG,
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.colorLightGrayBG,
              toolbarHeight: sh * 0.095,
              floating: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.03,
                    vertical: sh * 0.013,
                  ),
                  child: CategorySearchTextField(
                    onChanged: (value) => _applyFilter,
                    label: "Search Categories...",
                    controller: _textEditingController,
                    verticalPadding: sh * 0.018,
                    horizontalPadding: sw * 0.035,
                  ),
                ),
              ),
            )
          ],
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: sw * 0.025),
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: sw * 0.01,
                vertical: sh * 0.01,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
                mainAxisExtent: sh*0.23
              ),
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final cat = _filtered[index];
                return CategoryCard(
                  width: sw,
                  height: sh,
                  category: cat,
                  onTap: () => debugPrint('Tapped ${cat.title}'),
                  index: index,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
