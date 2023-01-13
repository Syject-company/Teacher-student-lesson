import 'package:flutter/material.dart';
import 'package:tutor/utils/model/file_model.dart';

class FileUploadWidget extends StatefulWidget {
  String uuid;
  String challenge_type;

  FileUploadWidget({Key? key, required this.uuid, required this.challenge_type})
      : super(key: key);

  @override
  State<FileUploadWidget> createState() =>
      _FileUploadWidgetState(uuid: uuid, challenge_type: challenge_type);
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  // FilesRepository filesRepository = FilesRepository(dioClient: DioClient());
  String uuid;
  String challenge_type;
  List<FileModel> files = new List<FileModel>.empty();
  bool error = false;
  _FileUploadWidgetState({required this.uuid, required this.challenge_type});

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getFileWidgets(files),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: onFileUploadPressed,
            child: Text("Pridėti failą (Max 20MB)")),
      ],
    );
  }

  Widget getFileWidgets(List<FileModel> files) {
    List<Widget> list = List<Widget>.empty(growable: true);
    for (var i = 0; i < files.length; i++) {
      list.add(new GestureDetector(
          onTap: () {},
          child: Padding(
              padding: EdgeInsets.all(6),
              child: Text(files[i].file_name ?? "No name"))));
    }
    return new Column(
      children: list,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  Future<void> onFileUploadPressed() async {}
  // Future<Response?> getRequest(String endPoint) async {
  //   Response response;
  //   try {
  //     response = await _dio.get(endPoint);
  //   } on DioError catch (e) {
  //     print(e.message);
  //     throw Exception(e.message);
  //   }
  //   print(response.data);
  //   return response;
  // }

  Future loadFiles() async {
    // var result = await filesRepository.getFiles(uuid, challenge_type);

    setState(() {
      // files = result;
    });
  }

  void _msg(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Klaida. Failas, kurį bandėte įkelti, per didelis.',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.redAccent,
    ));
  }
}
