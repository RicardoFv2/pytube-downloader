{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Python interpreter
    python310

    # Required Python packages
    (python310.withPackages (ps: with ps; [
      customtkinter
      yt-dlp
      moviepy
      requests
      tqdm
      packaging
    ]))

    # For video/audio processing
    ffmpeg
  ];

  shellHook = ''
    echo "Entering Nix shell for Pytube Downloader..."
    echo "Run 'python main.py' to start the application."
  '';
}
