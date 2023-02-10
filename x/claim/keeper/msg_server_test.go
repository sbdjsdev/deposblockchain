package keeper_test

import (
	"context"
	"testing"
	"time"

	sdk "github.com/cosmos/cosmos-sdk/types"
	tmproto "github.com/tendermint/tendermint/proto/tendermint/types"
	"github.com/trdtech/deposnetwork/testutil/simapp"
	"github.com/trdtech/deposnetwork/x/claim/keeper"
	"github.com/trdtech/deposnetwork/x/claim/types"
)

func setupMsgServer(t testing.TB) (types.MsgServer, context.Context) {
	app := simapp.New(t.TempDir())
	ctx := app.BaseApp.NewContext(false, tmproto.Header{Height: 2, ChainID: "deposnetwork-1", Time: time.Now().UTC()})
	app.ClaimKeeper.CreateModuleAccount(ctx, sdk.NewCoin(types.DefaultClaimDenom, sdk.NewInt(10000000)))
	return keeper.NewMsgServerImpl(app.ClaimKeeper), sdk.WrapSDKContext(ctx)
}
