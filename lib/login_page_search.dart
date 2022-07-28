import 'package:flutter/material.dart';

class LoginPageSearch extends StatelessWidget {
  const LoginPageSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text('비밀번호 찾기',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            ),
            centerTitle: true,
          ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('가입 시 등록하신 이메일을 입력하시면, \n이메일로 비밀번호 재발급 링크를 전송해 드립니다.',
              style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal
              ),
              ),
              SizedBox(
                height: 22.0,
              ),
              Text('이메일 주소',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black45,
                  ),
                  hintText: 'name@example.com',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 375.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/main_page');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(330, 60),
                    ),
                    child: const Text(
                      'SEND',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
