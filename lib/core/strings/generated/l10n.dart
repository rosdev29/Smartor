// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `View DOCX`
  String get view_docx {
    return Intl.message('View DOCX', name: 'view_docx', desc: '', args: []);
  }

  /// `Invalid data! Please enter only numbers (0-9) and special characters: . - Space`
  String get error_code93 {
    return Intl.message(
      'Invalid data! Please enter only numbers (0-9) and special characters: . - Space',
      name: 'error_code93',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter only letters (A-Z, a-z), numbers (0-9), and special characters: ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ '{ | }~`
  String get error_code128 {
    return Intl.message(
      'Invalid data! Please enter only letters (A-Z, a-z), numbers (0-9), and special characters: ! " # \$ % & \' ( ) * + , - . / : ; < = > ? @ [ \\ ] ^ _ `{ | }~',
      name: 'error_code128',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter only numbers (0-9) and special characters: . - Space`
  String get error_code_39 {
    return Intl.message(
      'Invalid data! Please enter only numbers (0-9) and special characters: . - Space',
      name: 'error_code_39',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter only digits (0-9) and valid GS1-128 Application Identifiers.`
  String get error_gs_128 {
    return Intl.message(
      'Invalid data! Please enter only digits (0-9) and valid GS1-128 Application Identifiers.',
      name: 'error_gs_128',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter only an even number of digits (0-9).`
  String get error_itf {
    return Intl.message(
      'Invalid data! Please enter only an even number of digits (0-9).',
      name: 'error_itf',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter exactly 14 digits (0-9).`
  String get error_code_itf_14 {
    return Intl.message(
      'Invalid data! Please enter exactly 14 digits (0-9).',
      name: 'error_code_itf_14',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter exactly 16 digits (0-9).`
  String get error_code_itf_16 {
    return Intl.message(
      'Invalid data! Please enter exactly 16 digits (0-9).',
      name: 'error_code_itf_16',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter exactly 13 digits (0-9).`
  String get error_code_ean_13 {
    return Intl.message(
      'Invalid data! Please enter exactly 13 digits (0-9).',
      name: 'error_code_ean_13',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter exactly 8 digits (0-9).`
  String get error_code_ean_8 {
    return Intl.message(
      'Invalid data! Please enter exactly 8 digits (0-9).',
      name: 'error_code_ean_8',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter exactly 5 digits (0-9).`
  String get error_code_ean_5 {
    return Intl.message(
      'Invalid data! Please enter exactly 5 digits (0-9).',
      name: 'error_code_ean_5',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter exactly 2 digits (0-9).`
  String get error_code_ean_2 {
    return Intl.message(
      'Invalid data! Please enter exactly 2 digits (0-9).',
      name: 'error_code_ean_2',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter a valid ISBN-10 or ISBN-13 number.`
  String get error_code_isbn {
    return Intl.message(
      'Invalid data! Please enter a valid ISBN-10 or ISBN-13 number.',
      name: 'error_code_isbn',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter exactly 12 digits (0-9).`
  String get error_code_upca {
    return Intl.message(
      'Invalid data! Please enter exactly 12 digits (0-9).',
      name: 'error_code_upca',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter exactly 6 or 8 digits (0-9).`
  String get error_code_upce {
    return Intl.message(
      'Invalid data! Please enter exactly 6 or 8 digits (0-9).',
      name: 'error_code_upce',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter only ASCII characters (0-127).`
  String get error_telepen {
    return Intl.message(
      'Invalid data! Please enter only ASCII characters (0-127).',
      name: 'error_telepen',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter only digits (0-9) and special characters: - . $ / + :`
  String get error_codabar {
    return Intl.message(
      'Invalid data! Please enter only digits (0-9) and special characters: - . \$ / + :',
      name: 'error_codabar',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter only letters (A-Z) and numbers (0-9).`
  String get error_rm4scc {
    return Intl.message(
      'Invalid data! Please enter only letters (A-Z) and numbers (0-9).',
      name: 'error_rm4scc',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data! Please enter only 5, 6, 9, or 11 digits (0-9).`
  String get error_postnet {
    return Intl.message(
      'Invalid data! Please enter only 5, 6, 9, or 11 digits (0-9).',
      name: 'error_postnet',
      desc: '',
      args: [],
    );
  }

  /// `Barcode`
  String get barcode {
    return Intl.message('Barcode', name: 'barcode', desc: '', args: []);
  }

  /// `Barcode Type`
  String get barcode_type {
    return Intl.message(
      'Barcode Type',
      name: 'barcode_type',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Image saved successfully`
  String get image_saved_successfully {
    return Intl.message(
      'Image saved successfully',
      name: 'image_saved_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save image`
  String get failed_to_save_image {
    return Intl.message(
      'Failed to save image',
      name: 'failed_to_save_image',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `A QR Code (Quick Response Code) is a 2D barcode that stores data like text, URLs, and contact info. It can be scanned by a phone camera for quick access and is widely used in payments, logins, and information sharing.`
  String get qr_gen_message {
    return Intl.message(
      'A QR Code (Quick Response Code) is a 2D barcode that stores data like text, URLs, and contact info. It can be scanned by a phone camera for quick access and is widely used in payments, logins, and information sharing.',
      name: 'qr_gen_message',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get generate {
    return Intl.message('Generate', name: 'generate', desc: '', args: []);
  }

  /// `Text`
  String get text {
    return Intl.message('Text', name: 'text', desc: '', args: []);
  }

  /// `QR Gen`
  String get qr_gen {
    return Intl.message('QR Gen', name: 'qr_gen', desc: '', args: []);
  }

  /// `Please select a PDF file to continue.`
  String get view_pdf_message {
    return Intl.message(
      'Please select a PDF file to continue.',
      name: 'view_pdf_message',
      desc: '',
      args: [],
    );
  }

  /// `Please select a DOCX file to continue.`
  String get view_docx_message {
    return Intl.message(
      'Please select a DOCX file to continue.',
      name: 'view_docx_message',
      desc: '',
      args: [],
    );
  }

  /// `View PDF`
  String get view_pdf {
    return Intl.message('View PDF', name: 'view_pdf', desc: '', args: []);
  }

  /// `Copied`
  String get copied {
    return Intl.message('Copied', name: 'copied', desc: '', args: []);
  }

  /// `Ensure a clear photo for accurate results.`
  String get camera_message {
    return Intl.message(
      'Ensure a clear photo for accurate results.',
      name: 'camera_message',
      desc: '',
      args: [],
    );
  }

  /// `Translate`
  String get translate {
    return Intl.message('Translate', name: 'translate', desc: '', args: []);
  }

  /// `QR Scanner`
  String get qr_scanner {
    return Intl.message('QR Scanner', name: 'qr_scanner', desc: '', args: []);
  }

  /// `Scan your QR code and barcode`
  String get qr_scanner_content {
    return Intl.message(
      'Scan your QR code and barcode',
      name: 'qr_scanner_content',
      desc: '',
      args: [],
    );
  }

  /// `You have received one free use of the feature.`
  String get you_have_received_one_free_use_of_the_feature {
    return Intl.message(
      'You have received one free use of the feature.',
      name: 'you_have_received_one_free_use_of_the_feature',
      desc: '',
      args: [],
    );
  }

  /// `Invalid`
  String get invalid {
    return Intl.message('Invalid', name: 'invalid', desc: '', args: []);
  }

  /// `Cannot open the camera.`
  String get open_camera_failed {
    return Intl.message(
      'Cannot open the camera.',
      name: 'open_camera_failed',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `English`
  String get EN_US {
    return Intl.message('English', name: 'EN_US', desc: '', args: []);
  }

  /// `Vietnamese`
  String get VI_VN {
    return Intl.message('Vietnamese', name: 'VI_VN', desc: '', args: []);
  }

  /// `Japanese`
  String get JA_JP {
    return Intl.message('Japanese', name: 'JA_JP', desc: '', args: []);
  }

  /// `Finnish `
  String get FI_FI {
    return Intl.message('Finnish ', name: 'FI_FI', desc: '', args: []);
  }

  /// `Korean`
  String get KO_KR {
    return Intl.message('Korean', name: 'KO_KR', desc: '', args: []);
  }

  /// `French`
  String get FR_FR {
    return Intl.message('French', name: 'FR_FR', desc: '', args: []);
  }

  /// `Thai`
  String get TH_TH {
    return Intl.message('Thai', name: 'TH_TH', desc: '', args: []);
  }

  /// `Chinese`
  String get ZH_CN {
    return Intl.message('Chinese', name: 'ZH_CN', desc: '', args: []);
  }

  /// `Afrikaans`
  String get AF_ZA {
    return Intl.message('Afrikaans', name: 'AF_ZA', desc: '', args: []);
  }

  /// `Arabic`
  String get AR_XA {
    return Intl.message('Arabic', name: 'AR_XA', desc: '', args: []);
  }

  /// `Basque`
  String get EU_ES {
    return Intl.message('Basque', name: 'EU_ES', desc: '', args: []);
  }

  /// `Bengali`
  String get BN_IN {
    return Intl.message('Bengali', name: 'BN_IN', desc: '', args: []);
  }

  /// `Bulgarian`
  String get BG_BG {
    return Intl.message('Bulgarian', name: 'BG_BG', desc: '', args: []);
  }

  /// `Catalan`
  String get CA_ES {
    return Intl.message('Catalan', name: 'CA_ES', desc: '', args: []);
  }

  /// `Czech`
  String get CS_CZ {
    return Intl.message('Czech', name: 'CS_CZ', desc: '', args: []);
  }

  /// `Danish`
  String get DA_DK {
    return Intl.message('Danish', name: 'DA_DK', desc: '', args: []);
  }

  /// `Dutch`
  String get NL_NL {
    return Intl.message('Dutch', name: 'NL_NL', desc: '', args: []);
  }

  /// `Filipino`
  String get FIL_PH {
    return Intl.message('Filipino', name: 'FIL_PH', desc: '', args: []);
  }

  /// `German`
  String get DE_DE {
    return Intl.message('German', name: 'DE_DE', desc: '', args: []);
  }

  /// `Greek`
  String get EL_GR {
    return Intl.message('Greek', name: 'EL_GR', desc: '', args: []);
  }

  /// `Hebrew`
  String get HE_IL {
    return Intl.message('Hebrew', name: 'HE_IL', desc: '', args: []);
  }

  /// `Hindi`
  String get HI_IN {
    return Intl.message('Hindi', name: 'HI_IN', desc: '', args: []);
  }

  /// `Hungarian`
  String get HU_HU {
    return Intl.message('Hungarian', name: 'HU_HU', desc: '', args: []);
  }

  /// `Icelandic`
  String get IS_IS {
    return Intl.message('Icelandic', name: 'IS_IS', desc: '', args: []);
  }

  /// `Indonesian`
  String get ID_ID {
    return Intl.message('Indonesian', name: 'ID_ID', desc: '', args: []);
  }

  /// `Italian`
  String get IT_IT {
    return Intl.message('Italian', name: 'IT_IT', desc: '', args: []);
  }

  /// `Latvian`
  String get LV_LV {
    return Intl.message('Latvian', name: 'LV_LV', desc: '', args: []);
  }

  /// `Lithuanian`
  String get LT_LT {
    return Intl.message('Lithuanian', name: 'LT_LT', desc: '', args: []);
  }

  /// `Malay`
  String get MS_MY {
    return Intl.message('Malay', name: 'MS_MY', desc: '', args: []);
  }

  /// `Norwegian`
  String get NB_NO {
    return Intl.message('Norwegian', name: 'NB_NO', desc: '', args: []);
  }

  /// `Polish`
  String get PL_PL {
    return Intl.message('Polish', name: 'PL_PL', desc: '', args: []);
  }

  /// `Portuguese`
  String get PT_PT {
    return Intl.message('Portuguese', name: 'PT_PT', desc: '', args: []);
  }

  /// `Romanian`
  String get RO_RO {
    return Intl.message('Romanian', name: 'RO_RO', desc: '', args: []);
  }

  /// `Russian`
  String get RU_RU {
    return Intl.message('Russian', name: 'RU_RU', desc: '', args: []);
  }

  /// `Slovak`
  String get SK_SK {
    return Intl.message('Slovak', name: 'SK_SK', desc: '', args: []);
  }

  /// `Spanish`
  String get ES_ES {
    return Intl.message('Spanish', name: 'ES_ES', desc: '', args: []);
  }

  /// `Swedish`
  String get SV_SE {
    return Intl.message('Swedish', name: 'SV_SE', desc: '', args: []);
  }

  /// `Tamil`
  String get TA_IN {
    return Intl.message('Tamil', name: 'TA_IN', desc: '', args: []);
  }

  /// `Telugu`
  String get TE_IN {
    return Intl.message('Telugu', name: 'TE_IN', desc: '', args: []);
  }

  /// `Turkish`
  String get TR_TR {
    return Intl.message('Turkish', name: 'TR_TR', desc: '', args: []);
  }

  /// `Ukrainian`
  String get UK_UA {
    return Intl.message('Ukrainian', name: 'UK_UA', desc: '', args: []);
  }

  /// `Canada`
  String get CA {
    return Intl.message('Canada', name: 'CA', desc: '', args: []);
  }

  /// `Hong Kong`
  String get HK {
    return Intl.message('Hong Kong', name: 'HK', desc: '', args: []);
  }

  /// `Australia`
  String get AU {
    return Intl.message('Australia', name: 'AU', desc: '', args: []);
  }

  /// `Ukraine`
  String get UA {
    return Intl.message('Ukraine', name: 'UA', desc: '', args: []);
  }

  /// `Turkey`
  String get TR {
    return Intl.message('Turkey', name: 'TR', desc: '', args: []);
  }

  /// `Sweden`
  String get SE {
    return Intl.message('Sweden', name: 'SE', desc: '', args: []);
  }

  /// `Slovakia`
  String get SK {
    return Intl.message('Slovakia', name: 'SK', desc: '', args: []);
  }

  /// `Russia`
  String get RU {
    return Intl.message('Russia', name: 'RU', desc: '', args: []);
  }

  /// `Romania`
  String get RO {
    return Intl.message('Romania', name: 'RO', desc: '', args: []);
  }

  /// `Portugal`
  String get PT {
    return Intl.message('Portugal', name: 'PT', desc: '', args: []);
  }

  /// `Poland`
  String get PL {
    return Intl.message('Poland', name: 'PL', desc: '', args: []);
  }

  /// `Norway`
  String get NO {
    return Intl.message('Norway', name: 'NO', desc: '', args: []);
  }

  /// `Malaysia`
  String get MY {
    return Intl.message('Malaysia', name: 'MY', desc: '', args: []);
  }

  /// `Lithuania`
  String get LT {
    return Intl.message('Lithuania', name: 'LT', desc: '', args: []);
  }

  /// `Latvia`
  String get LV {
    return Intl.message('Latvia', name: 'LV', desc: '', args: []);
  }

  /// `Italy`
  String get IT {
    return Intl.message('Italy', name: 'IT', desc: '', args: []);
  }

  /// `Iceland`
  String get IS {
    return Intl.message('Iceland', name: 'IS', desc: '', args: []);
  }

  /// `Indonesia`
  String get ID {
    return Intl.message('Indonesia', name: 'ID', desc: '', args: []);
  }

  /// `Hungary`
  String get HU {
    return Intl.message('Hungary', name: 'HU', desc: '', args: []);
  }

  /// `Israel`
  String get IL {
    return Intl.message('Israel', name: 'IL', desc: '', args: []);
  }

  /// `Greece`
  String get GR {
    return Intl.message('Greece', name: 'GR', desc: '', args: []);
  }

  /// `Germany`
  String get DE {
    return Intl.message('Germany', name: 'DE', desc: '', args: []);
  }

  /// `Philippines`
  String get PH {
    return Intl.message('Philippines', name: 'PH', desc: '', args: []);
  }

  /// `Denmark`
  String get DK {
    return Intl.message('Denmark', name: 'DK', desc: '', args: []);
  }

  /// `Netherlands`
  String get NL {
    return Intl.message('Netherlands', name: 'NL', desc: '', args: []);
  }

  /// `Czech Republic`
  String get CZ {
    return Intl.message('Czech Republic', name: 'CZ', desc: '', args: []);
  }

  /// `Bulgaria`
  String get BG {
    return Intl.message('Bulgaria', name: 'BG', desc: '', args: []);
  }

  /// `India`
  String get IN {
    return Intl.message('India', name: 'IN', desc: '', args: []);
  }

  /// `Spain`
  String get ES {
    return Intl.message('Spain', name: 'ES', desc: '', args: []);
  }

  /// `United States`
  String get US {
    return Intl.message('United States', name: 'US', desc: '', args: []);
  }

  /// `Vietnam`
  String get VN {
    return Intl.message('Vietnam', name: 'VN', desc: '', args: []);
  }

  /// `Japan`
  String get JP {
    return Intl.message('Japan', name: 'JP', desc: '', args: []);
  }

  /// `Finland`
  String get FI {
    return Intl.message('Finland', name: 'FI', desc: '', args: []);
  }

  /// `Korea`
  String get KR {
    return Intl.message('Korea', name: 'KR', desc: '', args: []);
  }

  /// `France`
  String get FR {
    return Intl.message('France', name: 'FR', desc: '', args: []);
  }

  /// `Thailand`
  String get TH {
    return Intl.message('Thailand', name: 'TH', desc: '', args: []);
  }

  /// `China`
  String get CN {
    return Intl.message('China', name: 'CN', desc: '', args: []);
  }

  /// `Taiwan`
  String get TW {
    return Intl.message('Taiwan', name: 'TW', desc: '', args: []);
  }

  /// `South Africa`
  String get ZA {
    return Intl.message('South Africa', name: 'ZA', desc: '', args: []);
  }

  /// `Arabic`
  String get AR {
    return Intl.message('Arabic', name: 'AR', desc: '', args: []);
  }

  /// `The numerical value has reached its limit`
  String get number_limit {
    return Intl.message(
      'The numerical value has reached its limit',
      name: 'number_limit',
      desc: '',
      args: [],
    );
  }

  /// `The character limit of the calculation has been reached`
  String get calculation_limit {
    return Intl.message(
      'The character limit of the calculation has been reached',
      name: 'calculation_limit',
      desc: '',
      args: [],
    );
  }

  /// `Smartor`
  String get app_name {
    return Intl.message('Smartor', name: 'app_name', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Calculation History`
  String get history_empty_title {
    return Intl.message(
      'Calculation History',
      name: 'history_empty_title',
      desc: '',
      args: [],
    );
  }

  /// `No calculations saved yet. Perform a calculation to get started!`
  String get history_empty_message {
    return Intl.message(
      'No calculations saved yet. Perform a calculation to get started!',
      name: 'history_empty_message',
      desc: '',
      args: [],
    );
  }

  /// `Delete entire history?`
  String get delete_all_history_title {
    return Intl.message(
      'Delete entire history?',
      name: 'delete_all_history_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the entire history? This action cannot be undone.`
  String get delete_all_history_content {
    return Intl.message(
      'Are you sure you want to delete the entire history? This action cannot be undone.',
      name: 'delete_all_history_content',
      desc: '',
      args: [],
    );
  }

  /// `Membership`
  String get membership {
    return Intl.message('Membership', name: 'membership', desc: '', args: []);
  }

  /// `My Subscription`
  String get my_subscription {
    return Intl.message(
      'My Subscription',
      name: 'my_subscription',
      desc: '',
      args: [],
    );
  }

  /// `Start a 3-day free trial`
  String get startTrial {
    return Intl.message(
      'Start a 3-day free trial',
      name: 'startTrial',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get subscription_button {
    return Intl.message(
      'Subscription',
      name: 'subscription_button',
      desc: '',
      args: [],
    );
  }

  /// `You will automatically be charged`
  String get try_free {
    return Intl.message(
      'You will automatically be charged',
      name: 'try_free',
      desc: '',
      args: [],
    );
  }

  /// `You will get a 3-day free trial. You can cancel your subscription during the free trial period. After that, you will automatically be charged`
  String get try_free2 {
    return Intl.message(
      'You will get a 3-day free trial. You can cancel your subscription during the free trial period. After that, you will automatically be charged',
      name: 'try_free2',
      desc: '',
      args: [],
    );
  }

  /// `until you cancel the subscription.`
  String get try_free1 {
    return Intl.message(
      'until you cancel the subscription.',
      name: 'try_free1',
      desc: '',
      args: [],
    );
  }

  /// `3-day free trial, then`
  String get label_3_day_free {
    return Intl.message(
      '3-day free trial, then',
      name: 'label_3_day_free',
      desc: '',
      args: [],
    );
  }

  /// `/month`
  String get label_3_day_free_month {
    return Intl.message(
      '/month',
      name: 'label_3_day_free_month',
      desc: '',
      args: [],
    );
  }

  /// `3 days free`
  String get trial {
    return Intl.message('3 days free', name: 'trial', desc: '', args: []);
  }

  /// `Restore`
  String get restore {
    return Intl.message('Restore', name: 'restore', desc: '', args: []);
  }

  /// `Weekly Pro`
  String get weekly_pro {
    return Intl.message('Weekly Pro', name: 'weekly_pro', desc: '', args: []);
  }

  /// `Monthly Pro`
  String get monthly_pro {
    return Intl.message('Monthly Pro', name: 'monthly_pro', desc: '', args: []);
  }

  /// `Yearly Pro`
  String get yearly_pro {
    return Intl.message('Yearly Pro', name: 'yearly_pro', desc: '', args: []);
  }

  /// `(1) No refunds can be issued under any circumstances.\n(2) Premium features may be added or changed later.\n(3) Even if you do not subscribe, you can still use other functions except for Premium features.\n(4) The subscription is automatically renewed unless it is canceled at least 24 hours before the end of the current period.\n(5) Even if you cancel the subscription, you can still use Premium features for the remaining time.\n(6) Payments are processed through the Google Play Store's payment system and subscription information will be stored in your Google account. You can cancel your subscription in the app settings or in the Google Play Store.`
  String get subscription_terms {
    return Intl.message(
      '(1) No refunds can be issued under any circumstances.\n(2) Premium features may be added or changed later.\n(3) Even if you do not subscribe, you can still use other functions except for Premium features.\n(4) The subscription is automatically renewed unless it is canceled at least 24 hours before the end of the current period.\n(5) Even if you cancel the subscription, you can still use Premium features for the remaining time.\n(6) Payments are processed through the Google Play Store\'s payment system and subscription information will be stored in your Google account. You can cancel your subscription in the app settings or in the Google Play Store.',
      name: 'subscription_terms',
      desc: '',
      args: [],
    );
  }

  /// `Remove Ads`
  String get remove_ads_title {
    return Intl.message(
      'Remove Ads',
      name: 'remove_ads_title',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy a smoother experience without interruptions from ads!`
  String get remove_ads_content {
    return Intl.message(
      'Enjoy a smoother experience without interruptions from ads!',
      name: 'remove_ads_content',
      desc: '',
      args: [],
    );
  }

  /// `Priority Support`
  String get priority_support_title {
    return Intl.message(
      'Priority Support',
      name: 'priority_support_title',
      desc: '',
      args: [],
    );
  }

  /// `Premium members get faster support! Need help? We're here for you.💬`
  String get priority_support_content {
    return Intl.message(
      'Premium members get faster support! Need help? We\'re here for you.💬',
      name: 'priority_support_content',
      desc: '',
      args: [],
    );
  }

  /// `Restore Successful`
  String get restore_success {
    return Intl.message(
      'Restore Successful',
      name: 'restore_success',
      desc: '',
      args: [],
    );
  }

  /// `Restore Failed`
  String get restore_failure {
    return Intl.message(
      'Restore Failed',
      name: 'restore_failure',
      desc: '',
      args: [],
    );
  }

  /// `Your Support is Our Motivation!`
  String get thank_you_premium_title {
    return Intl.message(
      'Your Support is Our Motivation!',
      name: 'thank_you_premium_title',
      desc: '',
      args: [],
    );
  }

  /// `Your support is a great source of motivation for us to grow and bring better features. Thank you for trusting and supporting us. We will continue to improve to provide you with the best experience! 🌟`
  String get thank_you_premium_content {
    return Intl.message(
      'Your support is a great source of motivation for us to grow and bring better features. Thank you for trusting and supporting us. We will continue to improve to provide you with the best experience! 🌟',
      name: 'thank_you_premium_content',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'af'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'bg'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'cs'),
      Locale.fromSubtags(languageCode: 'da'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'eu'),
      Locale.fromSubtags(languageCode: 'fi'),
      Locale.fromSubtags(languageCode: 'fil'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'he'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'hu'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'is'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'lt'),
      Locale.fromSubtags(languageCode: 'lv'),
      Locale.fromSubtags(languageCode: 'ms'),
      Locale.fromSubtags(languageCode: 'nb'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'sk'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'te'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
