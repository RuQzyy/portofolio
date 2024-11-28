import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/Animation.json',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text(
          'Portofolio',
          style: TextStyle(color: Colors.white),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Muhammad Al-faruq'),
              accountEmail: const Text('Muhammadfaruq096@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/profil.jpg',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.cyan,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background.jpg'),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('WhatsApp'),
              onTap: () async {
                final Uri url = Uri.parse('whatsapp://send?phone=6281343039368');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  final Uri fallbackUrl = Uri.parse('https://wa.me/6281343039368');
                  if (await canLaunchUrl(fallbackUrl)) {
                    await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
                  } else {
                    throw 'Could not launch $url';
                  }
                }
              },
            ),
         ListTile(
  leading: const Icon(Icons.camera_alt),
  title: const Text('Instagram'),
  onTap: () async {
    final Uri appUrl = Uri.parse('instagram://user?username=1yaxxa_'); // Periksa URI scheme yang sesuai
    final Uri webUrl = Uri.parse('https://www.instagram.com/1yaxxa_/'); // Hapus spasi tambahan
    if (await canLaunchUrl(appUrl)) {
      await launchUrl(appUrl, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(webUrl)) {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Instagram app or web URL: $appUrl / $webUrl';
    }
  },
),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Apakah anda yakin akan keluar?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            SystemNavigator.pop(); // Tutup aplikasi
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.cyan,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/profil.jpg',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Hello, Saya Muhammad Al-Faruq',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Saya mahasiswa Sistem Informasi dengan keahlian dalam berbagai bahasa pemrograman. Berikut adalah beberapa skill saya:',
                    textStyle: const TextStyle(fontSize: 16),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
              const SizedBox(height: 16),
              const Text(
                'Languages',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: portofolio.length,
                  itemBuilder: (context, index) {
                    final item = portofolio[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      item['image']!,
                                      height: 150,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      item['title']!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      item['description']!,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn(duration: 500.ms).scale(),
                            );
                          },
                        );
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: Image.asset(
                                  item['image']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item['title']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().scale(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, String>> portofolio = [
  {
    'title': 'Dart',
    'image': 'assets/dart.jpg',
    'description': 'Menguasai Dart, bahasa di balik Flutter untuk aplikasi multiplatform.',
  },
  {
    'title': 'Python',
    'image': 'assets/python.jpg',
    'description': 'Pengalaman Python untuk pengolahan data, automasi, dan back-end.',
  },
  {
    'title': 'Java',
    'image': 'assets/java.jpg',
    'description': 'Menggunakan Java untuk pengembangan aplikasi Android.',
  },
  {
    'title': 'CSS',
    'image': 'assets/css.jpg',
    'description': 'Mahir dalam CSS untuk antarmuka web yang menarik dan responsif.',
  },
];
