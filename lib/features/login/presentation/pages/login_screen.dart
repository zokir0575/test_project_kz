import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:test_task_kz/core/utils/my_functions.dart';
import 'package:test_task_kz/core/utils/shared_preferences.dart';
import 'package:test_task_kz/features/common/bloc/authentication_bloc.dart';
import 'package:test_task_kz/features/common/widgets/w_scale_animation.dart';
import 'package:test_task_kz/features/login/data/model/login_model.dart';
import 'package:test_task_kz/features/login/presentation/blocs/login_bloc.dart';
import 'package:test_task_kz/features/navigation/presentation/home.dart';
import 'package:test_task_kz/features/navigation/presentation/navigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return KeyboardDismisser(
          child: Scaffold(
            backgroundColor: const Color(0xffF3F4F6),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0xffFEFEFE),
              title: const Text(
                'Авторизация',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  color: Colors.white,
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            hintText: 'Логин или почта',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xffC3C3C3),
                            ),
                            border: InputBorder.none),
                      ),
                      const Divider(
                        color: Color(0xffE0E6ED),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: passwordController,
                        decoration: const InputDecoration(
                            hintText: 'Пароль',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xffC3C3C3),
                            ),
                            border: InputBorder.none),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                WScaleAnimation(
                  isDisabled: emailController.text.isEmpty ||
                      passwordController.text.isEmpty,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: emailController.text.isEmpty ||
                              passwordController.text.isEmpty
                          ? Colors.grey
                          : const Color(0xff4631D2),
                    ),
                    child: const Center(
                      child: Text(
                        'Войти',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<LoginBloc>().add(LoginEvent.login(
                      onSuccess: (){
                         StorageRepository.putString('user_password', passwordController.text);
                         context
                             .read<AuthenticationBloc>()
                             .add(AuthenticationStatusChanged(status: AuthStatus.authenticated));
                        Navigator.pushAndRemoveUntil(context, fade(const NavHomeScreen()), (route) => false);
                      },
                        onError: (e){
                        print(e + "error");
                        },
                        userModel: LoginModel(
                            email: emailController.text,
                            password: passwordController.text)));
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
