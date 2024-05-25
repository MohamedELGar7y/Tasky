import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tasky/cubit/states.dart';
import 'dart:io';
import '../../Components/Components.dart';
import '../../cubit/cubit.dart';
import '../Home/Home.dart';

class AddNewTask extends StatefulWidget {
  AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  var startDate = TextEditingController();
  final resetKey = GlobalKey<FormFieldState>();
  String? text22;
  final _formKey = GlobalKey<FormState>();

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  Future<void> getImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is CreateTodoSuccessState) {
          AppCubit.get(context).getHome();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Add new task",
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
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        getImage().then((value) {
                          AppCubit.get(context).upload(
                            image: imageFile,
                          );
                        });
                      },
                      child: DottedBorder(
                        color: HexColor("#5F33E1"),
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: imageFile != null
                                      ? CircleAvatar(
                                          radius: 15,
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.white,
                                          backgroundImage: FileImage(
                                            File(imageFile!.path),
                                          ),
                                        )
                                      : const CircleAvatar(
                                          radius: 15,
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.white,
                                          backgroundImage: AssetImage(
                                            "assets/images/upload.png",
                                          ),
                                        ),
                                ),
                                Text(
                                  "Add Img",
                                  style: TextStyle(
                                      color: HexColor("#5F33E1"), fontSize: 19),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Task title",
                      style: TextStyle(
                          fontSize: 12,
                          color: HexColor("#6E6A7C"),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please complete the form';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter title here...",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#7F7F7F"),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: HexColor("#5F33E1"),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: HexColor("#BABABA"),
                              )),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Task Description",
                      style: TextStyle(
                          fontSize: 12,
                          color: HexColor("#6E6A7C"),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        maxLines: 10,
                        controller: descController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please complete the form';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter description here...",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#7F7F7F"),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: HexColor("#5F33E1"),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: HexColor("#BABABA"),
                              )),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Priority",
                      style: TextStyle(
                          fontSize: 12,
                          color: HexColor("#6E6A7C"),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: HexColor("#F0ECFF"),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          icon: Image.asset(
                            "assets/images/Arrow - Down 4.png",
                            color: HexColor("#5F33E1"),
                          ),
                          padding: const EdgeInsets.only(right: 10, left: 10),
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
                                "Medium Priority",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: HexColor("#5F33E1"),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          borderRadius: BorderRadius.zero,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please complete the form';
                            }
                            return null;
                          },
                          onChanged: (String? newVal) {
                            setState(() {
                              text22 = newVal;
                              resetKey.currentState?.reset();
                              /*cubit.getRegionByCity(
                                          cityId: city.toString());*/
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Due date",
                      style: TextStyle(
                          fontSize: 12,
                          color: HexColor("#6E6A7C"),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: startDate,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please complete the form';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? startPickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100));
                          if (startPickedDate != null) {
                            String formattedDate = DateFormat('dd-MM-yyyy')
                                .format(startPickedDate);
                            setState(() {
                              startDate.text = formattedDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "choose due date...",
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
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: HexColor("#5F33E1"),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: HexColor("#BABABA"),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! CreateTodoLoadingState,
                      builder: (context) {
                        return defaultButton(
                          function: () {
                            if (_formKey.currentState!.validate()) {
                              if (imageFile != null) {
                                AppCubit.get(context).createTodo(
                                  title: titleController.text,
                                  desc: descController.text,
                                  priority: text22,
                                  dueDate: startDate.text,
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "please upload image",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }
                          },
                          text: 'Add task',
                          background: HexColor('#5F33E1'),
                        );
                      },
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(
                          color: HexColor('#5F33E1'),
                        ),
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

  final List<String> items2 = [
    'low',
    'medium',
    'high',
  ];
}
