import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage>
    with TickerProviderStateMixin {
  double turns = 0.0; //버튼 회전을 위한 state
  bool isClicked = false; //버튼 출근/퇴근 여부 state
  late AnimationController _controller; //버튼 안의 AnimatedIcon을 위한 controller
  int index = 0; //버튼 Color 변경을 위한 state

  //변수 that accesss to all methods in the API of 'Connectivity_plus 패키지'
  final Connectivity _connectivity = Connectivity();

  //핸드폰과 연결된 네트워크 정보를 가져오는 변수
  final info = NetworkInfo();

  //출근 버튼 클릭 권한 얻기
  //Permission handler_location(Network_info)
  getPermissionNetWorkInFo() async {
    //권한
    var status = await Permission.location.status;
    //권한이 허락되었을 때
    if (await Permission.location.isGranted) {
      print('wifi 접근 권한 허락됨');
      //핸드폰 wifi 연결 여부 TRUE ==> WIFI 이름 가져오기
      checkConnectivityWifi();
    }
    //권한이 거절되었을 떄
    else if (status.isDenied) {
      print('wifi 접근 권한 거절됨');
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
    //핸드폰이 wifi에 연결 되어있을 때
    if (connectivityResult == ConnectivityResult.wifi) {
      var wifiName = await info.getWifiName(); // FooNetwork
      print('wifi에 연결됨 / ${wifiName.toString()}');
      //현재 연결한 wifi 이름이 '회사 wifi 이름(AndroidWifi)과 같을 때, 버튼 클릭 가능
      if (wifiName == 'AndroidWifi') {
        //퇴근버튼 로직
        if (isClicked == true) {
          //버튼 회전/색 바꾸기
          setState(() {
            turns -= 1 / 2;
            index = 0;
            isClicked = !isClicked;
          });
          _controller.reverse();
          print('퇴근 완료');
        }
        //출근버튼 로직
        else {
          //버튼 회전/색 바꾸기
          setState(() {
            turns += 1 / 2;
            index = 1;
            isClicked = !isClicked;
          });
          _controller.forward();
          print('출근 완료');
        }
      }
      //현재 연결한 wifi 이름이 '회사 wifi 이름(AndroidWifi)과 다를 떄, 버튼 클릭 불가능
      else {
        //회사 WIFI 연결 요청 Dialog 보여주기.
        showDialog(
            context: (context),
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('회사 WIFI에 연결 해주세요 !!'),
                actions: [
                  TextButton(
                    child: Text('WIFI 설정 열기'),
                    onPressed: () {
                      //WIFI설정창을 열어준다.
                      AppSettings.openWIFISettings();
                    },
                  ),
                  TextButton(
                      child: Text('닫기'),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              );
            });
      }
    }
    //wifi에 연결되어 있지 않을 때
    else {
      //회사 WIFI 연결 요청 Dialog 보여주기.
      showDialog(
          context: (context),
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('회사 WIFI에 연결 해주세요 !!'),
              actions: [
                TextButton(
                  child: Text('WIFI 설정 열기'),
                  onPressed: () {
                    //WIFI설정창을 열어준다.
                    AppSettings.openWIFISettings();
                  },
                ),
                TextButton(
                    child: Text('닫기'),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            );
          });
    }
  }

  @override
  void initState() {
    //버튼 안의 AnimatedIcon을 위한 controller 선언
    _controller =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    //버튼 안의 AnimatedIcon을 위한 controller 끄기
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //버튼에 애니메이션주기
              AnimatedRotation(
                curve: Curves.easeOutExpo,
                turns: turns,
                duration: Duration(seconds: 1),
                child: GestureDetector(
                  //출근/퇴근 버튼 로직
                  onTap: () async {
                    //출근 버튼 클릭 권한 얻기
                    await getPermissionNetWorkInFo();
                  },
                  //container 색 바뀌는 파트
                  child: AnimatedContainer(
                    curve: Curves.easeOutExpo,
                    duration: Duration(seconds: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: [Colors.green, Colors.red][index],
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 30.0,
                          offset: Offset(0, 0),
                          color: Colors.black,
                        ),
                      ],
                    ),
                    //Anumated Icon 파트
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: _controller,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
