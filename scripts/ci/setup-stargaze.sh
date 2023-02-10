set -ex
DENOM=udepos
CHAINID=deposnetwork
RLYKEY=stars12g0xe2ld0k5ws3h7lmxc39d4rpl3fyxp5qys69
LEDGER_ENABLED=false make install
deposd version --long



# Setup deposnetwork
deposd init --chain-id $CHAINID $CHAINID
sed -i 's#tcp://127.0.0.1:26657#tcp://0.0.0.0:26657#g' ~/.deposd/config/config.toml
sed -i "s/\"stake\"/\"$DENOM\"/g" ~/.deposd/config/genesis.json
sed -i 's/pruning = "syncable"/pruning = "nothing"/g' ~/.deposd/config/app.toml
sed -i 's/enable = false/enable = true/g' ~/.deposd/config/app.toml
deposd keys --keyring-backend test add validator

deposd add-genesis-account $(deposd keys --keyring-backend test show validator -a) 100000000000$DENOM
deposd add-genesis-account $RLYKEY 100000000000$DENOM
deposd gentx validator 900000000$DENOM --keyring-backend test --chain-id deposnetwork
deposd collect-gentxs

deposd start --pruning nothing
