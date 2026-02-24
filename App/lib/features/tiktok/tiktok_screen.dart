import 'package:flutter/material.dart';
// import 'package:dotted_border/dotted_border.dart';

class TikTokDownloaderScreen extends StatefulWidget {
  const TikTokDownloaderScreen({super.key});

  @override
  State<TikTokDownloaderScreen> createState() => _TikTokDownloaderScreenState();
}

class _TikTokDownloaderScreenState extends State<TikTokDownloaderScreen> {
  bool _isDownloading = false;
  bool _showPreview = false;
  final TextEditingController _urlController = TextEditingController();

  void _handleDownload() {
    setState(() => _isDownloading = true);
    // Simulasi loading
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isDownloading = false;
        _showPreview = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text("TIKDOWNLOAD PRO", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          actions: [IconButton(icon: Icon(Icons.history, color: Colors.blueAccent), onPressed: () {})],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(),
              SizedBox(height: 25),
              _buildInputSection(),
              SizedBox(height: 30),
              _showPreview ? _buildPreviewCard() : _buildPlaceholderArt(),
              SizedBox(height: 30),
              _buildRecentActivity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enterprise Downloader", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        Text("Paste your link and get high quality content", style: TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  Widget _buildInputSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _urlController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Paste TikTok URL here...",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _isDownloading ? null : _handleDownload,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            child: _isDownloading 
              ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text("ANALYZE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              "https://api.placeholder.com/400/200", // Ganti dengan thumbnail asli
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 15),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(backgroundColor: Colors.blueAccent, child: Icon(Icons.person, color: Colors.black)),
            title: Text("Creator_Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("The amazing video description goes here...", style: TextStyle(color: Colors.grey[400])),
          ),
          Divider(color: Colors.blueAccent.withValues(alpha: 0.3)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatIcon(Icons.download_rounded, "No Watermark"),
              _buildStatIcon(Icons.music_note, "MP3 Audio"),
              _buildStatIcon(Icons.hd, "HD Video"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPlaceholderArt() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.1)), // Note: Dash effect requires CustomPainter or package
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_download_outlined, color: Colors.blueAccent.withValues(alpha: 0.3), size: 50),
          SizedBox(height: 10),
          Text("Waiting for input...", style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Downloads", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        ...List.generate(3, (index) => Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.blueAccent.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.check, color: Colors.blueAccent)),
              SizedBox(width: 15),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("tiktok_video_${100 + index}.mp4", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                Text("Saved to /Downloads", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildStatIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }
}