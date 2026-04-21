import 'package:enr_tickets/core/utils/app_strings.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomAppBarSearchResults extends StatelessWidget {
  final String arriveStation;
  final String dateday;

  const CustomAppBarSearchResults({
    super.key,
    required this.arriveStation,
    required this.dateday,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 32,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        Gap(MediaQuery.sizeOf(context).width * 0.16),
        Column(
          children: [
            Gap(20),
            Text(
              AppStrings.of(context, "SearchResultsTitle"),
              style: Styles.textStyle27.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            Subtitlewidget(staion: arriveStation, dateday: dateday),
          ],
        ),
      ],
    );
  }
}

class Subtitlewidget extends StatelessWidget {
  final String staion;
  final String dateday;
  const Subtitlewidget({
    super.key,
    required this.staion,
    required this.dateday,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "To $staion",
          style: Styles.hintStyle.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        Gap(10),
        Icon(Icons.arrow_forward, size: 20),
        Gap(10),
        Text(
          dateday,
          style: Styles.hintStyle.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ],
    );
  }
}
