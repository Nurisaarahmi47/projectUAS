import 'package:flutter/material.dart';
import 'artikel_hidroponik.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: const Text("Balikpapan UrbanHarvest",
            style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                        'images/brian.jpg'), // Ganti dengan path gambar profil Anda
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Halo, selamat sore! 👋",
                          style: TextStyle(fontSize: 14)),
                      Text("Brian Arianto",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.settings, color: Colors.black),
                ],
              ),
              const SizedBox(height: 20),
              _buildWeatherCard(),
              const SizedBox(height: 20),
              _buildSectionTitle("Komoditas"),
              _buildCommoditiesSection(),
              const SizedBox(height: 20),
              _buildSectionTitle("Komunitas"),
              _buildCommunitySection(),
              const SizedBox(height: 20),
              _buildSectionTitle("Lapak Jual"),
              _buildMarketplaceSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cuaca Saat ini",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Sepinggan, Balikpapan Selatan", style: TextStyle(fontSize: 14)),
          Text("27 Okt 2024",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 16),
          Row(
            children: [
              Text("30°C",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text("Kelembapan 17%", style: TextStyle(fontSize: 14)),
              Spacer(),
              Column(
                children: [
                  Icon(Icons.wb_sunny, color: Colors.yellow, size: 36),
                  Text("Cerah", style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCommoditiesSection() {
    return Row(
      children: [
        _buildCommodityItem(
            "Hidroponik", 'images/hidroponik.jpg'), // Path gambar hidroponik
        const SizedBox(width: 16),
        _buildCommodityItem(
            "Budidaya Jamur Tiram", 'images/jamurtiram.jpg'), // Path gambar jamur
      ],
    );
  }

  Widget _buildCommodityItem(String title, String imagePath) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        if (title == "Hidroponik") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HydroponicsDetailsPage()),
          );
        }
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imagePath, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    ),
  );
}

  Widget _buildCommunitySection() {
    return Column(
      children: [
        _buildCommunityItem(
            "Cocok tanam uhuy", "diskusi hidroponik | 150 orang"),
        const SizedBox(height: 10),
        _buildCommunityItem("Diskusi bebas", "diskusi seputar | 270 orang"),
      ],
    );
  }

  Widget _buildCommunityItem(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.group, color: Colors.green),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            child: const Text("Gabung"),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketplaceSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMarketplaceIcon(Icons.shopping_basket, "Cabai"),
        _buildMarketplaceIcon(Icons.apple, "Tomat"),
        _buildMarketplaceIcon(Icons.eco, "Pakcoy"),
        _buildMarketplaceIcon(Icons.local_florist, "Selada"),
      ],
    );
  }

  Widget _buildMarketplaceIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.green),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Utama"),
        BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity), label: "Komunitas"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: "Informasi"),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: "Lapak"),
      ],
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
    );
  }
}
