package app_test

import (
	"testing"

	"github.com/trdtech/deposnetwork/testutil/simapp"
)

func TestAnteHandler(t *testing.T) {
	simapp.New(t.TempDir())
	// suite.app.BaseApp.NewContext(false, tmproto.Header{Height: 1, ChainID: "deposnetwork-1", Time: time.Now().UTC()})

}
