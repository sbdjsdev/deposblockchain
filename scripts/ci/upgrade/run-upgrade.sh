set -ex
set -o pipefail
DENOM=udepos
CHAINID=deposnetwork
RLYKEY=stars12g0xe2ld0k5ws3h7lmxc39d4rpl3fyxp5qys69
deposd version --long
apk add -U --no-cache jq tree curl wget
DEPOSNETWORK_HOME=/deposnetwork/deposd
curl -s -v http://deposnetwork:8090/kill || echo "done"
sleep 10
deposd start --pruning nothing --home $DEPOSNETWORK_HOME
