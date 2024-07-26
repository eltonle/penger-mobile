import 'package:flutter/material.dart';
import 'package:flutter_app/resources/app_colors.dart';
import 'package:flutter_app/resources/app_routes.dart';
import 'package:flutter_app/resources/app_spacing.dart';
import 'package:flutter_app/resources/app_strings.dart';
import 'package:flutter_app/resources/app_styles.dart';
import 'package:flutter_app/views/components/ui/button.dart';

import '../../models/slide_model.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  PageController pageController = PageController();

  List<SlideModel> slides = [
    SlideModel(AppStrings.walkthroughTitle1, AppStrings.walkthroughDescription1,
        'assets/images/walkthrough1.png'),
    SlideModel(AppStrings.walkthroughTitle2, AppStrings.walkthroughDescription2,
        'assets/images/walkthrough2.png'),
    SlideModel(AppStrings.walkthroughTitle3, AppStrings.walkthroughDescription3,
        'assets/images/walkthrough3.png'),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: pages(),
            ),
            AppSpacing.vertical(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  indicator(),
                  AppSpacing.vertical(),
                  button(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget indicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < slides.length; i++) ...[
          InkWell(
            onTap: () => {
              if (i != currentPage)
                {
                  pageController.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  )
                }
            },
            child: Icon(
              Icons.circle,
              size: currentPage == i ? 16 : 8,
              color: currentPage == i
                  ? AppColors.primaryColor
                  : AppColors.primaryColorLight,
            ),
          ),
          if (i < slides.length - 1) AppSpacing.horizontal(size: 10),
        ]
      ],
    );
  }

  Widget button() {
    return Column(
      children: [
        ButtonComponent(
          label: AppStrings.signUp,
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.signup),
        ),
        const SizedBox(height: 16),
        ButtonComponent(
          label: AppStrings.login,
          type: ButtonType.secondary,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget pages() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: [
            AppSpacing.vertical(size: 40),
            Center(
              child: Image.asset(
                slides[index].image,
                width: MediaQuery.of(context).size.width / 1.5,
              ),
            ),
            AppSpacing.vertical(size: 24),
            Text(
              slides[index].title,
              style: AppStyles.title1(),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vertical(size: 24),
            Text(
              slides[index].description,
              style: AppStyles.regular1(
                  color: AppColors.light20, weight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
      controller: pageController,
      itemCount: slides.length,
      onPageChanged: (index) => setState(() {
        currentPage = index;
      }),
    );
  }
}
