//scan view
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/helpers/utils.dart';
import 'package:qr_scanner_with_effect/qr_scanner_with_effect.dart';
import 'package:remindly/model_view/friend_provider.dart';

class ScanViwePage extends StatefulWidget {
  const ScanViwePage({super.key});

  @override
  State<ScanViwePage> createState() => _ScanViwePageState();
}

class _ScanViwePageState extends State<ScanViwePage> {
  // ScanController controller = ScanController();
  String qrcode = 'Loading...';
  @override
  Widget build(BuildContext context) {
    return Consumer<FriendProvider>(
      builder: (context, friendProvider, child) => Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        appBar: myAppbar(context, "Scan QR Code"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(qrcode),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Scan for added friend',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250, // custom wrap size
                height: 250,
                child: QrScannerWithEffect(
                  isScanComplete: false,
                  qrKey: GlobalKey(debugLabel: 'QR'),
                  onQrScannerViewCreated: (v) {
                    v.scannedDataStream.listen((scanData) async {
                      var result = scanData;
                      v.pauseCamera();

                      await Future<void>.delayed(
                          const Duration(milliseconds: 300));

                      String? myQrCode = result.code != null &&
                              result.code.toString().isNotEmpty
                          ? result.code.toString()
                          : '';
                      if (myQrCode.isNotEmpty) {
                        setState(() {
                          qrcode = 'we found a qr code';
                        });
                        loadingWidget(context);
                        await friendProvider.addFriend(myQrCode).then((value) {
                          Navigator.pop(context);
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Friend added successfully'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to add friend'),
                              ),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid QR Code'),
                          ),
                        );
                      }
                    });
                  },
                  qrOverlayBorderColor: Colors.green,
                  cutOutSize: (MediaQuery.of(context).size.width < 300 ||
                          MediaQuery.of(context).size.height < 400)
                      ? 250.0
                      : 300.0,
                  effectGradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1],
                    colors: [
                      Colors.greenAccent,
                      Colors.greenAccent,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
