import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('메인 페이지'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('유저 이름'),
                accountEmail: Text('유저 이메일'),
                currentAccountPicture: CircleAvatar(),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              ListTile(
                title: Text('출퇴근'),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.pushNamed(context, '/attendance_page');
                },
              ),
              ListTile(
                title: Text('채팅 페이지'),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.pushNamed(context, '/chatting_page');
                },
              ),
            ],
          ),
        ),
        body: Text('메인 페이지'),
      ),
    );
  }
}
