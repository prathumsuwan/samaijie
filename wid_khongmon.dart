import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:khongmongkol/screen/item_screen.dart';
import 'package:khongmongkol/screen/map/map1.dart';
import 'package:khongmongkol/screen/map/map2.dart';
import 'package:khongmongkol/screen/map/map3.dart';

class WidKhongmon extends StatelessWidget {
  final Item item;
  final String day;

  const WidKhongmon({Key? key, required this.item, required this.day})
      : super(key: key);

  // ฟังก์ชันเปิดแผนที่
  void _openMapScreen1(BuildContext context, String map_ad1) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MapScreen1(map_ad1: map_ad1), // ส่ง map_ad ที่ถูกต้อง
      ),
    );
  }

  void _openMapScreen2(BuildContext context, String map_ad2) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MapScreen2(map_ad2: map_ad2), // ส่ง map_ad ที่ถูกต้อง
      ),
    );
  }

  void _openMapScreen3(BuildContext context, String map_ad3) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MapScreen3(map_ad3: map_ad3), // ส่ง map_ad ที่ถูกต้อง
      ),
    );
  }

  // Reusable method to create image and text rows with a map button
  Widget buildImageTextRow(String imagePath, String text, String map_ad1,
      String map_ad2, String map_ad3) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Builder(
                builder: (BuildContext newContext) {
                  return SizedBox(
                    width: double.infinity, // ขยายปุ่มให้เต็มความกว้าง
                    child: ElevatedButton(
                      onPressed: () {
                        if (map_ad1.isNotEmpty) {
                          _openMapScreen1(newContext, map_ad1);
                        } else if (map_ad2.isNotEmpty) {
                          _openMapScreen2(newContext, map_ad2);
                        } else if (map_ad3.isNotEmpty) {
                          _openMapScreen3(newContext, map_ad3);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 229, 229, 229), // สีพื้นหลังของปุ่ม
                        padding: const EdgeInsets.symmetric(
                            vertical: 12), // เพิ่มความสูงปุ่ม
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // ขอบปุ่มโค้งมน
                        ),
                      ),
                      child: const Text(
                        "ดูแผนที่",
                        style: TextStyle(
                          color: Color.fromARGB(
                              255, 0, 0, 0), // สีของข้อความในปุ่ม
                          fontSize: 18, // ขนาดข้อความในปุ่ม
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'วัตถุมงคล',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: _buildBodyContent(),
    );
  }

  Widget _buildBodyContent() {
    List<Item> filteredItems = itemData
        .where((item) =>
            (item.cateogory == 'thing1' ||
                item.cateogory == 'thing2' ||
                item.cateogory == 'thing3') &&
            item.day == day)
        .toList();

    List<Widget> thingWidgets = filteredItems.map((filteredItem) {
      return _buildThingContent(
        filteredItem.name,
        filteredItem.picture,
        filteredItem.details,
        filteredItem.address1,
        filteredItem.address2,
        filteredItem.address3,
        filteredItem.map_ad1,
        filteredItem.map_ad2,
        filteredItem.map_ad3,
      );
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/wallpaper.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  children: thingWidgets,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThingContent(
      String name,
      String imagePath,
      String details,
      String address1,
      String address2,
      String address3,
      String map_ad1,
      String map_ad2,
      String map_ad3) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF000000),
            Color(0xFF737373),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),

          // แสดงชื่อ item
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            details,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // ที่อยู่แรกพร้อมลิงค์แผนที่
          buildImageTextRow(imagePath, address1, map_ad1, map_ad2, map_ad3),
          const SizedBox(height: 16),

          if (address2.isNotEmpty) ...[
            buildImageTextRow(imagePath, address2, map_ad1, map_ad2, map_ad3),
            const SizedBox(height: 16),
          ],
          if (address3.isNotEmpty) ...[
            buildImageTextRow(imagePath, address3, map_ad1, map_ad2, map_ad3),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
