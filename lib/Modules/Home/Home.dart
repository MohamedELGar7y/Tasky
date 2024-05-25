import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/Modules/Add%20new%20task/Add%20new%20task.dart';
import 'package:tasky/Modules/Profile/Profile.dart';
import 'package:tasky/Modules/Sign_In/Sign_In_Screen.dart';
import 'package:tasky/Modules/qr_screen/qr_screen.dart';
import 'package:tasky/cubit/cubit.dart';
import 'package:tasky/cubit/states.dart';
import '../../shared/network/local/cache_helper.dart';
import '../Task Details/Task Details.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is RefreshTokenSuccessState) {
          await CacheHelper.saveData(
                  key: "token", value: state.refreshTokenModel.accessToken)
              .then((value) {
            AppCubit.get(context).getProfile();
            AppCubit.get(context).getHome();
          });
        }

        if (state is GetTodoSuccessState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TaskDetails()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Logo",
              style: TextStyle(
                  fontSize: 24,
                  color: HexColor("#24252C"),
                  fontWeight: FontWeight.w700),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                child: Image.asset(
                  "assets/images/profile.png",
                  color: HexColor("#000000"),
                  height: 30,
                  width: 30,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () async {
                  await CacheHelper.removeData(key: "token").then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                  });
                },
                child: Image.asset(
                  "assets/images/log out.png",
                  color: HexColor("#5F33E1"),
                  height: 30,
                  width: 30,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Tasks",
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor("#24252C").withOpacity(0.6),
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AppCubit.get(context).changeIndex(
                          index: 0,
                          status: "all",
                        );
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: AppCubit.get(context).indexx == 0
                                ? HexColor("#5F33E1")
                                : HexColor("#F0ECFF"),
                            borderRadius: BorderRadius.circular(24)),
                        child: Center(
                          child: Text(
                            "All",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppCubit.get(context).indexx == 0
                                  ? HexColor("#FFFFFF")
                                  : HexColor("#7C7C80"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        AppCubit.get(context).changeIndex(
                          index: 1,
                          status: "inProgress",
                        );
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: AppCubit.get(context).indexx == 1
                                ? HexColor("#5F33E1")
                                : HexColor("#F0ECFF"),
                            borderRadius: BorderRadius.circular(24)),
                        child: Center(
                          child: Text(
                            "Inpogress",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppCubit.get(context).indexx == 1
                                  ? HexColor("#FFFFFF")
                                  : HexColor("#7C7C80"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        AppCubit.get(context).changeIndex(
                          index: 2,
                          status: "waiting",
                        );
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: AppCubit.get(context).indexx == 2
                                ? HexColor("#5F33E1")
                                : HexColor("#F0ECFF"),
                            borderRadius: BorderRadius.circular(24)),
                        child: Center(
                          child: Text(
                            "Waiting",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppCubit.get(context).indexx == 2
                                  ? HexColor("#FFFFFF")
                                  : HexColor("#7C7C80"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        AppCubit.get(context).changeIndex(
                          index: 3,
                          status: "finished",
                        );
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: AppCubit.get(context).indexx == 3
                                ? HexColor("#5F33E1")
                                : HexColor("#F0ECFF"),
                            borderRadius: BorderRadius.circular(24)),
                        child: Center(
                          child: Text(
                            "Finished",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppCubit.get(context).indexx == 3
                                  ? HexColor("#FFFFFF")
                                  : HexColor("#7C7C80"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ConditionalBuilder(
                  condition: AppCubit.get(context).homeData != null,
                  builder: (context) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var dateTimeString = AppCubit.get(context)
                              .homeData[index]["createdAt"];
                          DateTime parseDate =
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                  .parse(dateTimeString);
                          var inputDate = DateTime.parse(parseDate.toString());
                          var outputFormat = DateFormat('MM/dd/yyyy');
                          var outputDate = outputFormat.format(inputDate);
                          if (AppCubit.get(context).statuss == "all") {
                            return InkWell(
                              onTap: () {
                                AppCubit.get(context).getOne(
                                  id: AppCubit.get(context).homeData[index]
                                      ["_id"],
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/image.png"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                AppCubit.get(context)
                                                    .homeData[index]["title"],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: HexColor("#24252C"),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            if (AppCubit.get(context)
                                                        .homeData[index]
                                                    ["status"] !=
                                                null)
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: HexColor("#FFE4F2"),
                                                ),
                                                child: Text(
                                                  AppCubit.get(context)
                                                          .homeData[index]
                                                      ["status"],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: HexColor("#FF7D53"),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                        Text(
                                          AppCubit.get(context).homeData[index]
                                              ["desc"],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor("#24252C")
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/Frame.png"),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              AppCubit.get(context)
                                                  .homeData[index]["priority"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: HexColor("#5F33E1"),
                                              ),
                                            ),
                                            const Spacer(),
                                            Expanded(
                                              child: Text(
                                                outputDate.toString(),
                                                style: TextStyle(
                                                  color: HexColor("#24252C")
                                                      .withOpacity(0.6),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Image.asset("assets/images/Frame(1).png")
                                ],
                              ),
                            );
                          } else {
                            return AppCubit.get(context).homeData[index]
                                        ["status"] ==
                                    AppCubit.get(context).statuss
                                ? InkWell(
                                    onTap: () {
                                      AppCubit.get(context).getOne(
                                        id: AppCubit.get(context)
                                            .homeData[index]["_id"],
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset("assets/images/image.png"),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      AppCubit.get(context)
                                                              .homeData[index]
                                                          ["title"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            HexColor("#24252C"),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          HexColor("#FFE4F2"),
                                                    ),
                                                    child: Text(
                                                      AppCubit.get(context)
                                                              .homeData[index]
                                                          ["status"],
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            HexColor("#FF7D53"),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                AppCubit.get(context)
                                                    .homeData[index]["desc"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: HexColor("#24252C")
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/images/Frame.png"),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    AppCubit.get(context)
                                                            .homeData[index]
                                                        ["priority"],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          HexColor("#5F33E1"),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Expanded(
                                                    child: Text(
                                                      outputDate.toString(),
                                                      style: TextStyle(
                                                        color: HexColor(
                                                                "#24252C")
                                                            .withOpacity(0.6),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Image.asset(
                                            "assets/images/Frame(1).png")
                                      ],
                                    ),
                                  )
                                : const SizedBox();
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount:
                            AppCubit.get(context).homeData!.length.toInt(),
                      ),
                    );
                  },
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: "btn1",
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                backgroundColor: HexColor("#EBE5FF"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QrScreen()));
                },
                child: Image.asset(
                  "assets/images/qr.png",
                  color: HexColor("#5F33E1"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                heroTag: "btn2",
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                backgroundColor: HexColor("#5F33E1"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddNewTask()));
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
