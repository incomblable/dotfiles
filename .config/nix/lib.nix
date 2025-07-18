{ nixpkgs }:
let
  inherit (nixpkgs.lib)
    collect
    concatStringsSep
    filter
    hasPrefix
    hasSuffix
    isString
    mapAttrs
    mapAttrsRecursive
    pathType
    ;
in
rec {
  getDir =
    dir:
    mapAttrs (file: type: if type == "directory" then getDir "${dir}/${file}" else type) (
      builtins.readDir dir
    );

  mkStringPathList =
    path:
    if pathType path == "directory" then
      collect isString (mapAttrsRecursive (path: _type: concatStringsSep "/" path) (getDir path))
    else
      [ path ];

  recursiveImports =
    dir:
    map (file: if hasPrefix "/nix/store" file then file else dir + "/${file}") (
      filter (file: hasSuffix ".nix" file) (mkStringPathList dir)
    );

  mkSystem =
    fn:
    {
      hostname,
      modules ? [ ],
      system,
      specialArgs ? { },
    }:
    let
      pkgs' = import ../packages { pkgs = nixpkgs.legacyPackages.${system}; };
      unstable = unstable.legacyPackages.${system};
    in

    fn {
      inherit system;

      specialArgs = {
        inherit
          hostname
          pkgs'
          unstable
          ;
      } // specialArgs;

      modules = [
        ./machines/${hostname}/configuration.nix
        {
          nixpkgs.hostPlatform = system;
        }
      ] ++ modules;
    };
}
