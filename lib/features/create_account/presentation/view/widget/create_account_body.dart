import 'package:enr_tickets/core/utils/app_strings.dart';
import 'package:enr_tickets/core/widget/custom_button_register.dart';
import 'package:enr_tickets/core/widget/custom_logo.dart';
import 'package:enr_tickets/core/widget/sign_in_via.dart';
import 'package:enr_tickets/features/create_account/presentation/state_mangement/creat_user_cubit.dart';
import 'package:enr_tickets/features/create_account/presentation/view/widget/custom_have_account_text_button.dart';
import 'package:enr_tickets/features/create_account/presentation/view/widget/form_feild_view_sign_in.dart';
import 'package:enr_tickets/features/create_account/presentation/view/widget/sign_in_methods_view.dart';
import 'package:enr_tickets/features/log_in/presentation/view/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CreateAccountBody extends StatefulWidget {
  const CreateAccountBody({super.key});

  @override
  State<CreateAccountBody> createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatUserCubit, CreatUserState>(
      listener: (context, state) {
        if (state is CreatUserSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => LogIn()),
            (route) => false,
          );
        } else if (state is CreatUserFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<CreatUserCubit>();

        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(13),
                CustomLogo(),
                Text(
                  AppStrings.of(context, "createNewAccount"),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                FormFeildViewSignIn(
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                ),
                Gap(10),
                state is CreatUserLoading
                    ? CircularProgressIndicator()
                    : VerifyButton(
                        title: AppStrings.of(context, "createNewAccount"),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.createUser(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                Gap(15),
                SignInVia(),
                Gap(15),
                SignInMethodsView(),
                Gap(15),
                CustomHaveAccountTextButton(
                  title: AppStrings.of(context, "alreadyAccount"),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => LogIn()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
