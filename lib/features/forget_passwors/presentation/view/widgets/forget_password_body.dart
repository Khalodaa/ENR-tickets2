// ignore_for_file: must_be_immutable

import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/core/widget/custom_button_register.dart';
import 'package:enr_tickets/core/widget/custom_form_feild.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/forget_passwors/presentation/state_mangement/cubit/reset_password_cubit.dart';
import 'package:enr_tickets/features/forget_passwors/presentation/view/widgets/verification_code_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});
  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  TextEditingController emailController = TextEditingController();
  @override
  dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AssetsData.iconlogo),
            Text("Please Enter You`r Email", style: Styles.textStyle20),
            Gap(20),
            CustomFormFeild(
              hint: "email",
              icon: Icons.email,
              controller: emailController,
            ),
            Gap(20),

            BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
              builder: (context, state) {
                if (state is ResetPasswordLoding) {
                  return const CircularProgressIndicator();
                } else if (state is ResetPasswordFailure) {
                  return Text(state.errorMessage, style: Styles.textStyle20);
                } else if (state is ResetPasswordSuccess) {
                  {
                    return Column(
                      children: [
                        Text(
                          "Code sent successfully!",
                          style: Styles.textStyle20,
                        ),
                        VerifyButton(
                          title: "Next",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VerificationCodeBody(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                }
                return VerifyButton(
                  title: "Send Code",
                  onTap: () {
                    context.read<ResetPasswordCubit>().sendResetCode(
                      emailController.text,
                    );
                  },
                );
              },
            ),
            Gap(40),
            Text(
              "Will Send You A Code To Reset Your Password",
              style: Styles.hintStyle,
            ),
          ],
        ),
      ),
    );
  }
}
