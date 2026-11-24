import 'package:material_ui/material_ui.dart';
import '../screens/menu.dart';
import '../screens/project_form.dart';
import '../screens/experience_form.dart';
import '../services/auth_state.dart';
import 'auth_guard.dart'; 
import 'package:provider/provider.dart';

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
        onTap: () async {
          final messenger = ScaffoldMessenger.of(context);

          showInfoSnack(context, "You have pressed a button named ${item.name}!");
          if (item.name == "Add Project") {
            final ok = await ensureLoggedIn(context);
            if (!ok || !context.mounted) return;
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProjectFormPage()));
          }
          else if (item.name == "Add Experience") {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ExperienceFormPage()));
          }
          else if (item.name == "Logout") {
            final auth = context.read<AuthState>();
            if (!auth.isLoggedIn) {
              messenger.showSnackBar(
                const SnackBar(content: Text('You are not logged in.')),
              );
              return;
            }
            await auth.logout();
            messenger.showSnackBar(
              const SnackBar(content: Text('You have been logged out.')),
            );
          }
        },
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