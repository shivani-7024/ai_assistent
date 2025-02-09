import 'package:ai_assistent/Screens/feature/ai_image_feature.dart';
import 'package:ai_assistent/Screens/feature/chatbot_feature.dart';
import 'package:ai_assistent/Screens/feature/language_translator_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

enum HomeType{aiChatBot, aiImage, aiTranslator}

extension MyHomeType on HomeType{
  String get title => switch(this){
    HomeType.aiChatBot => "Ai Chat Bot",
    HomeType.aiImage => "Ai Image Generator",
    HomeType.aiTranslator => "Language Translator"
  };

  String get lottie => switch(this){
    HomeType.aiChatBot => "ai_chat.json",
    HomeType.aiImage => "ai_play.json",
    HomeType.aiTranslator => "ai_ask.json",
  };
  bool get leftAlign => switch(this){

    HomeType.aiChatBot => true,
    HomeType.aiImage => false,
    HomeType.aiTranslator => true,
  };
  VoidCallback get onTap => switch(this){
    HomeType.aiChatBot => () => Get.to(()=>ChatbotFeature()),
    HomeType.aiImage => () => Get.to(()=>AiImageFeature()),
    HomeType.aiTranslator => () => Get.to(()=>LanguageTranslatorFeature())
  };
}