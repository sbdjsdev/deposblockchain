set -ex
set -o pipefail
DENOM=udepos
CHAINID=deposnetwork
RLYKEY=stars12g0xe2ld0k5ws3h7lmxc39d4rpl3fyxp5qys69
deposd version --long
apk add -U --no-cache jq tree
DEPOSNETWORK_HOME=/deposnetwork/deposd

# Setup deposnetwork
deposd init --chain-id $CHAINID $CHAINID --home $DEPOSNETWORK_HOME
deposd config keyring-backend test --home $DEPOSNETWORK_HOME
sed -i 's#tcp://127.0.0.1:26657#tcp://0.0.0.0:26657#g' $DEPOSNETWORK_HOME/config/config.toml
sed -i "s/\"stake\"/\"$DENOM\"/g" $DEPOSNETWORK_HOME/config/genesis.json
sed -i 's/pruning = "syncable"/pruning = "nothing"/g' $DEPOSNETWORK_HOME/config/app.toml
sed -i 's/enable = false/enable = true/g' $DEPOSNETWORK_HOME/config/app.toml
sed -i 's/172800s/60s/g'  $DEPOSNETWORK_HOME/config/genesis.json
deposd keys --keyring-backend test add validator --home $DEPOSNETWORK_HOME
deposd add-genesis-account $(deposd keys --keyring-backend test show validator -a --home $DEPOSNETWORK_HOME) 10000000000000$DENOM --home $DEPOSNETWORK_HOME
deposd add-genesis-account $RLYKEY 10000000000000$DENOM --home $DEPOSNETWORK_HOME
deposd gentx validator 900000000$DENOM --keyring-backend test --chain-id deposnetwork --home $DEPOSNETWORK_HOME
deposd collect-gentxs --home $DEPOSNETWORK_HOME
/deposnetwork/bin/upgrade-watcher deposd start --pruning nothing --home $DEPOSNETWORK_HOME
