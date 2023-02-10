set -ex
mkdir -p ~/.hermes/
cp ./scripts/ci/hermes/config.toml ~/.hermes/
hermes keys add deposnetwork -f $PWD/scripts/ci/hermes/deposnetwork.json
hermes keys add gaia -f $PWD/scripts/ci/hermes/gaia.json
hermes keys add osmosis -f $PWD/scripts/ci/hermes/osmosis.json
hermes create channel deposnetwork gaia --port-a transfer --port-b transfer
hermes create channel deposnetwork osmosis --port-a transfer --port-b transfer
