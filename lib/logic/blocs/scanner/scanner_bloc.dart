import 'package:calc_pro/core/extensions/context_extension.dart';
import 'package:calc_pro/core/extensions/string_extension.dart';
import 'package:calc_pro/data/usecase/document_text_detection_use_case.dart';
import 'package:calc_pro/ui/routers/app_router.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image/image.dart' as img;
import 'dart:math' as math;

part 'scanner_event.dart';

part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc({
    required DocumentTextDetectionUseCase documentTextDetectionUseCase,
  })  : _documentTextDetectionUseCase = documentTextDetectionUseCase,
        super(ScannerInitial()) {
    on<InitialEvent>(_init);
    on<TapEvent>(_tap);
    on<RollBackEvent>(_rollBack);
    on<ShowCalculatorEvent>(_showCalculator);
    on<DismissCalculatorEvent>(_dismissCalculator);
  }

  final DocumentTextDetectionUseCase _documentTextDetectionUseCase;
  late List<Rect> _listRect;
  late List<String> _listText;
  final List<Rect> _listRectSelected = [];

  void _init(InitialEvent event, Emitter<ScannerState> emit) async {
    emit(LoadingState(isLoading: true));
    try {
      final xFile = ModalRoute.of(event.context)!.settings.arguments as XFile;
      emit(ImageState(path: xFile.path));
      final bytes = await xFile.readAsBytes();
      final recognizedText =
          await _documentTextDetectionUseCase.call(bytes: bytes);
      if (recognizedText == null) {
        emit(LoadingState(isLoading: false));
        return;
      }
      final image = img.decodeImage(bytes);
      final iWight = image!.width;
      final iHeight = image.height;
      final sWidth = AppRouter.context.width;
      final sHeight = AppRouter.context.height;
      final scaleX = sWidth / iWight;
      final scaleY = sHeight / iHeight;
      final scale = math.max(scaleX, scaleY);
      final paddingX = (iWight * scale - sWidth) / 2;
      _listRect = [];
      _listText = [];
      _listRectSelected.clear();
      for (final word in recognizedText.words) {
        final text = word.text.extractNumbers;
        if (text.isEmpty) continue;
        final box = word.boundingBox;
        final left = box.left * scale - paddingX;
        final top = box.top * scale;
        final right = box.right * scale - paddingX;
        final bottom = box.bottom * scale;
        final rect = Rect.fromLTRB(left, top, right, bottom);
        _listText.add(text);
        _listRect.add(rect);
      }
      emit(LoadingState(isLoading: false));
      if (_listRect.isEmpty) return;
      emit(ListRectState(listRect: _listRect));
    } catch (e) {
      debugPrint('INIT_SCANNER_ERROR: $e');
      AppRouter.pop();
    }
  }

  void _tap(TapEvent event, Emitter<ScannerState> emit) {
    if (_listRect.isEmpty) return;
    final offset = event.details.globalPosition;
    for (final rect in _listRect) {
      if (rect.contains(offset)) {
        if (_listRectSelected.contains(rect)) {
          _listRectSelected.remove(rect);
        } else {
          _listRectSelected.add(rect);
        }
        break;
      }
    }
    emit(ListRectSelectedState(
      listRect: _listRectSelected,
      hash: DateTime.now().microsecondsSinceEpoch,
    ));
  }

  void _rollBack(RollBackEvent event, Emitter<ScannerState> emit) {
    _listRectSelected.removeLast();
    emit(ListRectSelectedState(
      listRect: _listRectSelected,
      hash: DateTime.now().microsecondsSinceEpoch,
    ));
  }

  void _showCalculator(ShowCalculatorEvent event, Emitter<ScannerState> emit) {
    List<String> texts = [];
    for (final rect in _listRectSelected) {
      for (int i = 0; i < _listRect.length; i++) {
        if (rect.contains(_listRect[i].center)) {
          texts.add(_listText[i]);
          break;
        }
      }
    }
    final input = texts.join(' + ');
    emit(ShowCalculatorState(input: input));
  }

  void _dismissCalculator(
      DismissCalculatorEvent event, Emitter<ScannerState> emit) {
    emit(ShowCalculatorState(input: ''));
  }
}
