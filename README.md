# README

# iOS-Box-Office

|Title|Description|
|:---|:---|
|한 줄 소개|영화진흥위원회 OpenAPI를 활용하여 영화 정보를 확인할 수 있는 서비스를 제공한다.|
|프로젝트 진행기간| `23.04.24` ~ `23.05.16`|
|사용 Skill & Tool|`Xcode`, `Swift`, `DiffableDataSource`, `CollectionView`, `async/await` |
|사용 Design Pattern|`MVVM`|
|팀원|[Jason](https://github.com/JasonLee0223), [Lust3r](https://github.com/llimental)
|PR Link|[[PR #1] BoxOffice [STEP 1] Jason, Lust3r](https://github.com/tasty-code/ios-box-office/pull/1) </br>[[PR #2] BoxOffice [STEP 2] Jason, Lust3r](https://github.com/tasty-code/ios-box-office/pull/9)</br>[[PR #3] BoxOffice [STEP 3] Jason, Lust3r](https://github.com/tasty-code/ios-box-office/pull/15)|

## 🪧 역할 분배



## 🏢 프로젝트 구성
```swift
├── BoxOffice
│   ├── AppEnvironment
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Configuration
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   └── Contents.json
│   │   │   └── Contents.json
│   │   ├── BoxOffice+APIKEY.xcconfig
│   │   └── Info.plist
│   ├── Data
│   │   ├── DataStructure
│   │   │   └── MovieDTO
│   │   │       ├── Request
│   │   │       │   ├── BoxOfficeQueryParameters.swift
│   │   │       │   └── MovieDetailQueryParameters.swift
│   │   │       └── Response
│   │   │           ├── BoxOffice
│   │   │           │   ├── BoxOffice.swift
│   │   │           │   ├── BoxOfficeResult.swift
│   │   │           │   └── DailyBoxOfficeList.swift
│   │   │           └── MovieDetailInformation
│   │   │               ├── MovieDetailInformation.swift
│   │   │               ├── MovieInfo.swift
│   │   │               ├── MovieInfoResult.swift
│   │   │               └── SubClassification
│   │   │                   ├── Actor.swift
│   │   │                   ├── Audit.swift
│   │   │                   ├── Company.swift
│   │   │                   ├── Director.swift
│   │   │                   ├── Genre.swift
│   │   │                   ├── Nation.swift
│   │   │                   ├── ShowType.swift
│   │   │                   └── Staff.swift
│   │   └── Network
│   │       ├── APIEndPoint.swift
│   │       ├── Error
│   │       │   ├── HTTPErrorType.swift
│   │       │   ├── NetworkError.swift
│   │       │   └── URLComponentsError.swift
│   │       └── NetworkService.swift
│   ├── Domain
│   │   ├── DailyBoxOffice.swift
│   │   └── Section.swift
│   ├── Infrastructure
│   │   └── Network
│   │       ├── Endpoint
│   │       │   ├── EndPoint.swift
│   │       │   ├── Requestable.swift
│   │       │   └── Responsable.swift
│   │       └── Query
│   │           ├── APIMagicLiteral.swift
│   │           ├── Basic.swift
│   │           ├── Movie.swift
│   │           └── Show.swift
│   └── Presentation
│       ├── UserInterface
│       │   ├── Cells
│       │   │   ├── BoxOfficeListCell.swift
│       │   │   ├── RankView.swift
│       │   │   └── SummaryInformationView.swift
│       │   ├── HomeViewController.swift
│       │   └── View
│       │       └── Base.lproj
│       │           ├── LaunchScreen.storyboard
│       │           └── Main.storyboard
│       └── ViewModel
│           ├── BoxOfficeViewModel.swift
│           ├── Helper
│           │   ├── Converter.swift
│           │   ├── Getter.swift
│           │   └── Selector.swift
│           ├── Interface
│           │   ├── Convertible.swift
│           │   ├── Decidable.swift
│           │   └── Gettable.swift
│           └── MagicLiteral.swift
├── MockMovieJSONDecodingTest
│   ├── MockData
│   │   └── Movie.json
│   └── MockMovieJSONDecodingTest.swift
└── README.md

```

## 🧱UML
|||
|:---|:---|
|Data Layer|
|Data|InfraStructure|
|<img src = "https://hackmd.io/_uploads/HyqrDigH2.png">|<img src = "https://hackmd.io/_uploads/SkPCbolS2.png">|
|Domain Layer|
|Domain|
|<img src = "https://hackmd.io/_uploads/HkSn_olrh.png">||
|Presentation Layer|
|ViewController|
|<img src = "https://user-images.githubusercontent.com/92699723/238577744-7fc3770a-9584-4404-bd4b-0f1fb8a61fab.jpg">|
|ViewModel|Cells|
|<img src = "https://user-images.githubusercontent.com/92699723/238574369-0d0e5647-52c5-49f9-b2f5-142a4f513872.jpg">|<img src = "https://hackmd.io/_uploads/ryMHw3xrn.png">|



## 📚 Step 설명
### [ Step 1 ]
- 영화진흥위원회의 일별 박스오피스 API 문서의 데이터 형식을 고려하여 모델 타입을 구현
- 제공된 JSON 데이터를 구현한 Model 타입으로 Parsing 할 수 있는지에 대한 단위 테스트(Unit Test)를 진행

`CodingKey`를 통해 JSON으로 넘어오는 데이터와 모델의 이름을 매칭해주었고, MockData를 사용하여 구현한 모델에 데이터가 잘 파싱되는지 확인해봤습니다.

### [ Step 2 ]
- 네트워크 통신을 담당할 타입을 설계 및 구현
- 영화진흥위원회의 일별 박스오피스 API 문서의 데이터 형식을 고려하여 서버와 실제로 데이터를 주고받도록 구현
    - 오늘의 일일 박스오피스 조회
    - 영화 개별 상세 조회

`URLSession`을 사용하여 네트워크 통신을 하였고, 그 과정에서 단순히 데이터를 받아오는 것이 아니라 `EndPoint`를 활용하여 재사용성을 높일 수 있게 분리해봤습니다.

### [ Step 3 ]
- Step 2에서 구현한 네트워킹 기능을 통해 실제로 상품목록을 API 서버에 요청
- 어제의 박스오피스를 볼 수 있는 화면을 구현
- 리스트를 아래로 잡아끌어서 놓으면 리스트를 새로고침(당겨서 새로고침)
- 처음 목록을 로드할 때, 사용자에게 빈 화면만 보여주는 대신, 로드 중임을 알 수 있게 처리
- 화면 상단에는 날짜를 표기
- 리스트 형태로 박스오피스 정보를 표기
- 박스오피스 정보의 각 열에 표기할 필수정보
    - 맨 왼쪽에는 영화의 현재 등수를 표기
        - 신규 영화면 등수 아래에 신작이라고 표기
        - 기존 영화면 어제와 비교한 등락을 표기
            - 순위 상승 : 빨간 화살표 + 등락 편차
            - 순위 하락 : 파란 화살표 + 등락 편차
            - 변동 없음 : - 표기
    - 해당 일자의 관객수와 누적 관객수를 표기
        - 숫자가 세 자리 이상 넘어가면 ,를 활용하여 읽기 쉽도록 처리. 예) 10,000

`CollectionView`를 사용하여 뷰를 구성하는데, Modern하게 짜보고자 `Diffable Data Source`를 사용해보았습니다.
데이터를 요청하고 받아오는 과정에서 `notificationCenter`를 사용하였고, 이렇게 받아온 데이터를 반영하기 위해 `Diffable Data Source`의 `snapshot`을 이용했습니다.

## 🚀 트러블 슈팅
### 1. Diffable Data Source의 적용
기존의 `DataSource`와는 다르게 `Diffable Data Source`는 `Snapshot`을 이용하여 바뀐 부분을 알아채고 `apply()`라는 비교적 간단해진 메서드로 반영을 할 수 있다는 장점이 있습니다.
그러나 실제 구현을 해보니 `apply()`에 대한 이해의 부족으로 제대로 작동하지 않았습니다.

나중에 데이터가 바뀔 때, 기존의 데이터를 삭제하고 새로운 데이터를 받은 것을 append 해주는 방식으로 해결할 수 있었습니다.

```swift=
private func applySnapshot() {
    var snapshot = dataSource.snapshot()

    let previousItems = snapshot.itemIdentifiers(inSection: .main)
    snapshot.deleteItems(previousItems)

    self.boxOfficeViewModel.transformIntoDailyBoxOffice { dailyBoxOfficeStorage in

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.checkOfAnimatingActivityIndicator(isAnimated: false)

            snapshot.appendItems(dailyBoxOfficeStorage)
            self.dataSource.apply(snapshot)
        })
    }
}
```

### 2. NotificationCenter 사용
처음 로직에서는 `MVC` 패턴이었기에 `ViewController`의 `Task` 안에서 데이터 요청을 하고 `dailyBoxOfficeStorage`라는 프로퍼티에 추가 후 `snapshot`에 `apply()`를 했습니다.

이후 `MVVM` 패턴으로 변경하면서 `ViewController`는 이벤트만 처리하고, `ViewModel`이 해당 역할을 해야 하기에 분리하는 과정을 거쳤습니다.

과정을 간략하게 표현하면
**< ViewController >**
1. `Task`에서 `networkService`를 통해 `request`
2. `request` 결과 각각으로 `DailyBoxOffice` 생성
3. 생성된 `DailyBoxOffice`를 `Storage` 프로퍼티에 `append`
4. `snapshot`에 `apply`


**< ViewController - ViewModel - networkService >**
1. `networkService`에서 `request` 후 `notificationCenter post`로 결과를 알림
2. `ViewModel`에서 `observer`를 통해 결과를 가지고 `DailyBoxOffice`로 구성된 `Storage` 프로퍼티 생성
3. `ViewController`에서 `ViewModel`의 `Storage`를 가지고 `snapshot`에 `apply`

위와 같이 역할을 분리하는 과정에서 데이터 변경을 어떻게 알려줄까 하는 고민을 `NotificationCenter`와 `escaping closure`로 해결할 수 있었습니다.

```swift=
// NetworkService.swift

func loadData() {

    Task {
        let yesterdayDate = Getter.receiveCurrentDate.split(separator: "-").joined()
        let boxOfficeQueryParameters = BoxOfficeQueryParameters(targetDate: yesterdayDate)
        let swapResult = try await request(with: APIEndPoint.receiveBoxOffice(with: boxOfficeQueryParameters)).boxOfficeResult.dailyBoxOfficeList
        swap(to: swapResult)
        NotificationCenter.default.post(name: .loadedBoxOfficeData, object: networkResult)
    }
}
```

```swift=
// BoxOfficeViewModel.swift

func transformIntoDailyBoxOffice(completion: @escaping ([DailyBoxOffice]) -> () ) {

    NotificationCenter.default.addObserver(forName: .loadedBoxOfficeData, object: nil, queue: nil) { notification in

        guard let receivedFromNetworkService = notification.object as? [DailyBoxOfficeList] else { return }

        let temporaryStorage = receivedFromNetworkService.map { dailyBoxOfficeList in

            DailyBoxOffice(movieBrief: MovieBrief(movieName: dailyBoxOfficeList.movieName,
                                                  audienceCount: dailyBoxOfficeList.audienceCount,
                                                  audienceAccumulated: dailyBoxOfficeList.audienceAccumulate),
                           rank: Rank(rank: dailyBoxOfficeList.rank,
                                      rankVariation: dailyBoxOfficeList.rankVariation,
                                      rankOldAndNew: dailyBoxOfficeList.rankOldAndNew))
        }
        completion(temporaryStorage)
    }

    DispatchQueue.global().async {
        self.networkService.loadData()
    }
}
```

```swift=
// HomeViewController.swift

private func applySnapshot() {
    var snapshot = dataSource.snapshot()

    let previousItems = snapshot.itemIdentifiers(inSection: .main)
    snapshot.deleteItems(previousItems)


    self.boxOfficeViewModel.transformIntoDailyBoxOffice { dailyBoxOfficeStorage in

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.checkOfAnimatingActivityIndicator(isAnimated: false)

            snapshot.appendItems(dailyBoxOfficeStorage)
            self.dataSource.apply(snapshot)
        })
    }
}
```

## 📱 구현화면
<img src = "https://user-images.githubusercontent.com/92699723/238539079-0c0f9609-9e98-4999-972d-bcb815181751.gif">
