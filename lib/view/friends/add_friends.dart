import 'package:flutter/material.dart';
import 'package:myapp/helpers/icon_constants.dart';
import 'package:myapp/helpers/utils.dart';
import 'package:myapp/view/friends/friends_item.dart';
import 'package:qr_scanner_with_effect/qr_scanner_with_effect.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
// import 'package:scan/scan.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({super.key});

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: Container(
          height: 100,
          color: const Color(0xffE3E3E3),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Add Friends',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0.06,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:
                          appIcon(IconsConstants.back, false, context, 15, 15))
                ],
              ),
            ),
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 14,
                right: 14,
              ),
              child: TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,

                  fillColor: Colors.white,
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    // Suggested code may be subject to a license. Learn more: ~LicenseLog:663312493.
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  // Suggested code may be subject to a license. Learn more: ~LicenseLog:2661310012.
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  suffixIcon: InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScanViwePage(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.qr_code_scanner,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 30,
                    maxWidth: 40,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const FrindsItem();
                  }),
            )
          ],
        ),
      ),
    );
  }
}

//scan view
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
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: Container(
          height: 100,
          color: const Color(0xffE3E3E3),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Scan QR Code',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0.06,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:
                          appIcon(IconsConstants.back, false, context, 15, 15))
                ],
              ),
            ),
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width,
      ),
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
