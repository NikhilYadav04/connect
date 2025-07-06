import 'package:connect/core/constants/colors.dart';
import 'package:connect/core/constants/fontfamily.dart';
import 'package:connect/model/experts/category_card.dart';
import 'package:connect/view/experts/widgets/category_card.dart';
import 'package:flutter/material.dart';

class ExpertsCategoryScreen extends StatefulWidget {
  const ExpertsCategoryScreen({super.key});

  @override
  State<ExpertsCategoryScreen> createState() => _ExpertsCategoryScreenState();
}

class _ExpertsCategoryScreenState extends State<ExpertsCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: sh * 0.074,
                backgroundColor: AppColors.colorPurple,
                //floating: true,
                //snap: true,
                centerTitle: true,
                title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Categories",
                    style: textStyle2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: sh * 0.032,
                    ),
                  ),
                ),
              )
            ];
          },
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.025),
              child: GridView.builder(
                padding:
                    EdgeInsets.symmetric(horizontal: sw*0.01, vertical: sh*0.025),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 3.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return CategoryCard(
                    width: sw,
                    height: sh,
                    category: cat,
                    onTap: () {
                      // handle tap
                      debugPrint('Tapped ${cat.title}');
                    }, index: index,
                  );
                },
              ),
            ),),
    ));
  }
}
