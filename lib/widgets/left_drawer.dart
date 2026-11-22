import 'package:material_ui/material_ui.dart';
import '../screens/menu.dart';
import '../screens/project_form.dart';
import '../screens/experience_form.dart';
import '../theme.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.ink,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Navigasi ke halaman utama portofolio
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            // Navigasi ke halaman tambah proyek
            onTap: () {  
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProjectFormPage()));   
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Experience'),
            // Navigasi ke halaman tambah experience
            onTap: () {  
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ExperienceFormPage()));   
            },
          ),
        ],
      ),
    );
  }
}