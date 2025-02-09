import 'package:ai_assistent/Helper/global.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Status{none, loading, complete}

class ImageController extends GetxController{
  final textC = TextEditingController();
  final status = Status.none.obs;
  String url = '';
   Future<void> createImage() async{

     //OpenAI.apiKey = apiKey;
     String api_image = 'https://image.pollinations.ai/prompt/';
     if(textC.text.trim().isNotEmpty){
       status.value = Status.loading;
       OpenAIImageModel image = await OpenAI.instance.image.create(prompt:
       textC.text, n: 1, size: OpenAIImageSize.size512,
       responseFormat: OpenAIImageResponseFormat.url);
       url = image.data[0].url.toString();
       //textC.text ='';
       status.value = Status.complete;
     }
   }
}
