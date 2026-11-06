# devenv: a reproducible dev environment built on Nix (same setup as polling-hub and Civera).
#
# This site is plain static files (HTML, CSS, JS, images), so the only thing we need locally is a
# small web server that serves this folder, the same way GitHub Pages does in production.
#
#   devenv up      start the local server, then open http://localhost:8080 (Ctrl+C to stop)
#   devenv shell   just enter the environment (python3 and git available)
#
# There is no live reload: save a file, then refresh the browser.
# Docs: https://devenv.sh
{ pkgs, ... }:

{
  # Command-line tools available inside the shell. Python comes from Nix, so it's the same
  # version every time, independent of whatever Python macOS or Homebrew has.
  packages = [
    pkgs.git
    pkgs.python3
  ];

  # Long-running processes started by `devenv up`.
  # `python3 -m http.server` is Python's built-in static file server (a standard-library module,
  # nothing to install). --bind 127.0.0.1 keeps it reachable only from this Mac, not the network.
  processes.site.exec = "python3 -m http.server 8080 --bind 127.0.0.1";

  enterShell = ''
    echo "portfolio-site dev shell: python $(python3 --version | cut -d' ' -f2)"
    echo "  devenv up   serve the site at http://localhost:8080"
  '';
}
