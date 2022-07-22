import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/hotline_controller.dart';

class HotlineView extends GetView<HotlineController> {
  const HotlineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6045E2),
        title: const Text('HotlineView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            HotLineButton(
              icon: Icons.phone,
              type: "tel",
              url: "119",
              hotlineLabel: "119",
            ),
            SizedBox(height: 20),
            HotLineButton(
              icon: Icons.mail,
              type: "mailto",
              url: "support@covid19.go.id",
              hotlineLabel: "Email",
            ),
            SizedBox(height: 20),
            HotLineButton(
              icon: Icons.facebook,
              type: "https",
              url: "https://www.facebook.com/lawancovid19indonesia?_rdc=1&_rdr",
              hotlineLabel: "Facebook",
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class HotLineButton extends StatelessWidget {
  IconData icon;
  String type;
  String url;
  String hotlineLabel;

  HotLineButton({
    required IconData this.icon,
    required String this.type,
    required String this.url,
    required String this.hotlineLabel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri _url = Uri.parse("$type:$url");

        launchUrl(
          _url,
          mode: LaunchMode.externalApplication,
          webViewConfiguration: WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      },
      hoverColor: Colors.red,
      child: Ink(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF6045E2)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(width: 20),
            Icon(
              icon,
              color: Colors.black,
            ),
            SizedBox(width: 20),
            Text(
              hotlineLabel,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
