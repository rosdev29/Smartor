import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_docx_event.dart';
part 'view_docx_state.dart';

class ViewDocxBloc extends Bloc<ViewDocxEvent, ViewDocxState> {
  ViewDocxBloc() : super(ViewDocxInitial()) {
    on<ChoosePdfFileEvent>(_choosePdfFile);
  }

  void _choosePdfFile(
      ChoosePdfFileEvent event, Emitter<ViewDocxState> emit) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx', 'doc'],
    );
    if (result == null || result.files.isEmpty) return;
    final path = result.files.first.path;
    emit(FileState(path: path!));
  }
}
