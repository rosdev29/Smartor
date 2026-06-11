import 'dart:async';
import 'package:calc_pro/core/constants/constants.dart';
import 'package:calc_pro/core/extensions/context_extension.dart';
import 'package:calc_pro/core/extensions/string_extension.dart';
import 'package:calc_pro/core/strings/generated/l10n.dart';
import 'package:calc_pro/data/models/history.dart';
import 'package:calc_pro/data/usecase/calculate_use_case.dart';
import 'package:calc_pro/data/usecase/check_app_update_use_case.dart';
import 'package:calc_pro/data/usecase/convert_list_offsets_to_byte_buffer_use_case.dart';
import 'package:calc_pro/data/usecase/document_text_detection_use_case.dart';
import 'package:calc_pro/data/usecase/insert_history_use_case.dart';
import 'package:calc_pro/ui/routers/app_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integral_isolates/integral_isolates.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CalculateUseCase _calculateUseCase;

  HomeBloc({
    required CalculateUseCase calculateUseCase,
    required InsertHistoryUseCase insertHistoryUseCase,
    required CheckAppUpdateUseCase checkAppUpdateUseCase,
    required ConvertListOffsetsToBytesUseCase convertListOffsetsToFileUseCase,
    required DocumentTextDetectionUseCase documentTextDetectionUseCase,
  })  : _calculateUseCase = calculateUseCase,
        _insertHistoryUseCase = insertHistoryUseCase,
        _checkAppUpdateUseCase = checkAppUpdateUseCase,
        _convertListOffsetsToFileUseCase = convertListOffsetsToFileUseCase,
        _documentTextDetectionUseCase = documentTextDetectionUseCase,
        super(const InitialState()) {
    on<EnterCalculationsEvent>(_onEnterCalculationsEvent);
    on<ChangeKeyboardEvent>(_onSelectAdvancedKeyboardEvent);
    on<InitialEvent>(_initEvent);
    on<CallbackResultEvent>(_callbackResultEvent);
    on<CursorMoveEvent>(_cursorMoveEvent);
    on<NavigateEvent>(_navigateEvent);
    on<ChangeRadianEvent>(_changeRadian);
    on<OpenGmailEvent>(_openGmail);
    on<ShareEvent>(_shareEvent);
    on<OnPanStartEvent>(_onPanStart);
    on<OnPanUpdateEvent>(_onPanUpdate);
    on<OnPanEndEvent>(_onPanEnd);
    on<EmitListOffsetsEvent>(_emitListOffsets);
    on<OpenCameraEvent>(_openCamera);
  }

  final DocumentTextDetectionUseCase _documentTextDetectionUseCase;
  final ConvertListOffsetsToBytesUseCase _convertListOffsetsToFileUseCase;
  final InsertHistoryUseCase _insertHistoryUseCase;
  final CheckAppUpdateUseCase _checkAppUpdateUseCase;

  String _lastInput = '';
  final PageController pageDownController = PageController(initialPage: 0);
  final TextEditingController textEditingController = TextEditingController();
  int _numOfCloseBrackets = 0;
  int _numCalculating = 0;
  bool _isRadian = false;
  final _isolate = TailoredStatefulIsolate<Map<String, dynamic>, String>(
      backpressureStrategy: ReplaceBackpressureStrategy());
  List<List<Offset>> _listOffset = [];
  Timer? _timer;

  void _changeRadian(ChangeRadianEvent event, Emitter<HomeState> emit) {
    _isRadian = event.isRadian;
    _setTimer(textEditingController.text);
  }

  ///Điều hướng màn hình, sau đó sử lý logic khi quay trở lại nếu có
  void _navigateEvent(NavigateEvent event, Emitter<HomeState> emit) async {
    final object =
        await AppRouter.pushNamed(event.routeName, arguments: event.arguments);
    if (object == null) return;
    if (event.routeName == AppRouter.historyScreen) {
      final history = object as History;
      _numOfCloseBrackets = 0;
      _lastInput = history.value;
      final split = _lastInput.split(' = ');
      textEditingController.text = split.first;
      emit(ResultState(split.last));
    }
  }

  ///Tính toán lại vị trí của cursor khi người dùng chủ động thay đổi
  ///vị trí
  void _cursorMoveEvent(CursorMoveEvent event, Emitter<HomeState> emit) {
    var text = textEditingController.text;
    var cursor = textEditingController.selection.baseOffset;
    if (cursor <= 0 || cursor >= text.length) return;
    final operations = ['+', '-', '÷', '×'];
    if (text[cursor] != ' ' && !operations.contains(text[cursor])) return;
    if (text[cursor] == ' ' && operations.contains(text[cursor + 1])) return;
    if (operations.contains(text[cursor]) && text[cursor - 1] == ' ') {
      cursor--;
    } else if (text[cursor] == ' ' && operations.contains(text[cursor - 1])) {
      cursor++;
    }
    textEditingController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: cursor),
    );
  }

  ///Kiểm tra cập nhật ứng dụng
  void _initEvent(InitialEvent event, Emitter<HomeState> emit) {
    _checkAppUpdateUseCase.call();
    if (event.input.isEmpty) return;
    textEditingController.text = event.input;
    _setTimer(event.input);
  }

  ///Kiểm tra xem kí tự có nằm trong danh sách defaultList hay mores hay không,
  ///mặc định sẽ kiểm tra trong chuỗi ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.', ',']
  bool _checkCharacter(
      {required String char, List<String>? defaultList, List<String>? mores}) {
    var list = [];
    if (defaultList != null) {
      list = defaultList;
    } else {
      list = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.', ','];
    }
    if (mores != null) {
      list.addAll(mores);
    }
    return list.contains(char);
  }

  ///Thay đổi loại bàn phím cơ bản hoặc nâng cao
  void _onSelectAdvancedKeyboardEvent(
      ChangeKeyboardEvent event, Emitter<HomeState> emit) {
    pageDownController.animateToPage(event.index,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  ///Tính toán lại chuỗi phép tính khi người dùng nhập
  Future<void> _onEnterCalculationsEvent(
      EnterCalculationsEvent event, Emitter<HomeState> emit) async {
    var input = textEditingController.text;
    if (input.isNotEmpty && _lastInput.endsWith(input)) {
      _lastInput = '';
      if (_checkCharacter(char: event.char)) {
        textEditingController.text = event.char;
        return;
      }
    }

    var cursor = textEditingController.selection.baseOffset;
    var str = cursor > input.length
        ? input.substring(0, cursor - 1)
        : cursor > 0
            ? input.substring(0, cursor)
            : '';

    switch (event.char) {
      case '.':
      case ',':
        {
          String? extractedNumber;
          RegExp regExp = RegExp(r'[0-9.,]+');
          Iterable<RegExpMatch> matches = regExp.allMatches(input);

          for (var match in matches) {
            int start = match.start;
            int end = match.end;
            if (cursor == start || cursor == end) {
              extractedNumber = match.group(0);
            }
            if (cursor > start && cursor < end) {
              extractedNumber = match.group(0);
              break;
            }
          }
          if (extractedNumber != null &&
              !extractedNumber.contains(event.char)) {
            final text = '$str${event.char}${input.substring(cursor)}'.format;
            final offset = '$str${event.char}'.length;
            textEditingController.value = TextEditingValue(
              text: text,
              selection: TextSelection.collapsed(offset: offset),
            );
            _setTimer(text);
          }
          break;
        }
      case 'C':
        {
          textEditingController.clear();
          emit(ResultState(''));
          _numOfCloseBrackets = 0;
          break;
        }
      case 'AC':
        {
          if (str.isNotEmpty) {
            int newCursor = 0;
            if (str.endsWith('sin(') ||
                str.endsWith('cos(') ||
                str.endsWith('tan(') ||
                str.endsWith('cot(') ||
                str.endsWith('log(')) {
              newCursor = cursor - 4;
              _numOfCloseBrackets--;
            } else if (str.endsWith(' ')) {
              newCursor = cursor - 3;
            } else if (str.endsWith('√(') || str.endsWith('^(')) {
              newCursor = cursor - 2;
              _numOfCloseBrackets--;
            } else if (str.endsWith('.')) {
              if (str.length > 1) newCursor = cursor - 1;
            } else {
              newCursor = cursor - 1;
              if (str.length > 1 && str[newCursor - 1] == '.') newCursor--;
              if (str.endsWith(')')) _numOfCloseBrackets++;
              if (str.endsWith('(')) _numOfCloseBrackets--;
            }
            var text =
                '${newCursor > 0 ? str.substring(0, newCursor) : ''}${cursor < input.length - 1 ? input.substring(cursor) : ''}';
            text = text.format;
            textEditingController.value = TextEditingValue(
              text: text,
              selection: TextSelection.collapsed(offset: newCursor),
            );

            _setTimer(text);
          }

          break;
        }
      case 'sin':
      case 'cos':
      case 'tan':
      case 'cot':
      case 'log':
      case '√':
      case '^':
        {
          var newText = '';
          var newCursor = cursor;
          if (event.char == '√' || event.char == '^') {
            newText = '$str${event.char}(${input.substring(cursor)}';
            newCursor += 2;
          } else {
            newText = '$str${event.char}(${input.substring(cursor)}';
            newCursor += 4;
          }
          textEditingController.value = TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: newCursor),
          );
          _numOfCloseBrackets++;
          break;
        }
      case '( )':
        {
          if (str.endsWith('+ ') ||
              str.endsWith('- ') ||
              str.endsWith('× ') ||
              str.endsWith('÷ ') ||
              str.endsWith('(')) {
            textEditingController.value = TextEditingValue(
              text: '$str(${input.substring(cursor)}',
              selection: TextSelection.collapsed(offset: cursor + 1),
            );
            _numOfCloseBrackets++;
          } else {
            if (_numOfCloseBrackets > 0) {
              textEditingController.value = TextEditingValue(
                text: '$str)${input.substring(cursor)}',
                selection: TextSelection.collapsed(offset: cursor + 1),
              );
              _numOfCloseBrackets--;
            } else {
              textEditingController.value = TextEditingValue(
                text: str.isNotEmpty
                    ? '$str × (${input.substring(cursor)}'
                    : '(${input.substring(cursor)}',
                selection: TextSelection.collapsed(
                    offset: str.isNotEmpty ? cursor + 4 : cursor + 1),
              );
              _numOfCloseBrackets++;
            }
          }
          _setTimer(textEditingController.text);
          break;
        }
      case '+/-':
        {
          //input = '121+(45+54)
          if (input.isEmpty) {
            textEditingController.value = const TextEditingValue(
              text: '(-)',
              selection: TextSelection.collapsed(offset: 2),
            );
            return;
          }
          if (input == '(-)') {
            textEditingController.value = const TextEditingValue(
              text: '',
              selection: TextSelection.collapsed(offset: 0),
            );
            return;
          }
          if (cursor == input.length &&
              (input.endsWith(' ') ||
                  input.endsWith('+') ||
                  input.endsWith('-') ||
                  input.endsWith('×') ||
                  input.endsWith('÷'))) {
            textEditingController.value = TextEditingValue(
              text: '$input(-)',
              selection: TextSelection.collapsed(offset: cursor + 2),
            );
            return;
          }
          if (input.endsWith('(-)') && cursor >= input.length - 3) {
            final text = input.substring(0, input.length - 3);
            textEditingController.value = TextEditingValue(
              text: text,
              selection: TextSelection.collapsed(offset: text.length),
            );
            return;
          }
          int start = cursor > 0 ? cursor - 1 : 0;
          int end = start;
          try {
            if (input[start] == ' ' &&
                _checkCharacter(
                    char: input[start + 1],
                    defaultList: ['+', '-', '×', '÷'])) {
              if (cursor > 0) cursor--;
            } else if (_checkCharacter(
                    char: input[start], defaultList: ['+', '-', '×', '÷']) &&
                input[start + 1] == ' ') {
              cursor++;
            } else if (input[start] == ' ' &&
                _checkCharacter(
                    char: input[start - 1],
                    defaultList: ['+', '-', '×', '÷'])) {
              start += 1;
            }
            if (input[start] == ')') {
              int index = start - 1;
              while (_checkCharacter(char: input[index])) {
                index--;
              }
              if (input[index] == '-' && input[index - 1] == '(') {
                start -= 1;
              }
            } else if (start < input.length - 2 &&
                input[start + 1] == '(' &&
                input[start + 2] == '-') {
              start += 3;
            } else if (start < input.length - 2 &&
                input[start] == '(' &&
                input[start + 1] == '-') {
              start += 2;
            } else if (input[start] == '(' &&
                _checkCharacter(char: input[start + 1])) {
              start++;
            }
            end = start;
            while (start > 0 && _checkCharacter(char: input[start])) {
              start--;
            }
            if ((start > 0 && start < cursor - 1) ||
                !_checkCharacter(char: input[start])) {
              start++;
            }
            while (end < input.length - 1 &&
                _checkCharacter(char: input[end], mores: ['-'])) {
              end++;
            }
            if (input[end] == ' ') end--;
            bool isNegative = start > 1 &&
                input[start - 1] == '-' &&
                input[start - 2] == '(' &&
                end < input.length &&
                input[end] == ')';
            if (start < end && !isNegative) {
              cursor += cursor - 1 >= start
                  ? cursor - 1 < end
                      ? 2
                      : 3
                  : 0;
              var part1 = start > 0 ? '${input.substring(0, start)}(-' : '(-';
              var part2 =
                  '${input.substring(start == end ? start - 1 : start, end + 1)})';
              var part3 =
                  end < input.length - 1 ? input.substring(end + 1) : '';
              input = '$part1$part2$part3';
            } else if (start < end && isNegative) {
              var part1 = input.substring(0, start - 2);
              var part2 = input.substring(start, end);
              var part3 = input.substring(end + 1);
              input = '$part1$part2$part3';
              cursor -= cursor - 1 >= start
                  ? cursor - 1 < end
                      ? 2
                      : 3
                  : 0;
            } else if (_checkCharacter(char: input[start])) {
              cursor += cursor == 0
                  ? 0
                  : cursor - 1 >= start
                      ? cursor - 1 < end
                          ? 2
                          : 3
                      : 0;
              var part1 = input.substring(0, start);
              var part2 = '(-${input.substring(start, end + 1)})';
              var part3 = input.substring(end + 1);
              input = '$part1$part2$part3';
            } else if (_checkCharacter(char: input[start])) {
              var part1 = input.substring(0, cursor - 1);
              var part2 = '(-${input.substring(cursor - 1)}';
              input = '$part1$part2';
              cursor -= 1;
              _numOfCloseBrackets++;
            }

            textEditingController.value = TextEditingValue(
              text: input,
              selection: TextSelection.collapsed(offset: cursor),
            );
            _setTimer(input);
          } catch (e) {
            emit(ResultState(S.current.invalid));
          }
          break;
        }
      case '=':
        {
          try {
            if (input.isNotEmpty) {
              var string = input;
              if (string.endsWith(' ')) {
                string = string.substring(0, string.length - 1);
              }
              while (string.endsWith('+') ||
                  string.endsWith('-') ||
                  string.endsWith('×') ||
                  string.endsWith('÷')) {
                string = string.substring(0, string.length - 1);
              }
              var result = _calculateUseCase.call({
                'input': string,
                'isRadian': _isRadian,
                'isDotDecimalLocale': AppRouter.context.isDotDecimalLocale,
              });
              emit(ResultState(result));
              if ('$string=$result' == _lastInput) return;
              var history = History('$string = $result');
              _lastInput = '$input=$result';
              textEditingController.text = result;
              if ((input.indexOf('+') > 0 &&
                      input.indexOf('+') < input.length - 1) ||
                  (input.indexOf('-') > 0 &&
                      input.indexOf('-') < input.length - 1) ||
                  (input.indexOf('×') > 0 &&
                      input.indexOf('×') < input.length - 1) ||
                  (input.indexOf('÷') > 0 &&
                      input.indexOf('÷') < input.length - 1)) {
                _insertHistoryUseCase.call(history: history);
              }
            }
          } catch (e) {
            debugPrint(e.toString());
            emit(ResultState(S.current.invalid));
          }
          break;
        }
      default:
        {
          if (input.length < 300) {
            var char = event.char;
            if (char == '—') {
              char = ' - ';
            } else if (char == '+' ||
                char == '-' ||
                char == '×' ||
                char == '÷') {
              char = ' $char ';
            }
            if (!_checkCharacter(char: char, defaultList: [
                  ' - ',
                  ' + ',
                  ' × ',
                  ' ÷ ',
                  '%',
                  '.',
                  '!',
                  '^'
                ]) &&
                str.endsWith(')')) {
              char = ' × $char';
            }
            var value = '$str$char${input.substring(cursor)}'.format;

            try {
              cursor = cursor == input.length
                  ? cursor = value.length
                  : value.length - (input.length - cursor);
              textEditingController.value = TextEditingValue(
                  text: value,
                  selection: TextSelection.collapsed(offset: cursor));
              _setTimer(value);
            } catch (e) {
              if (e.runtimeType == FormatException) {
                AppRouter.showMessageError(S.current.number_limit);
              }
            }
          } else {
            AppRouter.showMessageError(S.current.calculation_limit);
          }
          break;
        }
    }
  }

  ///Hiển thị kết quả cuối cùng của phép tính sau lần chạm cuối trong
  ///một khoảng thời gian ngắn
  void _setTimer(String input) async {
    _numCalculating++;
    final current = _numCalculating;
    try {
      var result = await _isolate.compute(_calculateUseCase.call, {
        'input': input,
        'isRadian': _isRadian,
        'isDotDecimalLocale': AppRouter.context.isDotDecimalLocale,
      });
      if (current != _numCalculating) return;
      add(CallbackResultEvent(result));
    } catch (e) {
      add(CallbackResultEvent(S.current.invalid));
    }
  }

  ///Hiển thị kết quả của phép tính
  void _callbackResultEvent(
      CallbackResultEvent event, Emitter<HomeState> emit) {
    emit(ResultState(event.result));
  }

  void _openGmail(OpenGmailEvent event, Emitter<HomeState> emit) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'minhto28.dev@gmail.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Reporting a Bug CalcPro App!',
      }),
    );
    launchUrl(emailLaunchUri);
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _shareEvent(ShareEvent event, Emitter<HomeState> emit) async {
    Share.share(Constants.googlePlayId);
  }

  void _onPanStart(OnPanStartEvent event, Emitter<HomeState> emit) {
    _timer?.cancel();
    _timer = null;
    _listOffset.add([event.details.localPosition]);
    add(EmitListOffsetsEvent());
  }

  void _onPanUpdate(OnPanUpdateEvent event, Emitter<HomeState> emit) {
    if (_listOffset.isEmpty) _listOffset.add([]);
    _listOffset.last.add(event.details.localPosition);
    add(EmitListOffsetsEvent());
  }

  void _onPanEnd(OnPanEndEvent event, Emitter<HomeState> emit) {
    if (_listOffset.isEmpty) _listOffset.add([]);
    _listOffset.last.add(event.details.localPosition);
    add(EmitListOffsetsEvent());
    _refreshListPain();
  }

  void _emitListOffsets(EmitListOffsetsEvent event, Emitter<HomeState> emit) {
    emit(ListPainState(
        listOffsets: _listOffset, hash: DateTime.now().microsecondsSinceEpoch));
  }

  void _refreshListPain() {
    _timer?.cancel();
    _timer = null;
    _timer = Timer(const Duration(milliseconds: 1000), () async {
      try {
        final byteBuffer = await _convertListOffsetsToFileUseCase.call(
            listOffsets: _listOffset);
        final textRecognizer = await _documentTextDetectionUseCase.call(
            bytes: byteBuffer.asUint8List());
        _listOffset = [];
        add(EmitListOffsetsEvent());
        if (textRecognizer == null) return;
        if (textRecognizer.text.isEmpty) return;
        var str = textRecognizer.text.replaceAll(RegExp(r'\s+|가'), '');
        str = str.replaceAll(RegExp(r'X|x'), ' × ');
        str = str.replaceAll(RegExp(r'-|_'), ' - ');
        str = str.replaceAll(RegExp(r'/'), ' ÷ ');
        str = str.replaceAll(RegExp(r'\\+|十|ナ'), ' + ');
        str = str.replaceAll(RegExp(r'е|Я|d|у'), 'e');
        str = str.replaceAll(RegExp(r'o|G|O|О|о'), '0');
        str = str.replaceAll(RegExp(r'て|Z|Г|z|乙'), '2');
        str = str.replaceAll(RegExp(r'N|ह|ろ|з'), '3');
        str = str.replaceAll(RegExp(r'а|A'), '4');
        str = str.replaceAll(RegExp(r'S|s|つ|コ|凹|רט|ち|ज'), '5');
        str = str.replaceAll(RegExp(r'Co|д|Б|の|لا|я|н'), '6');
        str = str.replaceAll(RegExp(r'F|ヲ|근|ㅋ|t'), '7');
        str = str.replaceAll(RegExp(r'४|مم|b|୪'), '8');
        str = str.replaceAll(RegExp(r'g|୨'), '9');
        str = str.replaceAll(RegExp(r'リ|ㅠ|ㄲ|П|せ|サ|廾|キ|Н|丈'), 'π');
        str = str.replaceAll('E', 'e');
        str = str.replaceAll('[', '(');
        str = str.replaceAll(']', ')');
        str = str.replaceAllMapped(RegExp(r'(5in|5m|5u8|5un)(\d*)'), (match) {
          return "sin(${match.group(2) ?? '0'})";
        });
        str = str.replaceAllMapped(RegExp(r'(C05|c05)(\d*)'), (match) {
          return "cos(${match.group(2) ?? '0'})";
        });
        str = str.replaceAllMapped(
            RegExp(r'(т4п|Т4л|tan|ta|т4|Tar|tar|Tam|tam|tar)(\d*)'), (match) {
          return "tan(${match.group(2) ?? '0'})";
        });
        str = str.replaceAllMapped(
            RegExp(r'(c0t|C0t|сот|c0\+|C0\+|c0\+|c0f)(\d*)'), (match) {
          return "cot(${match.group(2) ?? '0'})";
        });
        str = str.replaceAllMapped(RegExp(r'(l09|L09|во6)(\d*)'), (match) {
          return "log(${match.group(2) ?? '0'})";
        });
        if (AppRouter.context.isDotDecimalLocale) {
          str = str.replaceAll(',', '.');
        }
        debugPrint('>>>>$str');
        add(EnterCalculationsEvent(str));
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  void _openCamera(OpenCameraEvent event, Emitter<HomeState> emit) async {
    AppRouter.pushNamed(AppRouter.cameraScreen,
        arguments: AppRouter.scannerScreen);
  }

  @override
  Future<void> close() {
    textEditingController.dispose();
    pageDownController.dispose();
    return super.close();
  }
}
