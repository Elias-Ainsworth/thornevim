rec {
  mkKeymap = mode: key: action: { inherit mode key action; };
  mkKeymapWithOpts =
    mode: key: action: opts:
    (mkKeymap mode key action) // opts;
}
