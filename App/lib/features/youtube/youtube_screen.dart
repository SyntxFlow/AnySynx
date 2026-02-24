import 'package:flutter/material.dart';

class YouTubeDownloaderScreen extends StatefulWidget {
  const YouTubeDownloaderScreen({super.key});

  @override
  State<YouTubeDownloaderScreen> createState() => _YouTubeDownloaderScreenState();
}

class _YouTubeDownloaderScreenState extends State<YouTubeDownloaderScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isAnalyzing = false;
  bool _isReady = false;
  String _selectedResolution = "1080p";

  void _processLink() {
    if (_urlController.text.isEmpty) return;
    setState(() => _isAnalyzing = true);

    // Simulasi parsing data YouTube yang kompleks
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isAnalyzing = false;
        _isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: Stack(
          children: [
            _buildGridBackground(), // Dekorasi background ala blueprint
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(),
                    const SizedBox(height: 25),
                    _buildServerTraffic(), // Pengisi ruang: Visualisasi trafik
                    const SizedBox(height: 30),
                    _buildInputStation(),
                    const SizedBox(height: 25),
                    _isAnalyzing 
                        ? _buildAnalysisLoading() 
                        : (_isReady ? _buildControlCenter() : _buildFeatureGuide()),
                    const SizedBox(height: 30),
                    _buildDownloadQueue(), // Dekorasi: Antrean download
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildGridBackground() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.05,
        child: CustomPaint(
          painter: GridPainter(),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("YT-QUANTUM", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w900, letterSpacing: 4)),
            Text("DATA EXTRACTION SUITE", style: TextStyle(color: Colors.blueAccent.withValues(alpha: 0.5), fontSize: 10)),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.blueAccent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.settings_input_component, color: Colors.blueAccent, size: 20),
        )
      ],
    );
  }

  Widget _buildServerTraffic() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(12, (index) => Container(
          width: 4,
          height: (index % 3 == 0) ? 20 : 10,
          decoration: BoxDecoration(
            color: index < 5 ? Colors.blueAccent : Colors.white10,
            borderRadius: BorderRadius.circular(10),
          ),
        )),
      ),
    );
  }

  Widget _buildInputStation() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.blueAccent.withValues(alpha: 0.05), blurRadius: 20, spreadRadius: 5)
            ],
          ),
          child: TextField(
            controller: _urlController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter YouTube Video or Playlist URL...",
              hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
              prefixIcon: const Icon(Icons.play_circle_filled, color: Colors.blueAccent),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(vertical: 25),
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: _isAnalyzing ? null : _processLink,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text("INITIALIZE SCAN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2)),
          ),
        ),
      ],
    );
  }

  Widget _buildControlCenter() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Image.network("https://api.placeholder.com/640/360", fit: BoxFit.cover, width: double.infinity),
                  Container(color: Colors.black38),
                  const Center(child: Icon(Icons.play_arrow, color: Colors.white, size: 50)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Advanced Coding Tutorial 2026", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("Channel: TechVision • 45:12 Duration", style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(color: Colors.white10, height: 30),
          const Text("SELECT RESOLUTION", style: TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: ["4K", "1080p", "720p", "MP3"].map((res) {
              bool isSelected = _selectedResolution == res;
              return ChoiceChip(
                label: Text(res),
                selected: isSelected,
                onSelected: (v) => setState(() => _selectedResolution = res),
                selectedColor: Colors.blueAccent,
                backgroundColor: const Color(0xFF1A1A1A),
                labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white, fontSize: 12),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          _buildActionButton(Icons.cloud_download, "START ENCRYPTED DOWNLOAD"),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.blueAccent, Color(0xFF0055FF)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black, size: 20),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildFeatureGuide() {
    return Column(
      children: [
        _featureRow(Icons.folder_zip, "Playlist Support", "Download entire albums in one click."),
        const SizedBox(height: 15),
        _featureRow(Icons.high_quality, "Ultra HD Content", "Supports up to 8K resolution extraction."),
      ],
    );
  }

  Widget _featureRow(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFF0A0A0A), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 15),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildDownloadQueue() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("ACTIVE NODES & HISTORY", style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        ...List.generate(2, (index) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF0A0A0A), borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 16),
              const SizedBox(width: 10),
              const Expanded(child: Text("yt_data_node_4491.mp4", style: TextStyle(color: Colors.white70, fontSize: 12))),
              Text(index == 0 ? "COMPLETED" : "CACHED", style: const TextStyle(color: Colors.blueAccent, fontSize: 9)),
            ],
          ),
        ))
      ],
    );
  }

  Widget _buildAnalysisLoading() {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 40),
          CircularProgressIndicator(color: Colors.blueAccent),
          SizedBox(height: 20),
          Text("BYPASSING GEOMETRY RESTRICTIONS...", style: TextStyle(color: Colors.blueAccent, fontSize: 10, letterSpacing: 1.5)),
        ],
      ),
    );
  }
}

// Painter untuk membuat background grid (blueprint)
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.blueAccent..strokeWidth = 0.5;
    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}