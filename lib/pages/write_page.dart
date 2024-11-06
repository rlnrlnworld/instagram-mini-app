import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WritePage extends StatelessWidget {
  WritePage({super.key});

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: _buildTextField(),
          ),
          Container(height: 20),
          _buildShareButton(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF1F2F3),
      title: const Text(
        '새 게시물',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _textController,
      expands: true,
      minLines: null,
      maxLines: null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        hintText: '문구를 작성하거나 설문을 추가하세요...',
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.black45,
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildShareButton(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
					_uploadPost(context);
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Color(0xFF4B61EF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '공유',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
    Future<void> _uploadPost(BuildContext context) async {
    try {
      // 에러가 발생할 가능성이 큰 코드를 실행

      // 게시물을 만들기 위해 필요한 재료들
      // - uid
      final String? uid = FirebaseAuth.instance.currentUser?.uid;
      // - username
      final String? username = FirebaseAuth.instance.currentUser?.displayName;
      // - description
      final String description = _textController.text;
      // - createdAt
      final Timestamp createdAt = Timestamp.now();
      // - imageUrl (없어도 됨)
      
      // 사진첩에서 사진 선택 및 업로드
      String? imageUrl = await _uploadImage(context);

      // Map으로 게시물을 표현할 수 잇다.
      final Map<String, dynamic> data = {
        "uid": uid,
        "username": username,
        "description": description,
        "createdAt": createdAt,
        "imageUrl": imageUrl,
      };

      // TextField가 비어있으면 게시물을 업로드하지 않음
      if (description.isEmpty) {
        return;
      }

      // Firestore의 posts 컬렉션에 게시물 추가하기
      await FirebaseFirestore.instance.collection("posts").add(data);

      // TextField 초기화
      _textController.clear();

      // 이전 페이지로 이동
      Navigator.pop(context);
    } catch (error) {
      // 에러가 발생시에는 catch에서 다 잡아줌.
      // 에러가 어떤 에러인지 적절하게 프린트 & 사용자에게 알려주는
      print(error);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("게시물 업로드에 실패했습니다."),
        ),
      );
    }
  }

    // 사진첩에서 사진을 선택하고 Storage에 업로드하여 이미지 URL을 반환합니다.
  Future<String?> _uploadImage(BuildContext context) async {
    try {
      // 사진첩에서 사진 선택
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }

      final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Storage에 업로드할 위치 설정하기
      final String pathName = '/user/$uid/$fileName';

      //Storage에 업로드
      File imageFile = File(image.path);
      await FirebaseStorage.instance.ref(pathName).putFile(imageFile);
      
      // 업로드한 이미지의 URL 가져오기
      final String imageUrl = await FirebaseStorage.instance.ref(pathName).getDownloadURL();

      return imageUrl;
      
    } catch (e) {
      // 오류 처리
      return null;
    }
  }
}