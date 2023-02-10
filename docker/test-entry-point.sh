#!/bin/sh

CHAINID=$1
GENACCT=$2

if [ -z "$1" ]; then
  echo "Need to input chain id..."
  exit 1
fi

if [ -z "$2" ]; then
  echo "Need to input genesis account address..."
  exit 1
fi

# Build genesis file incl account for passed address
coins="100000000000ustarx,100000000000ucredits"
deposd init --chain-id $CHAINID $CHAINID
deposd keys add validator --keyring-backend="test"
deposd add-genesis-account validator $coins --keyring-backend="test"
deposd add-genesis-account $GENACCT $coins --keyring-backend="test"
deposd gentx --name validator --amount 1000000ustarx --keyring-backend="test"
deposd collect-gentxs


# Set proper defaults and change ports
sed -i 's/"leveldb"/"goleveldb"/g' ~/.deposd/config/config.toml
sed -i 's#"tcp://127.0.0.1:26657"#"tcp://0.0.0.0:26657"#g' ~/.deposd/config/config.toml
sed -i 's/timeout_commit = "5s"/timeout_commit = "1s"/g' ~/.deposd/config/config.toml
sed -i 's/timeout_propose = "3s"/timeout_propose = "1s"/g' ~/.deposd/config/config.toml
sed -i 's/index_all_keys = false/index_all_keys = true/g' ~/.deposd/config/config.toml

# Start the stake
deposd start --pruning=nothing
