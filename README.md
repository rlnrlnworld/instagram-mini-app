# 📸 Instagram Mini App

![instagram-example](https://github.com/user-attachments/assets/1d6546fc-f9bc-4eea-b4b6-dd308bf05e5b)


Flutter와 Firebase를 활용해 학습 목적으로 개발한 Instagram mini app 프로젝트입니다. <br>이 프로젝트는 소셜 네트워크의 기본 기능을 구현하는 데 중점을 두고, 회원가입과 로그인 기능 및 데이터베이스 연동을 학습하기 위해 진행되었습니다.

## 목차

- [📜 프로젝트 개요](#-프로젝트-개요)
- [🎯 학습 목표](#-학습-목표)
- [✨ 기능](#-기능)
- [⚙️ 설치 및 실행](#️-설치-및-실행)
- [🛠️ 기술 스택](#️-기술-스택)
- [📂 디렉토리 구조](#-디렉토리-구조)
- [📄 라이선스](#-라이선스)

## 📜 프로젝트 개요

Instagram mini app은 개인 학습용 프로젝트로, 소셜 네트워크 애플리케이션의 기본적인 기능을 구현하여 Firebase를 활용한 백엔드 연동과 회원 관리 기능을 학습하는 데 중점을 두었습니다.

## 🎯 학습 목표
- Firebase Authentication을 통한 회원가입 및 로그인 기능 구현.
- Firestore 데이터베이스와의 데이터 등록 및 조회 기능 학습.
- Flutter로 프론트엔드 UI 구성과 데이터베이스 연동 연습.

## ✨ 기능
- 게시물 업로드: 사진과 텍스트로 구성된 게시물을 데이터베이스에 등록할 수 있습니다.
- 좋아요 및 댓글 수 조회: 게시물의 좋아요 수와 댓글 수를 받아와 조회할 수 있습니다.
- 회원가입 및 로그인: 사용자 계정을 생성하고 로그인할 수 있습니다.

## ⚙️ 설치 및 실행
1. 이 저장소를 클론합니다.
   ```bash
   git clone https://github.com/rlnrlnworld/instagram-mini-app.git
   cd instagram-mini-app
   ```
2. Flutter 환경을 설정하고 필요한 패키지를 설치합니다.
   ```bash
   flutter pub get
   ```
3. 애플리케이션을 실행합니다.
   ```bash
   flutter run
   ```

## 🛠️ 기술 스택

![Flutter](https://img.shields.io/badge/flutter-02569B?&style=for-the-badge&logo=flutter&logoColor=white)
![FireBase](https://img.shields.io/badge/firebase-DD2C00?&style=for-the-badge&logo=firebase&logoColor=white)

## 📂 디렉토리 구조

```bash
📦 Instagram mini app
├─ .gitignore
├─ .idx
│  └─ dev.nix
├─ .metadata
├─ README.md
├─ analysis_options.yaml
├─ android
│  ├─ .gitignore
│  ├─ app
│  │  ├─ build.gradle
│  │  ├─ google-services.json
│  │  └─ src
│  │     ├─ debug
│  │     │  └─ AndroidManifest.xml
│  │     ├─ main
│  │     │  ├─ AndroidManifest.xml
│  │     │  ├─ kotlin
│  │     │  │  └─ com
│  │     │  │     └─ lgdxschool
│  │     │  │        └─ instagram
│  │     │  │           └─ instagram
│  │     │  │              └─ MainActivity.kt
│  │     │  └─ res
│  │     │     ├─ drawable-v21
│  │     │     │  └─ launch_background.xml
│  │     │     ├─ drawable
│  │     │     │  └─ launch_background.xml
│  │     │     ├─ mipmap-hdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-mdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xxhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xxxhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ values-night
│  │     │     │  └─ styles.xml
│  │     │     └─ values
│  │     │        └─ styles.xml
│  │     └─ profile
│  │        └─ AndroidManifest.xml
│  ├─ build.gradle
│  ├─ gradle.properties
│  ├─ gradle
│  │  └─ wrapper
│  │     └─ gradle-wrapper.properties
│  └─ settings.gradle
├─ assets
│  ├─ logo.png
│  └─ logo2.png
├─ firebase.json
├─ ios
│  ├─ .gitignore
│  ├─ Flutter
│  │  ├─ AppFrameworkInfo.plist
│  │  ├─ Debug.xcconfig
│  │  └─ Release.xcconfig
│  ├─ Runner.xcodeproj
│  │  ├─ project.pbxproj
│  │  ├─ project.xcworkspace
│  │  │  ├─ contents.xcworkspacedata
│  │  │  └─ xcshareddata
│  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     └─ WorkspaceSettings.xcsettings
│  │  └─ xcshareddata
│  │     └─ xcschemes
│  │        └─ Runner.xcscheme
│  ├─ Runner.xcworkspace
│  │  ├─ contents.xcworkspacedata
│  │  └─ xcshareddata
│  │     ├─ IDEWorkspaceChecks.plist
│  │     └─ WorkspaceSettings.xcsettings
│  ├─ Runner
│  │  ├─ AppDelegate.swift
│  │  ├─ Assets.xcassets
│  │  │  ├─ AppIcon.appiconset
│  │  │  │  ├─ Contents.json
│  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │  └─ LaunchImage.imageset
│  │  │     ├─ Contents.json
│  │  │     ├─ LaunchImage.png
│  │  │     ├─ LaunchImage@2x.png
│  │  │     ├─ LaunchImage@3x.png
│  │  │     └─ README.md
│  │  ├─ Base.lproj
│  │  │  ├─ LaunchScreen.storyboard
│  │  │  └─ Main.storyboard
│  │  ├─ Info.plist
│  │  └─ Runner-Bridging-Header.h
│  └─ RunnerTests
│     └─ RunnerTests.swift
├─ lib
│  ├─ data
│  │  └─ post.dart
│  ├─ firebase_options.dart
│  ├─ main.dart
│  ├─ pages
│  │  ├─ feed_page.dart
│  │  ├─ login_page.dart
│  │  ├─ signup_page.dart
│  │  └─ write_page.dart
│  └─ widgets
│     └─ post_widget.dart
├─ pubspec.lock
├─ pubspec.yaml
└─ web
   ├─ favicon.png
   ├─ icons
   │  ├─ Icon-192.png
   │  ├─ Icon-512.png
   │  ├─ Icon-maskable-192.png
   │  └─ Icon-maskable-512.png
   ├─ index.html
   └─ manifest.json
```

## 📄 라이선스
이 프로젝트는 MIT 라이선스를 따릅니다.
