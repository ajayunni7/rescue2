import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resq/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FirstAidController extends GetxController {
  final supabase = Supabase.instance.client;
  var items = <Map<String, dynamic>>[].obs;
  var selectedItems = <String>{}.obs;

  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }

  Future<void> fetchItems() async {
    try {
      final response = await supabase.from('first_aid_items').select();
      print("📢 Raw Response from Supabase: $response");

      if (response != null && response.isNotEmpty) {
        items.assignAll(List<Map<String, dynamic>>.from(response));
        print("✅ Items fetched: ${items.length} items loaded.");
      } else {
        print("⚠️ No items found in the database.");
      }
    } catch (e) {
      print("❌ Error fetching items: $e");
    }
  }

  void toggleSelection(String itemId) {
    if (selectedItems.contains(itemId)) {
      selectedItems.remove(itemId);
      print("Item deselected: $itemId");
    } else {
      selectedItems.add(itemId);
      print("Item selected: $itemId");
    }
  }

  Future<void> saveSelection() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      print("Error: No logged-in user.");
      return;
    }

    print("Saving selected items for user: ${user.id}");
    print("Selected items: ${selectedItems.toList()}");

    try {
      await supabase.from('user_selected_items').upsert(
            selectedItems
                .map((id) => {'user_id': user.id, 'item_id': id})
                .toList(),
          );

      print("✅ Selection saved successfully.");
      Get.snackbar('Success', 'Your selections have been saved!');
    } catch (e) {
      print("❌ Error saving selections: $e");
      Get.snackbar('Error', 'Failed to save selections.');
    }
  }
}

class FirstAidPage extends StatelessWidget {
  final FirstAidController controller = Get.put(FirstAidController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Select First Aid Items",
            style: AppTextStyles.headlineLargeBlack,
          ),
        ),
      ),
      body: Obx(
        () => GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
          ),
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            final item = controller.items[index];
            final isSelected =
                controller.selectedItems.contains(item['id'].toString());

            return GestureDetector(
              onTap: () {
                print("Tapped on item: ${item['name']} (ID: ${item['id']})");
                controller.toggleSelection(item['id'].toString());
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: isSelected ? Colors.green : Colors.grey),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        item['image_url'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print("Error loading image: ${item['image_url']}");
                          return Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        item['name'],
                        style: AppTextStyles.bodyLargeBlack,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Floating action button pressed, saving selection...");
          controller.saveSelection();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
