// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enr_tickets/core/utils/app_strings.dart';
import 'package:enr_tickets/core/utils/local_storage.dart';
import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/core/widget/custom_dialog.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/settings/presentation/state_mangement/settings_cubit/settings_cubit.dart';
import 'package:enr_tickets/features/settings/presentation/view/widgets/settings_card_widget.dart';
import 'package:enr_tickets/features/settings/presentation/view/widgets/text_button_widget.dart';
import 'package:enr_tickets/features/log_in/presentation/view/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SettingsPageBody extends StatelessWidget {
  const SettingsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? AssetsData.logo
                  : AssetsData.iconlogo,
            ),
          ),
        ),
        Text(AppStrings.of(context, "settings"), style: Styles.textStyle27),
        SettingsCardWidget(
          title: AppStrings.of(context, "darkMode"),
          task: context.watch<SettingsCubit>().themeText,
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text("Follow System"),
                      onTap: () {
                        context.read<SettingsCubit>().changeTheme(
                          ThemeMode.system,
                        );
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text("Light Mode"),
                      onTap: () {
                        context.read<SettingsCubit>().changeTheme(
                          ThemeMode.light,
                        );
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text("Dark Mode"),
                      onTap: () {
                        context.read<SettingsCubit>().changeTheme(
                          ThemeMode.dark,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        SettingsCardWidget(
          title: "Language",
          task: context.watch<SettingsCubit>().locale.languageCode == "en"
              ? "English"
              : "العربية",
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text("English"),
                      onTap: () {
                        context.read<SettingsCubit>().changeLanguage("en");
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text("العربية"),
                      onTap: () {
                        context.read<SettingsCubit>().changeLanguage("ar");
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        Gap(30),

        TextButtonWidget(
          onPressed: () => log("Change password"),
          task: AppStrings.of(context, "changePassword"),
          icon: Icons.lock_outline_rounded,
        ),

        TextButtonWidget(
          onPressed: () => log("Delete Account"),
          task: AppStrings.of(context, "deleteAccount"),

          icon: Icons.delete_outline_rounded,
        ),
        // logout
        TextButtonWidget(
          onPressed: () {
            CustomDialog.show(
              context: context,
              title: "Logout",
              description: "Are you sure you want to logout?",
              dialogType: DialogType.noHeader,

              btnOkOnPress: () async {
                await LocalStorage.logout();

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LogIn()),
                  (route) => false,
                );
              },
            );
          },

          task: AppStrings.of(context, "signup"),
          icon: Icons.login_rounded,
        ),
      ],
    );
  }
}
