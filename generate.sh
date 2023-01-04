#!/bin/sh
#
#
export PATH=$GOPATH/src/github.com/hyperledger/fabric/build/bin:${HOME}/fabric-samples/bin:${PWD}:$PATH
export FABRIC_CFG_PATH=${PWD}
CHANNEL_NAME=mychannel

# remove previous crypto material and config transactions
rm -fr config
rm -fr crypto-config/*
mkdir config
# generate crypto material
cryptogen generate --config=./crypto-config.yaml
if [ "$?" -ne 0 ]; then
  echo "Failed to generate crypto material..."
  exit 1
fi

# generate genesis block for orderer
configtxgen -profile OneOrgOrdererGenesis -outputBlock ./config/genesis.block
if [ "$?" -ne 0 ]; then
  echo "Failed to generate orderer genesis block..."
  exit 1
fi

# generate channel configuration transaction
configtxgen -profile OneOrgChannel -outputCreateChannelTx ./config/channel.tx -channelID $CHANNEL_NAME
if [ "$?" -ne 0 ]; then
  echo "Failed to generate channel configuration transaction..."
  exit 1
fi

# generate anchor peer transaction은 필요하지 않은 것 같다.
# templates/generate-template.sh 참조

# generate.sh 수행 시 crypto-config, config directory 확인
# $ tree config
# $ tree crypto-config -L 2


