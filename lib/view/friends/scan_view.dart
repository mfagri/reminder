//scan view
import 'package:flutter/material.dart';
import 'package:myapp/helpers/utils.dart';
import 'package:qr_scanner_with_effect/qr_scanner_with_effect.dart';

class ScanViwePage extends StatefulWidget {
  const ScanViwePage({super.key});

  @override
  State<ScanViwePage> createState() => _ScanViwePageState();
}

class _ScanViwePageState extends State<ScanViwePage> {
  // ScanController controller = ScanController();
  String qrcode = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                    String? myQrCode =
                        result.code != null && result.code.toString().isNotEmpty
                            ? result.code.toString()
                            : '';
                    if (myQrCode.isNotEmpty) {
                      setState(() {
                        qrcode = myQrCode;
                      });
                    } else {
                      qrcode = "empty";
                    }
                  });
                },
                qrOverlayBorderColor: Colors.redAccent,
                cutOutSize: (MediaQuery.of(context).size.width < 300 ||
                        MediaQuery.of(context).size.height < 400)
                    ? 250.0
                    : 300.0,
                // onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
                effectGradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1],
                  colors: [
                    Colors.redAccent,
                    Colors.redAccent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
