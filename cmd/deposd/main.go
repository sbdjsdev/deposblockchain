package main

import (
	"os"

	"github.com/CosmWasm/wasmd/x/wasm"
	svrcmd "github.com/cosmos/cosmos-sdk/server/cmd"
	"github.com/spf13/cobra"
	"github.com/tendermint/spm/cosmoscmd"
	"github.com/trdtech/deposnetwork/app"
	"github.com/trdtech/deposnetwork/cmd/deposd/cmd"
)

func main() {
	rootCmd, _ := cosmoscmd.NewRootCmd(
		"depos",
		app.AccountAddressPrefix,
		app.DefaultNodeHome,
		app.Name,
		app.ModuleBasics,
		app.NewDeposNetworkApp,
		cosmoscmd.AddSubCmd(cmd.TestnetCmd(app.ModuleBasics)),
		cosmoscmd.AddCustomInitCmd(cmd.InitCmd(app.ModuleBasics, app.DefaultNodeHome)),
		cosmoscmd.AddSubCmd(cmd.PrepareGenesisCmd(app.DefaultNodeHome, app.ModuleBasics)),
		cosmoscmd.CustomizeStartCmd(func(startCmd *cobra.Command) {
			wasm.AddModuleInitFlags(startCmd)
		}),
		cosmoscmd.AddSubCmd(cmd.AddGenesisWasmMsgCmd(app.DefaultNodeHome)),
		// this line is used by starport scaffolding # root/arguments
	)
	if err := svrcmd.Execute(rootCmd, app.DefaultNodeHome); err != nil {
		os.Exit(1)
	}
}
