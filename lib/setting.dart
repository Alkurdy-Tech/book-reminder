import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database/app_database.dart';
import 'auth/auth_service.dart';
import 'auth/login_screen.dart';
import 'main.dart'; // for themeNotifier

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String userName = "Reader";
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final session = await AppDatabase.instance.getSavedSession();
    setState(() {
      userName = session?['name'] ?? "Reader";
      isDarkMode = themeNotifier.value == ThemeMode.dark;
    });
  }

  Future<void> _toggleDarkMode(bool value) async {
    setState(() { isDarkMode = value; });
    themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
    await AppDatabase.instance.saveTheme(value ? 'dark' : 'light');
  }

  Future<void> _logout() async {
    await AuthService().signOut();
    await AppDatabase.instance.clearSession();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
        (route) => false, // clears the navigation stack so user can't go "back" into the app
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          // ---------- 1. USER NAME ----------
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.deepOrange,
                  child: Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : "?",
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  userName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Divider(),

          // ---------- 2. DARK MODE TOGGLE ----------
          SwitchListTile(
            title: Text("Dark Mode"),
            secondary: Icon(Icons.dark_mode_outlined),
            value: isDarkMode,
            onChanged: _toggleDarkMode,
            activeColor: Colors.deepOrange,
          ),

          Divider(),

          // ---------- 3. SUPPORT EMAIL ----------
          ListTile(
            leading: Icon(Icons.support_agent_outlined),
            title: Text("Support"),
            subtitle: Text("islamsndy1@gmail.com"), // <-- replace with your actual support email
            onTap: () {
              Clipboard.setData(ClipboardData(text: "islamsndy1@gmail.com"));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Email copied to clipboard")),
              );
            },
          ),

          Divider(),

          // ---------- 4. LOGOUT ----------
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Log out?"),
                  content: Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _logout();
                      },
                      child: Text("Log out", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}