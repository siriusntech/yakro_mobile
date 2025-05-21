import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/Reduction/reduction_path.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
// import 'package:jaime_yakro/routes/path_route.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:quickalert/models/quickalert_type.dart';

class ScannerComponent extends StatefulWidget {
  const ScannerComponent({super.key});

  @override
  State<ScannerComponent> createState() => _ScannerComponentState();
}

class _ScannerComponentState extends State<ScannerComponent> {
  final ReductionScreenController controllerReduc =
      Get.put(ReductionScreenController());
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;
  QRViewController? controller;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: QRView(
                        key: qrKey,
                        overlay: QrScannerOverlayShape(
                          borderColor: Colors.white,
                          cutOutBottomOffset: 20,
                          borderLength: 80,
                          borderRadius: 10,
                          overlayColor:
                              const Color(0xFF000000).withOpacity(0.8),
                          cutOutSize: 300,
                          borderWidth: 5,
                        ),
                        onQRViewCreated: _onQRViewCreated,
                        formatsAllowed: const [BarcodeFormat.qrcode],
                        cameraFacing: CameraFacing.back,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 50,
                      right: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Scanner pour avoir une réduction 🧮",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: GoogleFonts.nunito().fontFamily),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.stopCamera();

      setState(() {
        result = scanData;
      });
      // print(scanData.code);
      // return null;
      if (scanData.code != null || scanData.code != '') {
        controllerReduc.checkHotel(scanData.code!);
        controllerReduc.changeReservations(scanData.code!);
        quickAlertDialog(
          context,
          QuickAlertType.loading,
          color: controllerReduc.colorPrimary.value,
          message: "Veuillez patienter",
          title: "Chargement",
        );

        // Navigator.of(context).pop();
        //       if (scanData.code == 'https://www.jaimebabi.com/') {
        //         quickAlertDialog(context, QuickAlertType.success, color: controllerReduc.colorPrimary.value, message: "Qr Code Valide", title: "Succès",);
        //         Future.delayed(const Duration(seconds: 2), () {
        // Get.toNamed(AppRoutes.reductionScreen);
        //         });
        //       } else {
        //         quickAlertDialog(context, QuickAlertType.error, color: controllerReduc.colorPrimary.value, message: "Qr Code Invalide", title: "Echec",);
        //       }
      }
      controller.resumeCamera();
      // print(result!.code);
    });
  }
}
