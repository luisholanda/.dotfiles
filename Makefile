LUA_SRC := $(shell find . -type f -name "*.lua")
NIX_SRC := $(shell find . -type f -name "*.nix")

fmt: $(LUA_SRC) $(NIX_SRC)
	@nixfmt -w88 $(NIX_SRC)
	@lua-format -i $(LUA_SRC)

install:
	doas nixos-rebuild switch
