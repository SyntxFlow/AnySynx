import 'package:flutter/material.dart';

import 'package:anysynx/core/req_api.dart' show ApiService;

class DevelopedScreen extends StatelessWidget {
  const DevelopedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: ElevatedButton(onPressed: () async {
          Map<String, dynamic> payload = {
            "url":"https://www.tiktok.com/@wesessewes/video/7609597607232523528?is_from_webapp=1&sender_device=pc",
            "is_mp3_page":false
          };

          final response = await ApiService.post("https://ttdl.cc/api/extract", payload);
          print(response);
        }, child: const Text("Panggil fungsi rust")),
      )),
    );
  }
}