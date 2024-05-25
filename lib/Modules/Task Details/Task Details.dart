import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/Modules/Home/Home.dart';
import 'package:tasky/cubit/cubit.dart';
import 'package:tasky/cubit/states.dart';

class TaskDetails extends StatefulWidget {
  TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  var startDate = TextEditingController();
  final resetKey = GlobalKey<FormFieldState>();
  String? text22;
  String? text11;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is DeleteTodoSuccessState) {
          AppCubit.get(context).getHome();
          Navigator.pop(context);
        }
        if (state is UpdateTodoSuccessState) {
          AppCubit.get(context).getHome();
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, AppStates state) {
        var dateTimeString = AppCubit.get(context).getOneModel!.createdAt;
        DateTime parseDate =
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateTimeString!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('MM/dd/yyyy');
        var outputDate = outputFormat.format(inputDate);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Task Details",
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
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false);
              },
              child: Image.asset(
                "assets/images/Arrow -back.png",
              ),
            ),
            actions: [
              PopupMenuButton(
                onSelected: (value) {
                  if (value == '/delete') {
                    AppCubit.get(context).deleteOne(
                      id: AppCubit.get(context).getOneModel!.sId!,
                    );
                  } else if (value == '/edit') {
                    if (_formKey.currentState!.validate()) {
                      AppCubit.get(context).updateTodo(
                        id: AppCubit.get(context).getOneModel!.sId!,
                        status: text11,
                      );
                    }
                  }
                },
                surfaceTintColor: Colors.white,
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      value: '/edit',
                      height: 15,
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: HexColor("#00060D"),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      height: 15,
                      child: Divider(
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    PopupMenuItem(
                      value: '/delete',
                      height: 15,
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: HexColor("#FF7D53"),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ];
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                position: PopupMenuPosition.under,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/image 1.png",
                    ),
                    Text(
                      AppCubit.get(context).getOneModel!.title!,
                      style: TextStyle(
                        color: HexColor("#24252C"),
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      AppCubit.get(context).getOneModel!.desc!,
                      style: TextStyle(
                        fontSize: 14,
                        color: HexColor("#24252C").withOpacity(0.6),
                        height: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: HexColor("#F0ECFF"),
                      ),
                      child: TextFormField(
                        controller: startDate,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: outputDate,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: HexColor("#24252C"),
                            ),
                            suffixIcon: Image.asset(
                              "assets/images/calendar.png",
                              color: HexColor("#5F33E1"),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (AppCubit.get(context).getOneModel!.status != null)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: HexColor("#F0ECFF"),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please complete the form';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            icon: Image.asset(
                              "assets/images/Arrow - Down 4.png",
                              color: HexColor("#5F33E1"),
                            ),
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            hint: Text(
                              AppCubit.get(context).getOneModel!.status!,
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor("#5F33E1"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            items: items1.map((item) {
                              return DropdownMenuItem(
                                value: item.toString(),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: HexColor('#5F33E1'),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                            value: text11,
                            onChanged: (String? newVal) {
                              setState(() {
                                text11 = newVal;
                                resetKey.currentState?.reset();
                              });
                            },
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: HexColor("#F0ECFF"),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          icon: Image.asset(
                            "assets/images/Arrow - Down 4.png",
                            color: HexColor("#5F33E1"),
                          ),
                          padding: const EdgeInsets.all(10),
                          hint: Row(
                            children: [
                              Image.asset(
                                "assets/images/Frame.png",
                                color: HexColor("#5F33E1"),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                AppCubit.get(context).getOneModel!.priority!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: HexColor("#5F33E1"),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          items: items2.map((item) {
                            return DropdownMenuItem(
                              value: item.toString(),
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: HexColor('#5F33E1'),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          value: text22,
                          onChanged: null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    QrImageView(
                      data: AppCubit.get(context).getOneModel!.sId!,
                      version: QrVersions.auto,
                      size: 320.0,
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

  final List<String> items1 = [
    'waiting',
    'inProgress',
    'finished',
  ];
  final List<String> items2 = [
    'low',
    'medium',
    'high',
  ];
}
