# FootMark-iOS
발자국을 따라 떠올려 보세요

## iOS Developers

| <img src="https://avatars.githubusercontent.com/u/114901417?s=400&u=8ca676d247090a0114ef01f6ad113014241f8a6a&v=4" width="200"> | <img src="https://avatars.githubusercontent.com/u/90887498?v=4" width="200"> |
| :----------------------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------: |
|                                                             박신영                                                             |                                    윤성은                                    |

### 개발 환경

<p align="left">
<img src ="https://img.shields.io/badge/Swift-5.9.2-ff69b4">
<img src ="https://img.shields.io/badge/Xcode-15.3-blue">
<img src ="https://img.shields.io/badge/iOS-17.0-orange">
<img src ="https://img.shields.io/badge/SPM-0.9.0-green">
<br>

### 라이브러리

| 라이브러리(Library) | 버전(Version) | 사용목적(Purpose) |
| :------------------ | :------------ | :---------------- |
| SnapKit             | 5.7.1         | Layout            |
| Then                | 3.0.0         | Layout            |
| ElegantEmojiPicker  | main          | 이모지            |
| FSCalendar          | main          | 캘린더            |
| Moya                | 15.0.3        | 서버 통신         |
| DropDown            | master        | 드롭 다운         |
| KeychainSwift       | 24.0.0        | 보안 관련         |
| Firebase            | 10.27.0       | 소셜 로그인       |
| GoogleSignIn        | 7.1.0         | 구글 소셜 로그인  |
| KingFisher          | 7.12.0        | 이미지 캐싱       |
| LookinServer        | 1.2.8         | 뷰 계층 확인      |

<br>

## 빌드 방법

- clone 이후 Xcode에서 시뮬레이터를 설정하고, cmd + r 키를 누르면 자동으로 실행됩니다.
- 이후 Apple 혹은 Google 소셜 아이디를 이용한 로그인을 진행하시면 어플을 이용하실 수 있습니다.


<br>

## Code Convention

[https://github.com/StyleShare/swift-style-guide](https://github.com/StyleShare/swift-style-guide)

<br>

## Git Flow

1. 메인 레포에서 Fork 진행
   - 이후 Fork한 레포를 클론 받음
2. 메인 레포에서 이슈를 생성
   - 이슈 타이틀과 내용은 아래 Convention 규정을 지킴
   - Title은 아래 예시와 같이 컨벤션을 참고하여 작성
     - 예시: [Setting] - 프로젝트 초기 세팅 진행
   - 본인 라벨 + 작업에 맞는 라벨을 등록
3. 클론 받은 로컬 main 브랜치에서 새로운 브랜치 생성
   - 브랜치 네임은 아래 Convention Prefix 이후 이슈번호를 같이 작성
     - 예시: Setting/#1
4. PR은 메인 레포에 develop 브랜치로 보낸다.
   - 이는 merge를 진행했을 때에 사고로 어플이 열리지 않는 불상사를 대비하기 위함
   - Title은 Issue와 같은 방식으로 작성
     - PR title 예시: [Setting] - 프로젝트 초기 세팅 구현 완료

<br>

## Commit Convention

```markdown
[Feat]: 새로운 기능 구현
[Design]: just 화면. 레이아웃 조정
[Fix]: 버그, 오류 해결, 코드 수정
[Add]: Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 View 생성
[Del]: 쓸모없는 코드, 주석 삭제
[Refactor]: 전면 수정이 있을 때 사용합니다
[Remove]: 파일 삭제
[Chore]: 그 이외의 잡일/ 버전 코드 수정, 패키지 구조 변경, 파일 이동, 파일이름 변경
[Docs]: README나 WIKI 등의 문서 개정
[Comment]: 필요한 주석 추가 및 변경
[Setting]: 프로젝트 세팅
[Merge]: 머지
```

- 방식 : [Prefix] #이슈번호 - 내용작성
  - 예시 : [Setting] #1 - 프로젝트 폴더링
