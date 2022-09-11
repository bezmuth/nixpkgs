{ lib
, stdenv
, fetchFromGitHub
, phpPackages
, pkgs
}:

let
  package = (import ./composition.nix {
    inherit pkgs;
    inherit (stdenv.hostPlatform) system;
    noDev = true; # Disable development dependencies
  });
in package.override rec {
  pname = "pixelfed";
  version = "UNSTABLE-01-09-2022";

  # GitHub distribution does not include vendored files
  src = fetchFromGitHub {
    owner = "pixelfed";
    repo = pname;
    # use an unstable version until a release contains composer.lock
    rev = "ee0cb393c642aa3781a7ed2eec43b3113843b566";
    hash = "sha256-cw/9oXz15tigMlOV8QW6/DIrRlXgQhpdSIexZUlxNOA=";
  };

  meta = with lib; {
    description = "wallabag is a self hostable application for saving web pages";
    longDescription = ''
      wallabag is a self-hostable PHP application allowing you to not
      miss any content anymore. Click, save and read it when you can.
      It extracts content so that you can read it when you have time.
    '';
    license = licenses.mit;
    homepage = "http://wallabag.org";
    changelog = "https://github.com/wallabag/wallabag/releases/tag/${version}";
    maintainers = with maintainers; [ bezmuth ];
    platforms = platforms.all;
  };
}
