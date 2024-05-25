import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tasky/Modules/Home/Home.dart';
import '../../Components/Components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../Sign_In/Sign_In_Screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  final experienceController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final levelController = TextEditingController();
  final resetKey = GlobalKey<FormFieldState>();
  String? countryCode;
  String? isoCode = 'EG';
  String? level;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is SignUpSuccessState) {
          if (AppCubit.get(context).signUpStatusCode == 201) {
            await CacheHelper.saveData(
                key: "token", value: state.signUpModel.accessToken);
            await CacheHelper.saveData(
                    key: "refreshToken", value: state.signUpModel.refreshToken)
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
                msg: "رقم الهاتف مستخدم بالفعل",
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
          backgroundColor: HexColor("#F9F9F9"),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/board.png',
                      height: MediaQuery.sizeOf(context).height / 2.9,
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
                            height: 10,
                          ),
                          defaultFormFailed(
                            controller: nameController,
                            type: TextInputType.text,
                            hint: 'Name...',
                            hintColor: "#7F7F7F",
                          ),
                          const SizedBox(
                            height: 10,
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
                            controller: experienceController,
                            type: TextInputType.number,
                            hint: 'Years of experience...',
                            hintColor: "#7F7F7F",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2<String>(
                                isExpanded: true,
                                hint: const Text(
                                  "Choose experience Level",
                                  style: TextStyle(fontSize: 14),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please complete the form';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                  ),
                                  hintStyle: const TextStyle(fontSize: 14),
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
                                items: items.map((item) {
                                  return DropdownMenuItem(
                                    value: item.toString(),
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: HexColor('#313131')),
                                    ),
                                  );
                                }).toList(),
                                value: level,
                                onChanged: (String? newVal) {
                                  setState(() {
                                    level = newVal;
                                    resetKey.currentState?.reset();
                                    /*cubit.getRegionByCity(
                                      cityId: city.toString());*/
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: levelController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 48,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: levelController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        hintText: 'Search for an item...',
                                        hintStyle:
                                            const TextStyle(fontSize: 14),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            borderSide: BorderSide(
                                              color: HexColor("#5F33E1"),
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            borderSide: BorderSide(
                                              color: HexColor("#BABABA"),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    levelController.clear();
                                  }
                                },
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: HexColor("#7F7F7F"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormFailed(
                            controller: addressController,
                            type: TextInputType.text,
                            hint: 'Address...',
                            hintColor: "#7F7F7F",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormFailed(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            hint: 'Password...',
                            hintColor: "#7F7F7F",
                            isPassword: AppCubit.get(context).isPasswordSignUp,
                            suffix: IconButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .signUpPasswordVisibility();
                              },
                              icon: Icon(
                                AppCubit.get(context).signUpSuffix,
                                color: HexColor("#BEBEBE"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! SignUpLoadingState,
                            builder: (context) {
                              return defaultButton(
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    AppCubit.get(context).signUp(
                                      password: passwordController.text,
                                      phone:
                                          countryCode! + phoneController.text,
                                      displayName: nameController.text,
                                      experienceYears:
                                          experienceController.text,
                                      address: addressController.text,
                                      level: level.toString(),
                                    );
                                  }
                                },
                                text: 'Sign up',
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
                                'Already have any account?',
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
                                              const SignInScreen()));
                                },
                                child: Text(
                                  'Sign in',
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

  final List<String> items = [
    'fresh',
    'junior',
    'midLevel',
    'senior',
  ];
}
