set -ex
set -o pipefail
DENOM=udepos
CHAINID=deposnetwork
RLYKEY=stars12g0xe2ld0k5ws3h7lmxc39d4rpl3fyxp5qys69
deposd version --long
apk add -U --no-cache jq tree
DEPOSNETWORK_HOME=/deposnetwork/deposd
deposd config keyring-backend test --home $DEPOSNETWORK_HOME

HEIGHT=$(deposd status --node http://deposnetwork:26657 --home $DEPOSNETWORK_HOME | jq .SyncInfo.latest_block_height -r)

echo "current height $HEIGHT"
HEIGHT=$(expr $HEIGHT + 20) 
echo "submit with height $HEIGHT"
deposd tx gov submit-proposal software-upgrade v5 --upgrade-height $HEIGHT  \
--deposit 10000000ustars \
--description "V5 Upgrade" \
--title "V5 Upgrade" \
--gas-prices 0.025ustars --gas auto --gas-adjustment 1.5 --from validator  \
--chain-id deposnetwork -b block --yes --node http://deposnetwork:26657 --home $DEPOSNETWORK_HOME --keyring-backend test

deposd q gov proposals --node http://deposnetwork:26657 --home $DEPOSNETWORK_HOME


deposd tx gov vote 1 "yes" --gas-prices 0.025ustars --gas auto --gas-adjustment 1.5 --from validator  \
--chain-id deposnetwork -b block --yes --node http://deposnetwork:26657 --home $DEPOSNETWORK_HOME --keyring-backend test
sleep 60
deposd q gov proposals --node http://deposnetwork:26657 --home $DEPOSNETWORK_HOME
sleep 60
