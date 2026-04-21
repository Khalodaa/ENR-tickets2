import 'dart:developer';

import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/core/widget/custom_button_register.dart';

import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/forget_passwors/presentation/view/widgets/otp_input_widget.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class VerificationCodeBody extends StatelessWidget {
  const VerificationCodeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AssetsData.iconlogo),
            Text("Verification Code", style: Styles.textStyle27),
            Gap(20),
            Text(
              "Enter the 6-digit code sent to your email",
              style: Styles.hintStyle,
            ),
            Gap(30),
            OTPInputWidget(
              onCompleted: (code) {
                log("User entered code: $code");
              },
            ),
            Gap(36),
            VerifyButton(title: "Verify Code", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
