import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tasky/cubit/cubit.dart';
import '../../cubit/states.dart';
import '../Task Details/Task Details.dart';

class QrScreen extends StatefulWidget {
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else {
      if (Platform.isIOS) {
        controller!.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetTodoSuccessState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TaskDetails()));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController controller) async {
                    setState(() => this.controller = controller);
                    await controller.resumeCamera();
                    await controller.scannedDataStream.listen((barcode) {
                      setState(() {
                        barcode = barcode;
                      });
                      AppCubit.get(context).getOne(id: barcode.code!);
                      controller.stopCamera();
                    });
                  },
                  overlay: QrScannerOverlayShape(
                    borderColor: HexColor('#5F33E1'),
                    borderWidth: 10,
                    borderLength: 20,
                    borderRadius: 10,
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
