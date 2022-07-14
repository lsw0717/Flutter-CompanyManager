import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  //변수 that accesss to all methods in the API of 'Connectivity_plus 패키지'
  final Connectivity _connectivity = Connectivity();

  //핸드폰과 연결된 네트워크 정보를 가져오는 변수
  final info = NetworkInfo();

  //Permission handler_location(Network_info)
  getPermissionNetWorkInFo() async {
    //권한
    var status = await Permission.location.status;
    //권한이 허락되었을 때
    if (await Permission.location.isGranted) {
      print('권한 허락됨');
      //핸드폰 wifi 연결 여부 TRUE ==> WIFI 이름 가져오기
      checkConnectivityWifi();
    }
    //권한이 거절되었을 떄
    else if (status.isDenied) {
      print('권한 거절됨');
      //권한 요청을 띄어준다.
      Permission.location.request();
    }
    //유저가 아예 앱 설정에서 꺼놓은 경우 (status.isPermanentlyDenied)
    else if (status.isPermanentlyDenied) {
      //설정창을 열어준다.
      openAppSettings();
    }
  }

  //핸드폰 wifi 연결 여부 TRUE ==> WIFI 이름 가져오기
  checkConnectivityWifi() async {
    //현재 핸드폰과 연결된 wifi, 셀룰러, None 셋 중 하나의 status를 가져오는 변수
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    //핸드폰이 wifi에 연결 되었다면
    if (connectivityResult == ConnectivityResult.wifi) {
      var wifiName = await info.getWifiName(); // FooNetwork
      print('wifi에 연결됨');
      print(wifiName.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    getPermissionNetWorkInFo();
                  },
                  child: Text('출근')),
              ElevatedButton(onPressed: () {}, child: Text('퇴근')),
            ],
          ),
        ),
      ),
    );
  }
}
