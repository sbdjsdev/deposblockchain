set -ex
mkdir -p ~/.hermes/
cp ./scripts/ci/upgrade/config.toml ~/.hermes/
hermes keys add deposnetwork -f $PWD/scripts/ci/hermes/deposnetwork.json
hermes keys add gaia -f $PWD/scripts/ci/hermes/gaia.json
hermes keys add osmosis -f $PWD/scripts/ci/hermes/osmosis.json
hermes start
