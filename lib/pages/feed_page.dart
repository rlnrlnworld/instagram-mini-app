import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:instagram/data/post.dart';
import 'package:instagram/pages/login_page.dart';
import 'package:instagram/pages/write_page.dart';
import 'package:instagram/widgets/post_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Post> _posts = [];
  List<String?> _activeUsers = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _loadActiveUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color(0xFFF1F2F3),
      body: SafeArea(
        child: ListView(
          children: [
            _buildActiveUsers(),
            // 인스타그램 피드 카드
            for (final item in _posts)
              PostWidget(
                item: item,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () {
        // 로그아웃 처리
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ),
        );
      }),
    );
  }

  AppBar _buildAppBar() {
    // remote config 값 중 참조하여 AppBar에 표시
    final bool isWriteButtonRed = FirebaseRemoteConfig.instance.getBool("write_button_red");
    return AppBar(
      backgroundColor: const Color(0xFFF1F2F3),
      title: Image.asset(
        'assets/logo2.png',
        width: 120,
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16),
          child: IconButton(
            icon: Icon(Icons.add_box_outlined, color: isWriteButtonRed ? Colors.red : Colors.black,),
            onPressed: () {
	            // 글쓰기 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return WritePage();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _loadPosts() {
  FirebaseFirestore.instance
      .collection('posts')
      .orderBy("createdAt", descending: true)
      .snapshots()
      .listen((snapshot) {
    final List<Post> posts = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Post(
        uid: data['uid'] as String,
        username: data['username'] as String,
        description: data['description'] as String,
        imageUrl: data['imageUrl'],
        likes: (data['likes'] as List<dynamic>? ?? []).map((like) {
          return Like(
            uid: like['uid'] as String,
            username: like['username'] as String,
          );
        }).toList(),
        comments: (data['comments'] as List<dynamic>? ?? []).map((comment) {
          return Comment(
            uid: comment['uid'] as String,
            username: comment['username'] as String,
            comment: comment['comment'] as String,
            createdAt: (comment['createdAt'] as Timestamp).toDate(),
          );
        }).toList(),
        createdAt: data['createdAt'] as Timestamp,
      );
    }).toList();

    setState(() {
      _posts = posts;
    });
  });
}

void _loadActiveUsers() {

    FirebaseDatabase.instance.ref().child('active_users').onValue.listen(
      (event) {
        setState(() {
          _activeUsers = List<String?>.from(
            event.snapshot.value as List<dynamic>,
          );
        });
      },
    );
  }

// 접속한 사용자 리스트
  Widget _buildActiveUsers() {
    return Container(
      height: 100,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        children: [
          // 현재 접속한 사용자 수를 Text 위젯으로 나타내기
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("🟢",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Now",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(221, 52, 155, 97),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _activeUsers.length.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(left: 5,right: 5),
            ),
          ),
          for (final userName in _activeUsers) 
	          _buildActiveUserCircle(userName),
        ],
      ),
    );
  }

	// 접속한 사용자 동그라미
  Widget _buildActiveUserCircle(String? userName) {
	  if (userName == null) {
      return const SizedBox.shrink();
    }
    return Container(
      width: 72,
      height: 72,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [
            Colors.yellow,
            Colors.orangeAccent,
            Colors.redAccent,
            Colors.purpleAccent,
          ],
          stops: [0.1, 0.4, 0.6, 0.9],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF1F2F3),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            userName,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

}