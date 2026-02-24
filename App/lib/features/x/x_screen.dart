import 'package:flutter/material.dart';

class XDownloaderScreen extends StatefulWidget {
  const XDownloaderScreen({super.key});

  @override
  State<XDownloaderScreen> createState() => _XDownloaderScreenState();
}

class _XDownloaderScreenState extends State<XDownloaderScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isProcessing = false;
  bool _showData = false;

  void _executeFetch() {
    if (_urlController.text.isEmpty) return;
    setState(() => _isProcessing = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isProcessing = false;
        _showData = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _buildXLogoWatermark(), // Dekorasi background logo X samar
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildTopHeader(),
                    const SizedBox(height: 40),
                    _buildInputTerminal(),
                    const SizedBox(height: 25),
                    _isProcessing
                        ? _buildSyncingState()
                        : (_showData
                              ? _buildXContentCard()
                              : _buildDataArchitecture()),
                    const SizedBox(height: 30),
                    _buildGlobalStats(), // Ruang pengisi statistik global
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildXLogoWatermark() {
    return Positioned(
      bottom: -50,
      right: -50,
      child: Opacity(
        opacity: 0.03,
        child: Icon(Icons.close, size: 400, color: Colors.blueAccent),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              "X",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "X-EXTRACTOR",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              "Powered by Neural Network Simulation",
              style: TextStyle(color: Colors.blueAccent, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputTerminal() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(4),
        border: const Border(
          left: BorderSide(color: Colors.blueAccent, width: 4),
        ),
      ),
      child: TextField(
        controller: _urlController,
        style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
        decoration: InputDecoration(
          hintText: "Enter X Post URL (Status/Video)...",
          hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: _executeFetch,
            icon: const Icon(Icons.bolt, color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  Widget _buildXContentCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 18,
                  child: Icon(Icons.person, size: 20, color: Colors.black),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "X_User_Official",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "@elon_fan_project",
                      style: TextStyle(
                        color: Colors.blueAccent.withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Image.network(
            "https://api.placeholder.com/600/350",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _iconStat(Icons.hd, "4K UHD"),
                    _iconStat(Icons.audiotrack, "AAC Audio"),
                    _iconStat(Icons.timer, "00:45"),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape:
                          const BeveledRectangleBorder(), // Sudut tajam futuristik
                    ),
                    child: const Text(
                      "DOWNLOAD MEDIA",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconStat(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 20),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }

  Widget _buildDataArchitecture() {
    return Column(
      children: [
        _infoTile("ENCRYPTION", "X-SHIELD ENABLED"),
        const SizedBox(height: 10),
        _infoTile("ACCESS", "DIRECT CDN PROTOCOL"),
        const SizedBox(height: 10),
        _infoTile("GEOMETRY", "MULTI-THREADED"),
      ],
    );
  }

  Widget _infoTile(String title, String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
          Text(
            status,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncingState() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          const CircularProgressIndicator(
            color: Colors.blueAccent,
            strokeWidth: 1,
          ),
          const SizedBox(height: 20),
          Text(
            "SYNCHRONIZING WITH X-CORE...",
            style: TextStyle(
              color: Colors.blueAccent.withValues(alpha: 0.5),
              letterSpacing: 3,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlobalStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent.withValues(alpha: 0.1),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "LIVE TRAFFIC DATA",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Total Assets Saved: 1,294,031",
            style: TextStyle(color: Colors.white30, fontSize: 12),
          ),
          Text(
            "Average Bandwidth: 852 MB/s",
            style: TextStyle(color: Colors.white30, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
