import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Opsional untuk link GitHub

class AboutDownloaderScreen extends StatelessWidget {
  const AboutDownloaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildHeroHeader(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMissionStatement(),
                  const SizedBox(height: 30),
                  const Text(
                    "CORE TECHNOLOGY",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildTechGrid(),
                  const SizedBox(height: 30),
                  _buildOrganizationCard(),
                  const SizedBox(height: 30),
                  _buildLegalFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return SliverAppBar(
      expandedHeight: 200,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center,
          children: [
            // Dekorasi Grid ala YouTube sebelumnya
            Opacity(
              opacity: 0.1,
              child: Icon(Icons.hub, size: 300, color: Colors.blueAccent),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "SYNTXFLOW PROTOCOL",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Version 2.0.4 - Stable Release",
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionStatement() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Solusi Satu Pintu untuk Media Sosial.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Aplikasi ini dibangun untuk memberikan akses cepat dan efisien dalam mengunduh konten dari berbagai platform tanpa hambatan iklan atau biaya langganan.",
            style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTechGrid() {
    final List<Map<String, dynamic>> techs = [
      {"icon": Icons.flash_on, "label": "Modern & Fast"},
      {"icon": Icons.code, "label": "Flutter Core"},
      {"icon": Icons.api, "label": "Enterprise API"},
      {"icon": Icons.data_array, "label": "Scraping Engine"},
      {"icon": Icons.ads_click, "label": "Zero Ads"},
      {"icon": Icons.favorite, "label": "Free to Use"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: techs.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(techs[index]['icon'], color: Colors.blueAccent, size: 18),
              const SizedBox(width: 10),
              Text(
                techs[index]['label'],
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrganizationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            // child: Icon(Icons.terminal, color: Colors.black, size: 30),
            child: Image.network(
              "https://avatars.githubusercontent.com/u/205189488?s=200&v=4",
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Developed by",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const Text(
            "SyntxFlow",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Organisasi Open Source yang berdedikasi menciptakan alat - alat digital transparan dan bertenaga tinggi.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () async {
              if (!await launchUrl(Uri(scheme: 'https', host: 'github.com', path: 'syntxflow'), mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch https://github.com/syntxflow');
              }
            },
            icon: const Icon(Icons.account_tree_outlined, size: 18),
            label: const Text("GITHUB REPOSITORY"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blueAccent,
              side: const BorderSide(color: Colors.blueAccent),
              shape: const StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalFooter() {
    return const Center(
      child: Column(
        children: [
          Text(
            "MADE WITH LOVE & CODE",
            style: TextStyle(
              color: Colors.white24,
              fontSize: 10,
              letterSpacing: 3,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "SyntxFlow © 2026. All Rights Reserved.",
            style: TextStyle(color: Colors.white10, fontSize: 10),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
