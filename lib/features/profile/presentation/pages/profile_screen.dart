import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task_kz/assets/constants/app_icons.dart';
import 'package:test_task_kz/core/utils/my_functions.dart';
import 'package:test_task_kz/core/utils/shared_preferences.dart';
import 'package:test_task_kz/features/common/bloc/authentication_bloc.dart';
import 'package:test_task_kz/features/common/widgets/w_scale_animation.dart';
import 'package:test_task_kz/features/login/presentation/pages/login_screen.dart';
import 'package:test_task_kz/features/navigation/presentation/navigator.dart';
import 'package:test_task_kz/features/profile/presentation/blocs/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc profileBloc;

  @override
  void initState() {
    profileBloc = ProfileBloc()..add(ProfileEvent.getProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileBloc,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xffF3F4F6),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0xffFEFEFE),
              title: const Text(
                'Профиль',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(
                    AppIcons.profile,
                    color: Colors.black,
                    height: 64,
                    width: 64,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    state.profile.nickname,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.profile.email,
                    style: const TextStyle(
                        color: Color(0xff929292),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Spacer(),
                  WScaleAnimation(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: EdgeInsets.fromLTRB(20, 0, 20,
                          MediaQuery.of(context).padding.bottom + 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Выйти',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: () {
                      context.read<AuthenticationBloc>().add(
                        AuthenticationStatusChanged(
                            status: AuthStatus.unAuthenticated),
                      );
                      StorageRepository.deleteString('token');
                      Navigator.pushAndRemoveUntil(
                          context, fade(const LoginScreen()), (route) => false);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
