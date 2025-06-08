import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/domain/service/storage_key/storage_key_service.dart';
import 'package:sola/presentation/UI/config/theme.dart';
import 'package:sola/presentation/UI/features/qr/qr_scan_page.dart';
import 'package:sola/presentation/UI/widgets/bottomnav.dart';
import 'package:sola/presentation/providers_services/home/daily_statistic_list_provider.dart';
import 'package:sola/presentation/providers_services/settings/export_service.dart';
import 'package:sola/presentation/providers_services/settings/import_service.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaff,
      appBar: AppBar(
        title: Text("Paramètres"),
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsSection(
            title: "Données",
            items: [
              _SettingsTile(
                icon: Icons.upload_file,
                color: Colors.indigo,
                title: "Exporter les données",
                subtitle: "Sauvegarder vos données localement",
                onTap: () async {
                  try {
                    final exportService = Provider.of<ExportUIService>(context, listen: false);
                    await exportService.export();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Exportation réussie")),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Erreur d'export : $e")),
                    );
                  }
                }

              ),
              _SettingsTile(
                icon: Icons.download,
                color: Colors.deepPurple,
                title: "Importer les données",
                subtitle: "Restaurer depuis un fichier",
                onTap: () async {
                  try {
                    final importService = Provider.of<ImportUIService>(context, listen: false);

                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['txt','json'],
                      allowMultiple: false,
                    );

                    if (result != null && result.files.single.path != null) {
                      final file = File(result.files.single.path!);
                      await importService.importFromFile(file,context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Importation réussie")),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Erreur d'import : $e")),
                    );
                  }
                },


              ),
              _SettingsTile(
                icon: Icons.system_update,
                color: Colors.green,
                title: "Vérification de mise à jour",
                subtitle: "S'assurer la coherence des données",
                onTap: () {
                    Provider.of<DailyStatisticListProvider>(context, listen: false).updateVerification();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Vérification en cours...")),
                    );
                  },
              ),

            ],
          ),
          const SizedBox(height: 20),
          _SettingsSection(
            title: "Clés",
            items: [
              _SettingsTile(
                icon: Icons.notifications_active,
                color: Colors.orange,
                title: "Clés d'exportation",
                subtitle: "Obtenir la clé d'exportation",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScannerPage(
                        onScan: (data) async {
                          await StorageKeyService.saveSecretKey(data);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Clé enregistrée avec succès")),
                          );
                        },
                      ),
                    ),
                  );
                },

              ),

            ],
          ),
          const SizedBox(height: 20),
          _SettingsSection(
            title: "Autres",
            items: [
              _SettingsTile(
                icon: Icons.info_outline,
                color: Colors.grey,
                title: "À propos",
                subtitle: "Version, crédits, etc.",
                onTap: () {
                  // About page
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Bottomnav(currentIndex: 2),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _SettingsSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppTheme.darkPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...items,
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.cardColor,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: const Color.fromARGB(156, 0, 0, 0))),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[600]),
        onTap: onTap,
      ),
    );
  }
}
