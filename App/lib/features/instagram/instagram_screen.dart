import 'package:flutter/material.dart';

class InstagramDownloaderScreen extends StatefulWidget {
  const InstagramDownloaderScreen({super.key});

  @override
  State<InstagramDownloaderScreen> createState() => _InstagramDownloaderScreenState();
}

class _InstagramDownloaderScreenState extends State<InstagramDownloaderScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;

  // Fungsi simulasi analisa link
  void _startAnalysis() {
    if (_urlController.text.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _isSuccess = false;
    });

    // Simulasi delay proses server 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Membungkus dengan GestureDetector agar saat tap area kosong, keyboard tertutup
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Layer 1: Background Decoration (Biar gak kosong)
            _buildBackgroundGlow(),
            
            // Layer 2: Main Content
            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  _buildAppBar(),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 10),
                        if (_isLoading) LinearProgressIndicator(
                          backgroundColor: Colors.blueAccent.withValues(alpha: 0.1),
                          color: Colors.blueAccent,
                          minHeight: 2,
                        ),
                        const SizedBox(height: 20),
                        _buildMainInput(),
                        const SizedBox(height: 30),
                        _isSuccess ? _buildPreviewCard() : _buildEnterprisePlaceholder(),
                        const SizedBox(height: 30),
                        _buildSystemStats(),
                        const SizedBox(height: 20),
                        _buildFooterLogs(),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildBackgroundGlow() {
    return Positioned(
      top: -150,
      left: -100,
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueAccent.withValues(alpha: 0.08),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.black,
      floating: true,
      centerTitle: false,
      title: const Text(
        "INSTA-ELITE v1.0",
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontSize: 14,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.history_rounded, color: Colors.blueAccent),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMainInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Premium Extraction",
          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Paste the media URL below for high-speed fetch.",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: TextField(
            controller: _urlController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "https://instagram.com/p/...",
              hintStyle: const TextStyle(color: Colors.white24),
              prefixIcon: const Icon(Icons.link, color: Colors.blueAccent),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              suffixIcon: IconButton(
                onPressed: _isLoading ? null : _startAnalysis,
                icon: const Icon(Icons.rocket_launch, color: Colors.blueAccent),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://api.placeholder.com/400/500", 
              height: 250, width: double.infinity, fit: BoxFit.cover,
            ),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("Cinematic Asset Detected", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("Size: 12.4 MB • Format: MP4", style: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text("SAVE TO GALLERY"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEnterprisePlaceholder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Icon(Icons.shield_moon_outlined, size: 48, color: Colors.blueAccent.withValues(alpha: 0.2)),
          const SizedBox(height: 15),
          const Text("Awaiting Data Stream", style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold)),
          const Text("Ready for secure multi-threaded download", style: TextStyle(color: Colors.white12, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildSystemStats() {
    return Row(
      children: [
        _statBox("ENGINE", "ACTIVE", Colors.blueAccent),
        const SizedBox(width: 10),
        _statBox("LATENCY", "12ms", Colors.green),
        const SizedBox(width: 10),
        _statBox("THREADS", "x64", Colors.blueAccent),
      ],
    );
  }

  Widget _statBox(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
            Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterLogs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("NETWORK CONSOLE", style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF050505),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            "> Handshake with Instagram CDN...\n> Connection established.\n> Encryption layer: AES-256 enabled.",
            style: TextStyle(color: Colors.green, fontSize: 9, fontFamily: 'monospace'),
          ),
        ),
      ],
    );
  }
}