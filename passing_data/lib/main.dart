import 'package:flutter/material.dart';

void main() => runApp(const CoffeeApp());

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.brown[50],
      ),
      home: const HomeScreen(),
    );
  }
}

class Coffee {
  final String name;
  final String description;
  final double price;
  final String location;
  final String imagePath;

  const Coffee({
    required this.name,
    required this.description,
    required this.price,
    required this.location,
    required this.imagePath,
  });
}

const List<Coffee> coffees = [
  Coffee(
    name: '☕ قهوة عربية',
    description: 'قهوة تقليدية مع الهيل والزعفران.',
    price: 12.99,
    location: 'المقهى العربي - وسط البلد',
    imagePath: 'assets/images/coffee1.jpg',
  ),
  Coffee(
    name: '🥛 لاتيه',
    description: 'إسبريسو مع حليب مبخر ورغوة.',
    price: 15.50,
    location: 'ستاربكس - شارع المعارض',
    imagePath: 'assets/images/coffee2.jpg',
  ),
  Coffee(
    name: '🍫 موكا',
    description: 'إسبريسو مع شوكولاتة وحليب.',
    price: 16.75,
    location: 'كافيه تشي - المجمع التجاري',
    imagePath: 'assets/images/coffee3.jpg',
  ),
  Coffee(
    name: '🇮🇹 إسبرسو',
    description: 'قهوة إيطاليّة قويّة ومركّزة.',
    price: 10.00,
    location: 'كافيه روما - كورنيش النيل',
    imagePath: 'assets/images/coffee4.jpg',
  ),
  Coffee(
    name: '🌿 قهوة تركية',
    description: 'قهوة تركية أصيلة مع رغوة خفيفة.',
    price: 14.00,
    location: 'المقهى التركي - شارع المتنبي',
    imagePath: 'assets/images/coffee5.jpg',
  ),
  Coffee(
    name: '🍯 كابتشينو',
    description: 'إسبريسو مع رغوة الحليب الكثيفة.',
    price: 13.50,
    location: 'كافيه مودرن - وسط البلد',
    imagePath: 'assets/images/coffee6.jpg',
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _navigateToDetail(Coffee coffee) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => DetailsScreen(coffee: coffee)),
    );

    if (result != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.brown[800],
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '☕ قائمة القهوة',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[800],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown[50]!, Colors.brown[100]!],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75, // ✅ أفضل تناسق
          ),
          itemCount: coffees.length,
          itemBuilder: (context, index) {
            final coffee = coffees[index];

            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () => _navigateToDetail(coffee),
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: [
                    // 🔥 الصورة تملأ الكارد
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.asset(
                          coffee.imagePath,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.brown[200],
                            child: const Icon(Icons.broken_image, size: 40),
                          ),
                        ),
                      ),
                    ),

                    // النص
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coffee.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${coffee.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Coffee coffee;
  const DetailsScreen({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coffee.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown[800],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown[50]!, Colors.brown[100]!],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 280,
                width: double.infinity,
                color: Colors.brown[100],
                child: Image.asset(
                  coffee.imagePath,
                  fit: BoxFit.cover, // 🔥 تم التعديل هنا أيضًا
                  width: double.infinity,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffee.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.brown,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            coffee.location,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'السعر: \$${coffee.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.brown),
                    const SizedBox(height: 14),
                    const Text(
                      '📝 الوصف:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      coffee.description,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 35),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            '✅ تم إضافة ${coffee.name} إلى المفضلة',
                          );
                        },
                        icon: const Icon(Icons.favorite, size: 18),
                        label: const Text('إضافة إلى المفضلة'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
