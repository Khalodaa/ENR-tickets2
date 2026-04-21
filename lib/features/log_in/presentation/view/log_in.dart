import 'package:enr_tickets/features/log_in/data/repo/login_repo.dart';
import 'package:enr_tickets/features/log_in/presentation/state_mangement/log_in_cubit.dart';
import 'package:enr_tickets/features/log_in/presentation/view/widgets/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(context.read<LogInRepo>()),
      child: Scaffold(body: BackgroundImage()),
    );
  }
}
