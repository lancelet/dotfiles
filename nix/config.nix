{
  packageOverrides = pkgs: rec {

    cntlm = with pkgs.stdenv.lib;
      let
        version = "0.92.3";
        name = "cntlm-${version}";
      in pkgs.stdenv.mkDerivation {
        inherit name;

        src = pkgs.fetchurl {
          url = "https://downloads.sourceforge.net/project/cntlm/cntlm/cntlm%20${version}/cntlm-${version}.tar.bz2";
          sha256 = "7b603d6200ab0b26034e9e200fab949cc0a8e5fdd4df2c80b8fc5b1c37e7b930";
        };

        buildInputs = with pkgs; [
          which
        ];

        preConfigure = ''
          sed -e 's/gcc/clang/' Makefile > Makefile.clang
          sed -i 's/CSS=.*/CSS="xlc_r gcc clang"/' configure
        '';

        installPhase = ''
          mkdir -p $out/bin; cp cntlm $out/bin/;
          mkdir -p $out/share/; cp COPYRIGHT README VERSION doc/cntlm.conf $out/share/;
          mkdir -p $out/man/; cp doc/cntlm.1 $out/man/;
        '';
      };

    coreEnv = with pkgs; buildEnv {
      name = "coreEnv";
      paths = [
        ag
        ansible
        aspell
        aspellDicts.en
        cmake
        cntlm
        curl
        emacs25Macport
        ffmpeg
        git
        html-tidy
        leiningen
        maven
        ncurses
        ncurses.dev
        neovim
        nodePackages.tern
        openssl
        openssl.dev  # for Laurence's confluence sync tool
        python36Packages.virtualenv
#        sbt
        scala
        shellcheck
        stack
        travis
        tree
#        vault # requires go; fails install
        wget
        which
        youtube-dl
        zsh
      ];
    };

  };
}
