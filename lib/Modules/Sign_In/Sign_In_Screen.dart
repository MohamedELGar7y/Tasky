import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tasky/Modules/SignUp/SignUpScreen.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../Home/Home.dart';
import '../../Components/Components.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  String? countryCode;
  String? isoCode = 'EG';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is SignInSuccessState) {
          if (AppCubit.get(context).signInStatusCode == 201) {
            await CacheHelper.saveData(
                key: "token", value: state.signInModel.accessToken);
            await CacheHelper.saveData(
                    key: "refreshToken", value: state.signInModel.refreshToken)
                .then((value) {
              AppCubit.get(context).getProfile();
              AppCubit.get(context).getHome();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false);
              Fluttertoast.showToast(
                  msg: "تم تسجيل الدخول",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
          } else {
            Fluttertoast.showToast(
                msg: "يوجد خطأ في رقم الهاتف أو كلمة المرور",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/board.png',
                      height: MediaQuery.sizeOf(context).height / 1.9,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#24252C")),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: InternationalPhoneNumberInput(
                                textFieldController: phoneController,
                                initialValue: PhoneNumber(
                                  isoCode: isoCode,
                                  dialCode: countryCode,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please complete the form';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  phoneController.text = value.parseNumber();
                                  countryCode = value.dialCode;
                                  isoCode = value.isoCode;
                                  //print(phoneNumberController.text);
                                  //print(countryCode);
                                },
                                onInputChanged: (value) {
                                  //phoneNumber = value.parseNumber();
                                  phoneController.text = value.parseNumber();
                                  countryCode = value.dialCode;
                                  isoCode = value.isoCode;
                                },
                                formatInput: false,
                                countries: const ['EG', 'SA'],
                                selectorConfig: const SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DIALOG,
                                  leadingPadding: 16,
                                  trailingSpace: false,
                                  setSelectorButtonAsPrefixIcon: true,
                                ),
                                searchBoxDecoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#BABABA"),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: HexColor("#5F33E1"),
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: HexColor("#BABABA"),
                                      )),
                                ),
                                inputDecoration: InputDecoration(
                                  hintText: '123 456-7890',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#BABABA"),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: HexColor("#5F33E1"),
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: HexColor("#BABABA"),
                                      )),
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  signed: true,
                                  decimal: true,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormFailed(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            hint: 'Password...',
                            hintColor: "#7F7F7F",
                            isPassword: AppCubit.get(context).isPasswordSignIn,
                            suffix: IconButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .signInPasswordVisibility();
                              },
                              icon: Icon(
                                AppCubit.get(context).signInSuffix,
                                color: HexColor("#BEBEBE"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                            condition: state is! SignInLoadingState,
                            builder: (context) {
                              return defaultButton(
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    AppCubit.get(context).signIn(
                                      password: passwordController.text,
                                      phone:
                                          countryCode! + phoneController.text,
                                    );
                                  }
                                },
                                text: 'Sign In',
                                background: HexColor('#5F33E1'),
                              );
                            },
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(
                                color: HexColor('#5F33E1'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Didn’t have any account?',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor("#BEBEBE")),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                child: Text(
                                  'Sign Up here',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#5F33E1")),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
