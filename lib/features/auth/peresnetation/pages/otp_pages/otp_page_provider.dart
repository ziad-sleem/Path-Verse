import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_using_firebase/config/DI/injection.dart';
import 'package:social_media_app_using_firebase/features/auth/peresnetation/cubits/otp_cubit/cubit/otp_cubit.dart';
import 'package:social_media_app_using_firebase/features/auth/peresnetation/pages/otp_pages/otp_page.dart';


class OtpScreenProvider extends StatelessWidget {
  final String phoneNumber;
  const OtpScreenProvider({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OtpCubit>(),
      child: OtpPage(phoneNumber: phoneNumber),
    );
  }
}
