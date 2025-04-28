{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    python312
    python312Packages.discordpy
    python312Packages.python-dotenv
    python312Packages.black
    python312Packages.flake8
  ];

  shellHook = ''
    if [ -f .env ]; then
      export $(grep -v '^#' .env | xargs)
      echo "Loaded .env → DISCORD_TOKEN is set."
    fi
  '';
}
