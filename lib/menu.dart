import 'package:flutter/material.dart';
import 'theme.dart';

// Helper untuk ItemCard dan logout
void showInfoSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = "2506541622";
  final String nama = "Syakira";
  final String kelas = "PBP B";

  final List<ItemHomepage> viewItems = const [
    ItemHomepage(name: "View Projects", icon: Icons.folder_rounded,
        bgColor: AppColors.mint, iconColor: AppColors.mintIcon),
    ItemHomepage(name: "View Education", icon: Icons.school_rounded,
        bgColor: AppColors.peach, iconColor: AppColors.peachIcon),
    ItemHomepage(name: "View Skills", icon: Icons.build,
        bgColor: AppColors.lilac, iconColor: AppColors.lilacIcon),
  ];

  final List<ItemHomepage> addItems = const [
    ItemHomepage(name: "Add Projects", icon: Icons.add_circle_rounded,
        bgColor: AppColors.coral, iconColor: AppColors.coralIcon),
    ItemHomepage(name: "Add Education", icon: Icons.add_circle_rounded,
        bgColor: AppColors.sky, iconColor: AppColors.skyIcon),
  ];

  // Helper: membangun grid dari sebuah list
  Widget _buildGrid(List<ItemHomepage> items,
      {required int columns, required double ratio}) {
    return GridView.count(
      crossAxisCount: columns,
      childAspectRatio: ratio,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,                              
      physics: const NeverScrollableScrollPhysics(), 
      children: items.map((item) => ItemCard(item)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyPortfolio')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480), 
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileHeader(nama: nama),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: InfoCard(title: 'NPM', content: npm)),
                      const SizedBox(width: 12),
                      Expanded(child: InfoCard(title: 'Class', content: kelas)),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const SectionLabel('View'),
                  const SizedBox(height: 10),
                  _buildGrid(viewItems, columns: 3, ratio: 1.0),
                  const SizedBox(height: 22),
                  const SectionLabel('Add'),
                  const SizedBox(height: 10),
                  _buildGrid(addItems, columns: 2, ratio: 2.0),
                  const SizedBox(height: 22),
                  const LogoutButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String nama;
  const ProfileHeader({super.key, required this.nama});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hi, I am',
                    style: TextStyle(fontSize: 15,
                        letterSpacing: 1, color: AppColors.muted)),
                const SizedBox(height: 10),
                Text(nama,
                    style: TextStyle(
                        fontSize: 44, fontWeight: FontWeight.w700, height: 1.05)),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                  letterSpacing: 0.8, color: AppColors.muted)),
          const SizedBox(height: 5),
          Text(content,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const ItemHomepage({
    required this.name,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.bgColor,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22), // supaya ripple ikut membulat
        onTap: () => showInfoSnack(context, "You have pressed a button named ${item.name}!"),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: item.iconColor, size: 30),
              const SizedBox(height: 8),
              Text(item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
            letterSpacing: 1.6, color: AppColors.sectionLabel));
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.sage,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        onPressed: () => showInfoSnack(context, "You have pressed a logout button!"),
        icon: const Icon(Icons.logout_rounded, size: 20),
        label: const Text('Logout'),
      ),
    );
  }
}