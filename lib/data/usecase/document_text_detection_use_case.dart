import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';

/// Một từ/cụm chữ được nhận dạng kèm khung bao (toạ độ theo pixel ảnh gốc).
class RecognizedWord {
  final String text;
  final Rect boundingBox;

  const RecognizedWord({required this.text, required this.boundingBox});
}

/// Kết quả nhận dạng văn bản: chuỗi đầy đủ + danh sách từ kèm toạ độ.
class TextDetectionResult {
  final String text;
  final List<RecognizedWord> words;

  const TextDetectionResult({required this.text, required this.words});
}

/// Nhận dạng văn bản từ ảnh bằng Google ML Kit (chạy trên thiết bị, miễn phí,
/// không cần API key).
class DocumentTextDetectionUseCase {
  final TextRecognizer _textRecognizer;

  const DocumentTextDetectionUseCase({required TextRecognizer textRecognizer})
      : _textRecognizer = textRecognizer;

  Future<TextDetectionResult?> call({required Uint8List bytes}) async {
    File? tempFile;
    try {
      final dir = await getTemporaryDirectory();
      tempFile = File(
          '${dir.path}/ocr_${DateTime.now().microsecondsSinceEpoch}.png');
      await tempFile.writeAsBytes(bytes, flush: true);

      final inputImage = InputImage.fromFilePath(tempFile.path);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      final words = <RecognizedWord>[];
      for (final block in recognizedText.blocks) {
        for (final line in block.lines) {
          for (final element in line.elements) {
            words.add(RecognizedWord(
              text: element.text,
              boundingBox: element.boundingBox,
            ));
          }
        }
      }
      return TextDetectionResult(text: recognizedText.text, words: words);
    } catch (e) {
      return null;
    } finally {
      try {
        if (tempFile != null && await tempFile.exists()) {
          await tempFile.delete();
        }
      } catch (_) {}
    }
  }
}
