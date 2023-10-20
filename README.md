# 권나영

마미톡 사전과제

진행 기간: 2023.10.13 ~ 2023.10.20

노션 링크: https://wiry-launch-6ab.notion.site/98da08fe4fa046b38dca50b8ebdfba19?pvs=4

<br>

## 개발환경 및 라이브러리

deployment target: iOS 15.0
- 개발 환경
    - swift 5.8.1
    - xcode version 14.3.1 
- 라이브러리
    - RxSwift 6.6.0, snapKit 5.6.0

<br>

## 아키텍쳐 선정
- `MVVM + RxSwift + CleanArchitecture`로 프로젝트를 구성했습니다.
- 클린아키텍쳐에 맞게 디렉토리 구조를 나누었습니다.
- 애플의 의존성 관리도구인 `SPM`으로 라이브러리를 설치했습니다. 
- Code Base-UI에 도전하기 위해서 스토리보드는 삭제했습니다.
- 기기별 점유율을 알아보니 iOS 15, 16을 사용하는 유저가 98% 이상으로 최소 버전을 iOS 15로 설정해주었습니다.

<br>

## 작동 화면
스크롤 | 화면전환|
---|---|
<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/e29d30b1-856b-4fdf-a4c0-3218cd0a6ed3" width="300" height="600">|<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/f4e50c1b-1eba-42af-b5ea-909a8ebef45d" width="300" height="600">

<br>


## Clean Architecture + MVVM
<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/c1959f9f-fb47-40ec-9e2c-a6856fea9730" width="700" height="300">



- `클린 아키텍쳐`를 적용하여 presentation, Domain, Data로 Layer를 구분하여 설계
- 프레젠테이션 레이어에서 View와 Presentation 로직을 분리하여 `MVVM` 패턴 적용
- `Input/Output` 모델링을 통해 View로부터 전달된 이벤트는 `Input`, View로 전달할 데이터는 `Output`을 통해 바인딩
- ViewModel은 뷰의 UI이벤트를 받아 뷰모델에 해당하는 `UseCase`를 사용
- MVVM 패턴에 맞게 단방향 데이터 바인딩을 수월하게 해주는 RxCocoa, RxSwift 사용
- `화면 전환` 및 의존성 주입을 담당하는 Coordinator 설계


<br>


### UI
- CollectionView로 쇼핑몰 목록 구현
- 부드러운 애니메이션을 위해 `DiffableDtatSource` 및 `Compositional Layout` 활용
- `snapshots`이라는 개념을 이용해 UI 상태 관리 간소화
- 로딩중임을 나타내기 위해 FooterView 활용

쇼핑리스트 | 품절표시 | FooterView |
---|---|---|
<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/cc432370-9e75-4a19-92fa-de6b12273209" width="250" height="500">|<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/679b15ca-82b1-477f-b5f8-51256c75e8f5" width="250" height="500">|<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/6a52a206-4cb2-4027-93f5-867e5f18ceca" width="270" height="500">

<br>

### Compositional Layout
- `Dynamic Cell Height`를 구현하여 내용에 따라 자동으로 셀이 늘어나도록 구현
- item, group, section을 구성하여 각 요소들의 사이즈를 정하고 레이아웃 지정

section | group |
---|---|
<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/2b2a13a9-0b24-4fcf-9fd2-fefa61e41756" width="300" height="300">|<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/ed66435e-d1a9-465e-a34e-28cf6e3b52b7" width="300" height="300">

<br>

### 네트워크
- API마다 독립적인 구조체 타입으로 관리하도록 구현
- APIRequest 타입을 채택하여 유지보수에 용이한 구조가 되도록 함

APIProtocol | APIRequest
---|---|
<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/70575d53-b88b-4902-beda-cf271bc90892" width="400" height="150">|<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/c8517fc3-6de2-4e49-b6de-860c1486ff52" width="300" height="200">


<br>


### 코디네이터
- `Coordinator` 를 통해 의존성 주입을 관리하고, 화면전환 역할을 전담하도록 설계
- TabBar 마다 개별적인 NavigationController를 가지도록 구현


<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/09c9fb52-63dd-416b-ac17-ae94b68a4d7a" width="500" height="300">


<br>

### 이미지 캐싱
- 메모리 캐시 구현(`NSCache`)
- 디스크 캐시 구현(`FileManager`)
- 캐시된 이미지가 없는경우 네트워크 다운로드


<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/e0df6998-a0cf-4d68-80b1-cbc9b807cd36" width="500" height="250">


<br>

### 무한스크롤
- `화면의 끝에 닿았을 때` 새로운 제품을 가져오도록 구현
- 로딩중 임을 알려 ux를 좀 더 자연스럽게 만들기
- 스크롤시 `통신을 한번만` 하도록 구현


<img src="https://github.com/na-young-kwon/mmtalk/assets/74536728/95954e83-cb0c-4fc3-966b-b87b2b122c5d" width="300" height="600">


<br>


