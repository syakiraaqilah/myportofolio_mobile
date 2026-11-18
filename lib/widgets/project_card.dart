import 'package:material_ui/material_ui.dart';
import '../screens/menu.dart';
import '../screens/project_form.dart';

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
        onTap: () {
          showInfoSnack(context, "You have pressed a button named ${item.name}!");
          if (item.name == "Add Project") {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProjectFormPage()));
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