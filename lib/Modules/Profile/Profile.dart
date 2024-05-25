import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasky/cubit/cubit.dart';
import 'package:tasky/cubit/states.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var levelController = TextEditingController();
  var experienceController = TextEditingController();
  var locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = AppCubit.get(context).profileModel!.displayName!;
        phoneController.text =
            AppCubit.get(context).profileModel!.username.toString();
        levelController.text =
            AppCubit.get(context).profileModel!.level.toString();
        experienceController.text =
            AppCubit.get(context).profileModel!.experienceYears.toString();
        locationController.text =
            AppCubit.get(context).profileModel!.address.toString();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Profile",
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#24252C"),
                fontWeight: FontWeight.w700,
              ),
            ),
            leadingWidth: 50,
            titleSpacing: -5,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/images/Arrow -back.png",
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor("#F5F5F5"),
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: nameController.text,
                        label: Text("Name",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#2F2F2F").withOpacity(0.4),
                            )),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: HexColor("#2F2F2F").withOpacity(0.6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor("#F5F5F5"),
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: phoneController.text,
                        label: Text("Phone",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#2F2F2F").withOpacity(0.4),
                            )),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: HexColor("#2F2F2F").withOpacity(0.4),
                        ),
                        suffixIcon: InkWell(
                          onTap: () async {
                            await Clipboard.setData(
                              ClipboardData(text: phoneController.text),
                            ).then((value) {
                              Fluttertoast.showToast(
                                  msg: "Copied!'",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          },
                          child: Image.asset("assets/images/copy.png"),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor("#F5F5F5"),
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: levelController,
                      decoration: InputDecoration(
                        hintText: levelController.text,
                        label: Text("Level",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#2F2F2F").withOpacity(0.4),
                            )),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: HexColor("#2F2F2F").withOpacity(0.4),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor("#F5F5F5"),
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: experienceController,
                      decoration: InputDecoration(
                        hintText: experienceController.text,
                        label: Text("Years of experience",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#2F2F2F").withOpacity(0.4),
                            )),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: HexColor("#2F2F2F").withOpacity(0.4),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor("#F5F5F5"),
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: locationController.text,
                        label: Text("Location",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#2F2F2F").withOpacity(0.4),
                            )),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: HexColor("#2F2F2F").withOpacity(0.4),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
