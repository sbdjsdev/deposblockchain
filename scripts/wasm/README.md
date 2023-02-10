# WASM Contract Scripts

## Start chain

```sh
../../startnode.sh
```

## Upload contracts

```sh
BINARY='deposd'
DENOM='udepos'
CHAIN_ID='localnet-1'
NODE='http://localhost:26657'

bash upload-contracts.sh <key-name>
```
