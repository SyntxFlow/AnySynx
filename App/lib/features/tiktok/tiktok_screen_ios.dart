import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors; // Mengambil icon saja

class TikTokDownloaderCupertino extends StatefulWidget {
  const TikTokDownloaderCupertino({super.key});

  @override
  TikTokDownloaderCupertinoState createState() => TikTokDownloaderCupertinoState();
}

class TikTokDownloaderCupertinoState extends State<TikTokDownloaderCupertino> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        middle: Text("TIK-SAVER ENT", style: TextStyle(color: Colors.white)),
        trailing: Icon(CupertinoIcons.settings, color: Colors.blueAccent),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            // Dashboard Stats
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blueAccent, Colors.blue.shade900]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _cupeStat("Total", "1.2k"),
                  _cupeStat("Storage", "4.5GB"),
                  _cupeStat("Speed", "24MB/s"),
                ],
              ),
            ),
            SizedBox(height: 25),
            
            Text("VIDEO LINK", style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            CupertinoTextField(
              placeholder: "https://www.tiktok.com/...",
              placeholderStyle: TextStyle(color: Colors.grey),
              padding: EdgeInsets.all(15),
              style: TextStyle(color: Colors.white),
              decoration: BoxDecoration(
                color: Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(height: 20),
            CupertinoButton(
              color: Colors.blueAccent,
              child: Text("FETCH CONTENT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              onPressed: () {},
            ),
            SizedBox(height: 30),
            
            // Preview Placeholder
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    Center(child: Icon(CupertinoIcons.video_camera, color: Colors.white24, size: 60)),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        padding: EdgeInsets.all(15),
                        color: Colors.black.withValues(alpha: 0.6),
                        child: Row(
                          children: [
                            Container(width: 50, height: 50, color: Colors.white10),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(width: 100, height: 10, color: Colors.white10),
                                SizedBox(height: 8),
                                Container(width: 150, height: 10, color: Colors.white10),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildActionGrid(),
          ],
        ),
      ),
    );
  }

  Widget _cupeStat(String title, String val) {
    return Column(
      children: [
        Text(val, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        Text(title, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildActionGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.5,
      children: [
        _gridBtn("Auto-Save", CupertinoIcons.refresh_thick),
        _gridBtn("MP3 Only", CupertinoIcons.music_note),
        _gridBtn("Batch Down", CupertinoIcons.layers_alt),
        _gridBtn("Analytics", CupertinoIcons.graph_square),
      ],
    );
  }

  Widget _gridBtn(String text, IconData icon) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 18),
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}