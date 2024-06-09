## 강의: 풀스텍 서비스 프로그래밍

이 프로젝트는 경희대학교 2024_1학기 풀스텍 서비스 프로그래밍 강의에서 만든 IP 정보 어플리케이션입니다.
### 기술 스택
  - 언어: Dart
  - 프레임워크: Flutter
  - 코드 라인 수: 1002
### 
### **기능 소개**

1. **IP 정보 조회:**
    - 애플리케이션을 통해 궁금한 IP에 대한 정보와 상세 주소를 확인할 수 있습니다.
2. **내 IP 정보 조회:**
    - 본인의 내부 / 외부 IP의 정보를 쉽게 조회할 수 있습니다.
3. **지도 상의 IP 위치 조회:
    - 궁금한 IP에 대한 위치를 지도상에서 쉽게 확인할 수 있습니다.
4. **지도 상의 IP 간의 거리 조회:
    - 두 IP에 대한 거리를 조회할 수 있습니다.

### **IP_Map**

### Client

- GitHub Repository: [IP_Map_Client](https://github.com/himchan02-khu/ip_map_client.git)

**프로젝트 개요:**
IP Map Client는 Flutter를 사용하여 개발된 모바일 애플리케이션입니다. IP 주소에 관한 정보들을 확인할 수 있으며, 지도상에서도 확인 가능합니다.

### Server

- GitHub Repository: [IP_Map_Server](https://github.com/himchan02-khu/ip_map_server.git)

**프로젝트 개요:**
IP Map Server는 Node.js를 사용하여 개발된 서버 애플리케이션입니다. 클라이언트 애플리케이션에 필요한 주간과 IP 주소에 대한 정보와 상세주소를 제공합니다.

---

### **IP Map - 사용 설명서**

### Client

1. **프로젝트 클론:**
    
    ```bash
    bashCopy code
    git clone https://github.com/himchan02-khu/ip_map_client.git
    
    ```
    
2. **의존성 설치:**
    
    ```bash
    bashCopy code
    cd ip_map_client
    flutter pub get
    
    ```
    
3. **애플리케이션 실행:**
    
    ```bash
    bashCopy code
    flutter run
    
    ```
    
4. **애플리케이션 빌드:**
    
    ```bash
    bashCopy code
    flutter build apk
    
    ```
    

### Server

1. **프로젝트 클론:**
    
    ```bash
    bashCopy code
    git clone https://github.com/himchan02-khu/ip_map_server.git
    
    ```
    
2. **의존성 설치:**
    
    ```bash
    bashCopy code
    cd ip_map_server
    npm install
    
    ```
    
3. **서버 실행:**
    
    ```bash
    bashCopy code
    node app.js
    
    ```
    
4. **서버 접속:**[http://localhost:4242](http://localhost:4242/)

### **프로젝트 요약**

### 1. 구조 및 코드 위치

프로젝트는 Flutter로 개발되었으며, 다음과 같은 구조로 이루어져 있습니다.

```lua
luaCopy code
lib
|-- api
|   |-- api.dart  // 서버 base_url과 연결을 위한 파일 (localhost)
|-- models
|   |-- IP_Info.dart  // api.dart에서 받아온 데이터를 IP 정보 객체로 만드는 파일
|-- screens
|   |-- One_IP
|   |   |-- My_IP.dart		// 클라이언트 본인의 내부 IP / 외부 IP를 알려주는 페이지
|   |   |-- IP_Display.dart		// IP 주소의 정보를 보여주는 페이지
|   |   |-- Google_Map.dart	// IP 주소의 위치를 지도 상에 마커로 표시해주는 페이지
|   |-- Two_IP
|   |   |-- Input_Two.dart    // 두 IP 주소를 입력할 수 있는 페이지
|   |   |-- Two_IP_Display.dart	// 입력 받은 두 IP의 정보를 서버로부터 받아오는 페이지
|   |   |-- MapDistance.dart	// 두 IP 주소의 거리를 지도 상에 표현해주는 페이지
|-- main.dart  // 앱의 root 파일

```

### 2. 디자인 패턴

프로젝트는 다음과 같은 디자인 패턴을 채택하고 있습니다.

- **Api 모듈**
- **객체 모듈**
- **화면 구성**
- **Root(main.dart)**

### 3. 클라이언트가 관리하는 정보

**`models/movies.dart`** 파일에서 영화 정보를 담는 객체를 생성하고, 해당 객체는 다음의 데이터를 가집니다.

```dart
dartCopy code
String ip;		// IP 주소
String city;	// 도시 (ex: Suwon)
String region;	// 지역 (ex: Gyeonggi-do)
String country;	// 나라 (ex: KR)
String locate;	// 위치 (위도, 경도 – ex: 37.2484,127.0758)
String telecom;	// 회사번호 (ex: AS3786 LG DACOM Corporation)
String postal;	// 우편번호 (ex: 16702)
String time;	// 시간 시준 (ex: Asia/Seoul)

```

### 4. API 및 JSON 정보

- **API**
    - Base URL: [http://localhost:4242](http://localhost:4242/)
    - How to IP info search: http://localhost:4242/search?ip={IPaddress}
    - How to get one address: http://localhost:4242/address?lat={lat}&lon={lon}
    - How to get two address: http://localhost:4242/addresses?lat1={lat1}&lon1={lon1}&lat2={lat2}&lon2={lon2}

- **JSON Data 예시**

```json
jsonCopy code
[
  {
    "ip": "1.1.1.1",
    "city": "Englewood",
    "region": "Colorado",
    "country": "US",
    "locate": "39.6123,-104.8799",
    "telecom": "AS13335 Cloudflare, Inc.",
    "postal": "80111",
    "time": "America/Denver"
  }
]

```

### 5. 추가 기능 및 개발 계획

**IP 주소 조회 목록**

클라이언트 사용자가 조회한 IP 주소들을 목록을 통해 표현할 예정입니다. 이 기능은 아직 구현 중에 있으며, 사용자의 Local DB에 저장하여 개개인의 프라이버시를 지켜줄 것입니다. 또한 이 기능은 사용자에게 자신이 접속한 IP 주소에 대한 기억을 회상할 수 있는 기회를 제공합니다.

**VPN**

클라이언트 사용자가 안전하게 이용할 수 있도록 VPN 기능을 추가할 예정입니다. 이 기능을 사용하면 사용자의 개인 정보 노출 부담을 줄여주어 사용자에게 안정적인 서비스를 제공합니다.

**서버 데이터베이스 연결**

클라이언트 사용자가 동일한 호출을 여러번 할 경우 서버에 가해지는 부담이 커질 수 있기 때문에 서버의 데이터베이스와 연동시켜 중복 호출을 줄이고, 사용자에게 빠르고 안정적인 서비스를 제공할 수 있도록 연동시킬 계획입니다.


### 6. 개발의 지속성 및 서비스의 공개 여부

- 프로젝트는 지속적인 개발을 통해 기능을 확장하고 서비스를 향상시킬 예정입니다.
- 서비스는 공개하지 않지만 배포를 통해 앱의 배포 과정을 경험하고 포트폴리오에 추가할 예정입니다.
