import 'package:calc_pro/data/models/history.dart';
import 'package:calc_pro/data/repositories/history_repository.dart';
import 'package:calc_pro/data/usecase/calculate_use_case.dart';
import 'package:calc_pro/data/usecase/check_app_update_use_case.dart';
import 'package:calc_pro/data/usecase/convert_list_offsets_to_byte_buffer_use_case.dart';
import 'package:calc_pro/data/usecase/delete_all_history_use_case.dart';
import 'package:calc_pro/data/usecase/delete_history_use_case.dart';
import 'package:calc_pro/data/usecase/document_text_detection_use_case.dart';
import 'package:calc_pro/data/usecase/get_barcode_type_use_case.dart';
import 'package:calc_pro/data/usecase/get_language_translate_use_case.dart';
import 'package:calc_pro/data/usecase/get_list_history_use_case.dart';
import 'package:calc_pro/data/usecase/get_version_qr_code_use_case.dart';
import 'package:calc_pro/data/usecase/insert_history_use_case.dart';
import 'package:calc_pro/data/usecase/set_barcode_type_use_case.dart';
import 'package:calc_pro/data/usecase/set_language_translate_use_case.dart';
import 'package:calc_pro/data/usecase/set_version_qr_code_use_case.dart';
import 'package:calc_pro/logic/blocs/barcode/barcode_bloc.dart';
import 'package:calc_pro/logic/blocs/camera/camera_bloc.dart';
import 'package:calc_pro/logic/blocs/history/history_bloc.dart';
import 'package:calc_pro/logic/blocs/home/home_bloc.dart';
import 'package:calc_pro/logic/blocs/qr_gen/qr_gen_bloc.dart';
import 'package:calc_pro/logic/blocs/scanner/scanner_bloc.dart';
import 'package:calc_pro/logic/blocs/splash/splash_bloc.dart';
import 'package:calc_pro/logic/blocs/translate/translate_bloc.dart';
import 'package:calc_pro/logic/blocs/view_docx/view_docx_bloc.dart';
import 'package:calc_pro/logic/blocs/view_pdf/view_pdf_bloc.dart';
import 'package:calc_pro/logic/cubits/language/language_cubit.dart';
import 'package:calc_pro/logic/cubits/theme/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_vision/google_vision.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

part 'bloc_injector.dart';

part 'repository_injector.dart';

part 'usecase_injector.dart';

part 'cubit_injector.dart';

final getIt = GetIt.instance;

Future<void> injector() async {
  getIt.registerSingletonAsync<Isar>(() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [HistorySchema],
      directory: dir.path,
    );
  });

  getIt.registerSingleton<GoogleVision>(
      GoogleVision().withApiKey('AIzaSyAEJpxDSyHKnjy0jx5V56ofU1J6oHM-YLg'));

  await getIt.isReady<Isar>();

  _repositoryInjector();
  _useCaseInjector();
  _cubitInjector();
  _blocInjector();
}