import 'dart:async';

import 'package:calc_pro/core/extensions/context_extension.dart';
import 'package:calc_pro/core/strings/generated/l10n.dart';
import 'package:calc_pro/data/usecase/document_text_detection_use_case.dart';
import 'package:calc_pro/data/usecase/get_language_translate_use_case.dart';
import 'package:calc_pro/data/usecase/set_language_translate_use_case.dart';
import 'package:calc_pro/ui/routers/app_router.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image/image.dart' as img;
import 'dart:math' as math;

import 'package:translator/translator.dart';

part 'translate_event.dart';

part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc({
    required DocumentTextDetectionUseCase documentTextDetectionUseCase,
    required GetLanguageTranslateUseCase getLanguageTranslateUseCase,
    required SetLanguageTranslateUseCase setLanguageTranslateUseCase,
  })  : _documentTextDetectionUseCase = documentTextDetectionUseCase,
        _getLanguageTranslateUseCase = getLanguageTranslateUseCase,
        _setLanguageTranslateUseCase = setLanguageTranslateUseCase,
        super(TranslateInitial()) {
    on<InitialEvent>(_init);
    on<SelectedLanguageEvent>(_selectedLanguage);
    on<OnPanStartEvent>(_onPanStart);
    on<OnPanUpdateEvent>(_onPanUpdate);
    on<OnPanEndEvent>(_onPanEnd);
    on<SelectedTypeEvent>(_selectedType);
    on<OnSwipeStartEvent>(_onSwipeStart);
    on<OnSwipeUpdateEvent>(_onSwipeUpdate);
    on<OnSwipeEndEvent>(_onSwipeEnd);
    on<ResultEvent>(_sendResult);
    on<CopyEvent>(_copy);
  }

  final GetLanguageTranslateUseCase _getLanguageTranslateUseCase;
  final SetLanguageTranslateUseCase _setLanguageTranslateUseCase;
  final DocumentTextDetectionUseCase _documentTextDetectionUseCase;
  late List<Rect> _listRect;
  late List<String> _listText;
  final List<Rect> _listRectSelected = [];
  late Rect _rectArea;
  late _Direction _direction;
  final _translator = GoogleTranslator();
  late String _languageTranslate;
  int _typeIndex = 0;
  Timer? _timer;

  void _init(InitialEvent event, Emitter<TranslateState> emit) async {
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
        final text = word.text;
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

      emit(ListRectState(listRect: _listRect, isShow: false));
      final dx = event.context.width / 2;
      final dy = event.context.height / 2;
      _rectArea =
          Rect.fromCenter(center: Offset(dx, dy), width: dx, height: dy / 2);
      emit(RectAreaState(rectArea: _rectArea, isShow: true));
      emit(TypeState(type: _typeIndex));
      _languageTranslate = await _getLanguageTranslateUseCase.call();
      emit(LanguageState(languageCode: _languageTranslate));
      emit(LoadingState(isLoading: false));
    } catch (e) {
      debugPrint('INIT_TRANSLATE_ERROR: $e');
      AppRouter.pop();
    }
  }

  void _selectedLanguage(
      SelectedLanguageEvent event, Emitter<TranslateState> emit) {
    _languageTranslate = event.languageCode;
    emit(LanguageState(languageCode: _languageTranslate));
    add(_typeIndex == 0 ? OnPanEndEvent() : OnSwipeEndEvent());
    _setLanguageTranslateUseCase.call(
        languageCodeTranslate: event.languageCode);
  }

  void _onPanStart(OnPanStartEvent event, Emitter<TranslateState> emit) {
    _setTimer('');
    final pos = event.details.globalPosition;
    if (_insideTheRange(pos, _rectArea.topLeft)) {
      _direction = _Direction.topLeft;
      return;
    }
    if (_insideTheRange(pos, _rectArea.topRight)) {
      _direction = _Direction.topRight;
      return;
    }
    if (_insideTheRange(pos, _rectArea.bottomLeft)) {
      _direction = _Direction.bottomLeft;
      return;
    }
    if (_insideTheRange(pos, _rectArea.bottomRight)) {
      _direction = _Direction.bottomRight;
      return;
    }
    if (_insideTheRange(pos, _rectArea.centerLeft)) {
      _direction = _Direction.centerLeft;
      return;
    }
    if (_insideTheRange(pos, _rectArea.centerRight)) {
      _direction = _Direction.centerRight;
      return;
    }
    if (_insideTheRange(pos, _rectArea.topCenter)) {
      _direction = _Direction.centerTop;
      return;
    }
    if (_insideTheRange(pos, _rectArea.bottomCenter)) {
      _direction = _Direction.centerBottom;
      return;
    }

    if (_insideTheRange(pos, _rectArea.center, 30.0)) {
      _direction = _Direction.center;
      return;
    }
    _direction = _Direction.none;
  }

  bool _insideTheRange(Offset p1, Offset p2, [double distanceDefault = 20.0]) {
    final distance =
        math.sqrt(math.pow(p2.dx - p1.dx, 2) + math.pow(p2.dy - p1.dy, 2));
    return distance < distanceDefault;
  }

  void _onPanUpdate(OnPanUpdateEvent event, Emitter<TranslateState> emit) {
    _setTimer('');
    final offset = event.details.globalPosition;
    Rect? rect;
    switch (_direction) {
      case _Direction.topLeft:
        rect = Rect.fromPoints(offset, _rectArea.bottomRight);
        break;
      case _Direction.topRight:
        rect = Rect.fromPoints(_rectArea.bottomLeft, offset);
        break;
      case _Direction.bottomLeft:
        rect = Rect.fromPoints(offset, _rectArea.topRight);
        break;
      case _Direction.bottomRight:
        rect = Rect.fromPoints(_rectArea.topLeft, offset);
        break;
      case _Direction.centerLeft:
        rect = Rect.fromLTRB(
            offset.dx, _rectArea.top, _rectArea.right, _rectArea.bottom);
        break;
      case _Direction.centerRight:
        rect = Rect.fromLTRB(
            _rectArea.left, _rectArea.top, offset.dx, _rectArea.bottom);
        break;
      case _Direction.centerTop:
        rect = Rect.fromLTRB(
            _rectArea.left, offset.dy, _rectArea.right, _rectArea.bottom);
        break;
      case _Direction.centerBottom:
        rect = Rect.fromLTRB(
            _rectArea.left, _rectArea.top, _rectArea.right, offset.dy);
        break;
      case _Direction.center:
        rect = Rect.fromCenter(
            center: offset, width: _rectArea.width, height: _rectArea.height);
        break;
      case _Direction.none:
        break;
    }
    if (rect == null) return;
    if (rect.width < 61 || rect.height < 21) return;
    _rectArea = rect;
    emit(RectAreaState(rectArea: _rectArea, isShow: true));
  }

  void _onPanEnd(OnPanEndEvent event, Emitter<TranslateState> emit) async {
    String text = '';
    for (int i = 0; i < _listRect.length; i++) {
      if (_rectArea.contains(_listRect[i].center)) {
        text = '$text ${_listText[i]} ';
      }
    }
    text = text.trim();
    _setTimer(text);
  }

  void _selectedType(SelectedTypeEvent event, Emitter<TranslateState> emit) {
    _typeIndex = event.index;
    emit(TypeState(type: _typeIndex));
    add(ResultEvent(result: ''));
    if (_typeIndex == 0) {
      emit(ListRectState(listRect: _listRect, isShow: false));
      emit(RectAreaState(rectArea: _rectArea, isShow: true));
      emit(ListRectSelectedState(
        listRectSelected: _listRectSelected,
        hash: DateTime.now().microsecondsSinceEpoch,
        isShow: false,
      ));
    } else {
      _listRectSelected.clear();
      emit(ListRectState(listRect: _listRect, isShow: true));
      emit(RectAreaState(rectArea: _rectArea, isShow: false));
      emit(ListRectSelectedState(
        listRectSelected: _listRectSelected,
        hash: DateTime.now().microsecondsSinceEpoch,
        isShow: true,
      ));
    }
  }

  void _onSwipeStart(OnSwipeStartEvent event, Emitter<TranslateState> emit) {
    _setTimer('');
    for (final rect in _listRect) {
      if (rect.contains(event.details.globalPosition)) {
        if (!_listRectSelected.contains(rect)) {
          _listRectSelected.add(rect);
          emit(ListRectSelectedState(
            listRectSelected: _listRectSelected,
            hash: DateTime.now().microsecondsSinceEpoch,
            isShow: true,
          ));
        }
        break;
      }
    }
  }

  void _onSwipeUpdate(OnSwipeUpdateEvent event, Emitter<TranslateState> emit) {
    _setTimer('');
    for (final rect in _listRect) {
      if (rect.contains(event.details.globalPosition)) {
        if (!_listRectSelected.contains(rect)) {
          _listRectSelected.add(rect);
          emit(ListRectSelectedState(
            listRectSelected: _listRectSelected,
            hash: DateTime.now().microsecondsSinceEpoch,
            isShow: true,
          ));
        }
        break;
      }
    }
  }

  _setTimer(String text) {
    _timer?.cancel();
    _timer = null;
    _timer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final translation =
            await _translator.translate(text, to: _languageTranslate);
        add(ResultEvent(result: translation.text));
      } catch (e) {
        debugPrint('TRANSLATE_ERROR: $e');
      } finally {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  void _sendResult(ResultEvent event, Emitter<TranslateState> emit) {
    emit(ResultState(result: event.result));
  }

  void _onSwipeEnd(OnSwipeEndEvent event, Emitter<TranslateState> emit) {
    String text = '';
    for (int i = 0; i < _listRect.length; i++) {
      for (final rect in _listRectSelected) {
        if (rect.contains(_listRect[i].center)) {
          text = '$text ${_listText[i]} ';
          break;
        }
      }
    }
    text = text.trim();
    _setTimer(text);
  }

  void _copy(CopyEvent event, Emitter<TranslateState> emit) {
    Clipboard.setData(ClipboardData(text: event.text));
    AppRouter.showMessageSuccess(S.current.copied);
  }
}

enum _Direction {
  topLeft,
  centerLeft,
  topRight,
  centerRight,
  bottomLeft,
  centerBottom,
  bottomRight,
  centerTop,
  center,
  none,
}
