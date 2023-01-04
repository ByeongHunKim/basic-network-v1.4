# file directory

1. .env
2. crypto-config.yaml
3. configtx.yaml
4. generate.sh
5. docker-compose.yml
6. start.sh
7. teardown.sh

# .env setting

- `$ echo COMPOSE_PROJECT_NAME=net > .env`

```markdown
COMPOSE_PROJECT_NAME=net
```

## crypto-config.yaml

- cryptogen 툴이 crypto-config.yaml 파일 사용
- 이 파일을 이용해 organization과 그 구성원에게 인증서 발급
- organization의 peer 와 인증서 수 설정

## configtx.yaml

- configtxgen 툴이 configtx.yaml 파일 사용
- 네트워크의 채널과 genesis block 생성을 위한 설정
- anchor peer 설정 ( 필요 시 )
- orderer 설정
- 네트워크 전체의 구조 및 설정 내용 포함
- organization 생성

## generate.sh

- cryptogen, configtxgen 툴을 사용하여 블록체인 네트워크를 위한 요소들 생성해주는 스크립트
- 이전 crypto material & config transaction 삭제
- 새로운 crypto material 생성
  - genesis block for orderer
  - channel configuration transaction
  - anchor peer transaction ( 필요 시 )

### 질문

- cryptogen을 통해 인증서를 발급해주는 방식이 아니라 CA가 발급해주는게 맞지 않는가?

## docker-compose.yml

- 지금은 모든 구성, 나중엔 분리해야할 것 같다
- 여러 컨테이너를 일괄 관리할 수 있는 "docker compose" 의 구성 관리 파일
- docker-compose 파일 수정 요소
  - CA 컨테이너와 peer 컨테이너의 정의
  - CA 관리자 패스워드 변경 ( 필요 시 )
    - 컨테이너 이름 변경
    - CA private_key 연결
- CLI 컨테이너 구성 : 공유 directory working directory
- peer 추가
- DB ( level, couch ) 컨테이너 추가 및 수정

## start.sh

- 실행할 컨테이너 목록 수정
- start.sh를 수행하여 수행된 컨테이너 확인
