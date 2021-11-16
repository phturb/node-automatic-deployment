sudo apt install jq

mkdir cronos

cd cronos

curl -LOJ https://github.com/crypto-org-chain/cronos/releases/download/v0.6.1/cronos_0.6.1_Linux_x86_64.tar.gz

tar -zxvf cronos_0.6.1_Linux_x86_64.tar.gz

rm -f cronos_0.6.1_Linux_x86_64.tar.gz

cd ..

./cronos/bin/cronosd init project-node-poly --chain-id cronosmainnet_25-1

curl https://raw.githubusercontent.com/crypto-org-chain/cronos-mainnet/master/cronosmainnet_25-1/genesis.json > ~/.cronos/config/genesis.json

sed -i.bak -E 's#^(minimum-gas-prices[[:space:]]+=[[:space:]]+).*$#\1"5000000000000basecro"#' ~/.cronos/config/app.toml

sed -i.bak -E 's#^(persistent_peers[[:space:]]+=[[:space:]]+).*$#\1"0d5cf1394a1cfde28dc8f023567222abc0f47534@cronos-seed-0.crypto.org:26656,3032073adc06d710dd512240281637c1bd0c8a7b@cronos-seed-1.crypto.org:26656,04f43116b4c6c70054d9c2b7485383df5b1ed1da@cronos-seed-2.crypto.org:26656"#' ~/.cronos/config/config.toml

sed -i.bak -E 's#^(create_empty_blocks_interval[[:space:]]+=[[:space:]]+).*$#\1"5s"#' ~/.cronos/config/config.toml

sed -i.bak -E 's#^(timeout_commit[[:space:]]+=[[:space:]]+).*$#\1"5s"#' ~/.cronos/config/config.toml

# export CRONOS_HOME=~/.cronos
export PATH=$PATH:~/cronos/bin

curl -s https://raw.githubusercontent.com/crypto-org-chain/cronos-docs/master/systemd/create-service.sh -o create-service.sh && curl -s https://raw.githubusercontent.com/crypto-org-chain/cronos-docs/master/systemd/ethermintd.service.template -o cronosd.service.template

chmod +x ./create-service.sh && ./create-service.sh

sudo systemctl start cronosd

sleep 5m

./cronos/bin/cronosd status 2>&1 | jq '.SyncInfo.catching_up'