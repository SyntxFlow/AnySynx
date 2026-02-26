import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:anysynx/core/req_api.dart' show ApiService;
import 'package:anysynx/core/logger.dart' show appLog, LogLevel;

class TikTokDownloaderScreen extends StatefulWidget {
  const TikTokDownloaderScreen({super.key});

  @override
  State<TikTokDownloaderScreen> createState() => _TikTokDownloaderScreenState();
}

class _TikTokDownloaderScreenState extends State<TikTokDownloaderScreen> {
  bool _isDownloading = false;
  bool _showPreview = false;
  bool _isError = false;
  final TextEditingController _urlController = TextEditingController();

  Map<String, dynamic> _tiktokData = {};

  void _handleDownload() async {
    try {
      setState(() {
        _isDownloading = true;
        _showPreview = false;
        _isError = false;
      });
      Map<String, dynamic> payload = {
        "url": _urlController.value.text,
        "is_mp3_page": false,
      };
      appLog("HANDLE_DOWNLOAD", "$payload", level: LogLevel.info);

      String response = await ApiService.get(
        "https://tikwm.com/api/?url=${_urlController.value.text}&hd=1",
      );
      appLog("HANDLE_DOWNLOAD", response, level: LogLevel.info);
      _tiktokData = jsonDecode(response);

      setState(() {
        _isDownloading = false;
        _showPreview = true;
        _isError = false;
      });
    } catch (e) {
      setState(() {
        _isDownloading = false;
        _showPreview = true;
        _isError = true;
      });

    }
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
          title: const Text(
            "TIKDOWNLOAD",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 16,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.history, color: Colors.blueAccent),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(),
              const SizedBox(height: 25),
              _buildInputSection(),
              const SizedBox(height: 30),
              _showPreview
                  ? _isError
                  ? _buildErrorState()
                  : _buildPreviewCard(_tiktokData)
                  : _buildPlaceholderArt(),
              const SizedBox(height: 120.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.wifi_off_rounded, size: 70, color: Colors.redAccent.withValues(alpha: 0.1)),
              const Icon(Icons.gpp_maybe_outlined, size: 50, color: Colors.redAccent),
            ],
          ),
          const SizedBox(height: 25),
          
          const Text(
            "FETCH_PROTOCOL_FAILED",
            style: TextStyle(
              color: Colors.redAccent,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          
          const Text(
            "Gagal melakukan ekstraksi data dari API external. Pastikan URL TikTok valid atau coba beberapa saat lagi.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 30),
          
          SizedBox(
            width: 160,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _showPreview = false; 
                  _isDownloading = false;
                });
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh_rounded, size: 18, color: Colors.white),
                  SizedBox(width: 8),
                  Text("RETRY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "ERR_CODE: 403_FORBIDDEN_OR_INVALID_TOKEN",
              style: TextStyle(color: Colors.white12, fontSize: 9, fontFamily: 'monospace'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TikTok Extractor",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "High-speed scraping",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _urlController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Paste TikTok URL here...",
                hintStyle: TextStyle(color: Colors.white24, fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _isDownloading ? null : _handleDownload,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: _isDownloading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    "ANALYZE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard(Map<String, dynamic> response) {
    // Navigasi ke dalam field 'data'
    final data = response['data'];
    final author = data['author'];
    final music = data['music_info'];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 00.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SECTION 1: HEADER & COVER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      data['cover'],
                      height: 140,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(5)),
                      child: Text("${data['duration']}s", style: const TextStyle(color: Colors.white, fontSize: 9)),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(radius: 10, backgroundImage: NetworkImage(author['avatar'])),
                        const SizedBox(width: 8),
                        Text("@${author['unique_id']}", 
                          style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(data['title'], 
                      maxLines: 3, overflow: TextOverflow.ellipsis, 
                      style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.4)),
                    const SizedBox(height: 12),
                    // Stats Grid
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        _miniStat(Icons.favorite, "${data['digg_count']}"),
                        _miniStat(Icons.remove_red_eye, "${data['play_count']}"),
                        _miniStat(Icons.share, "${data['share_count']}"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 15),

          // SECTION 2: DOWNLOAD OPTIONS (VIDEO)
          _buildDownloadHeader("VIDEO ASSETS"),
          const SizedBox(height: 10),
          _downloadTile("HD Video (No Watermark)", "MP4", (data['hd_size']/1024/1024).toStringAsFixed(2), Colors.blueAccent),
          _downloadTile("Original Video (Watermark)", "MP4", (data['size']/1024/1024).toStringAsFixed(2), Colors.white38),
          
          const SizedBox(height: 15),
          
          // SECTION 3: MUSIC SECTION
          _buildDownloadHeader("AUDIO ASSETS"),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 00.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 00.05))
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(music['cover'], width: 40, height: 40),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(music['title'], maxLines: 1, overflow: TextOverflow.ellipsis, 
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      Text("Artist: ${music['author']}", style: const TextStyle(color: Colors.white38, fontSize: 9)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.music_note, color: Colors.blueAccent),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadHeader(String title) {
    return Text(title, style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5));
  }

  Widget _miniStat(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white24, size: 14),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(color: Colors.white54, fontSize: 10)),
      ],
    );
  }

  Widget _downloadTile(String title, String ext, String size, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: accentColor.withValues(alpha: 00.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
              Text("$ext • $size MB", style: TextStyle(color: accentColor.withValues(alpha: 00.6), fontSize: 10)),
            ],
          ),
          Icon(Icons.download_for_offline_rounded, color: accentColor),
        ],
      ),
    );
  }

  Widget _buildPlaceholderArt() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bolt,
            color: Colors.blueAccent.withValues(alpha: 0.2),
            size: 50,
          ),
          const SizedBox(height: 10),
          const Text(
            "Ready for Data Extraction",
            style: TextStyle(color: Colors.white12, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
