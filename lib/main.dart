import 'package:flutter/material.dart';

void main() {
  runApp(const PrivateConnectApp());
}

const Color bg = Color(0xFF050907);
const Color panel = Color(0xFF111814);
const Color green = Color(0xFF00E676);
const Color muted = Color(0xFF9AA69F);

class PrivateConnectApp extends StatelessWidget {
  const PrivateConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Private Connect PRO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: green,
          surface: panel,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;

  final List<String> tabs = [
    'Home',
    'Call',
    'Pair Device',
    'Settings',
  ];

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.call_rounded,
    Icons.shield_rounded,
    Icons.settings_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedTab,
          children: [
            homePage(),
            callPage(),
            pairPage(),
            settingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF080D0A),
        indicatorColor: const Color(0xFF073D22),
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          setState(() => selectedTab = index);
        },
        destinations: List.generate(
          tabs.length,
          (index) => NavigationDestination(
            icon: Icon(icons[index]),
            label: tabs[index],
          ),
        ),
      ),
    );
  }

  Widget homePage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Icon(
                Icons.shield_moon_rounded,
                color: green,
                size: 45,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Private Connect PRO',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Chat • Call • Stay Private',
                      style: TextStyle(color: muted),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => showInfo(
                  'Notifications',
                  'Notification service will be added later.',
                ),
                icon: const Icon(Icons.notifications_none),
              ),
            ],
          ),
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF062216),
            border: Border.all(color: green.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: green,
                size: 42,
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Private Connection',
                      style: TextStyle(
                        color: green,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Pair your second device',
                      style: TextStyle(color: muted),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => setState(() => selectedTab = 2),
                icon: const Icon(
                  Icons.phonelink,
                  color: green,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              tabButton('Messages', Icons.message, 0),
              const SizedBox(width: 8),
              tabButton('Calls', Icons.call, 1),
              const SizedBox(width: 8),
              tabButton('Settings', Icons.settings, 3),
            ],
          ),
        ),

        const SizedBox(height: 15),

        Expanded(
          child: ListView(
            children: [
              chatTile(
                Icons.person,
                'Private Partner',
                'Your private chat will appear here',
                '—',
              ),
              chatTile(
                Icons.lock,
                'Private Messages',
                'Messages are only for paired devices',
                '—',
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Your private space',
                  style: TextStyle(color: muted),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tabButton(String title, IconData icon, int index) {
    final bool active = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: active ? green : panel,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: active ? Colors.black : muted,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: active ? Colors.black : muted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatTile(
    IconData icon,
    String title,
    String subtitle,
    String time,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      leading: CircleAvatar(
        radius: 27,
        backgroundColor: const Color(0xFF073D22),
        child: Icon(icon, color: green, size: 27),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: muted),
      ),
      trailing: Text(
        time,
        style: const TextStyle(color: muted),
      ),
      onTap: () => showInfo(
        title,
        'Messaging will be connected to Firebase in the next step.',
      ),
    );
  }

  Widget callPage() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.call, color: green, size: 70),
          const SizedBox(height: 20),
          const Text(
            'Private Audio Call',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Audio calling will be enabled with WebRTC.',
            style: TextStyle(color: muted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            onPressed: () => showInfo(
              'Audio Call',
              'WebRTC calling will be added in a later build.',
            ),
            icon: const Icon(Icons.call),
            label: const Text('Start Call'),
          ),
        ],
      ),
    );
  }

  Widget pairPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.phonelink_lock,
              color: green,
              size: 75,
            ),
            const SizedBox(height: 20),
            const Text(
              'Pair Your Device',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Connect your second phone using a private pairing code.',
              textAlign: TextAlign.center,
              style: TextStyle(color: muted),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => showInfo(
                'Pair Device',
                'Pairing codes will be connected to Firebase later.',
              ),
              child: const Text('Create Pairing Code'),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingsPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Settings',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const ListTile(
          leading: Icon(Icons.lock, color: green),
          title: Text('Basic Security'),
          subtitle: Text('Password and device access'),
        ),
        const ListTile(
          leading: Icon(Icons.dark_mode, color: green),
          title: Text('Dark Theme'),
          subtitle: Text('Enabled'),
        ),
        const ListTile(
          leading: Icon(Icons.info_outline, color: green),
          title: Text('About'),
          subtitle: Text('Private Connect PRO'),
        ),
      ],
    );
  }

  void showInfo(String title, String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: panel,
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
