import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorage {
  final supabaseClient = Supabase.instance.client;

  Future<String> saveImage(File imageFile, String folder) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    await supabaseClient.storage
        .from('images')
        .upload('$folder/$fileName', imageFile);
    final imageUrl = supabaseClient.storage
        .from('images')
        .getPublicUrl('$folder/$fileName');
    return imageUrl;
  }
}
