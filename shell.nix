{ pkgs ? import <nixpkgs> {} }:

let
  # Define a custom python310 that overrides sphinx to a compatible version
  python310WithSphinxFix = pkgs.python310.override {
    packageOverrides = pythonSelf: pythonSuper: {
      sphinx = pythonSuper.sphinx.overrideAttrs (oldAttrs: {
        version = "7.3.11"; # Pinning to a known compatible version
      });
    };
  };

  # Use this custom python environment for the project's packages
  pythonEnv = python310WithSphinxFix.withPackages (ps: with ps; [
    customtkinter
    yt-dlp
    moviepy
    requests
    tqdm
    packaging
  ]);
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    pythonEnv
    ffmpeg
  ];

  shellHook = ''
    echo "Entering Nix shell for Pytube Downloader..."
    echo "Run 'python main.py' to start the application."
  '';
}
