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

    coreEnv = with pkgs;
    buildEnv {
      name = "coreEnv";
      paths = [
        ag
        alacritty
        ansible
        aspell
        aspellDicts.en
        autoconf
        automake
        bat
        cabal-install
        cabal2nix
        cachix
        cargo
        cmake
        cntlm
        curl
        emacs26
        enca
        ffmpeg
        fish
        fswatch
        ghc
        git
        gnupg
        gnuplot
        haskellPackages.alex
        haskellPackages.fast-tags
        haskellPackages.ghcid
        haskellPackages.happy
        haskellPackages.hasktags
        haskellPackages.hlint
        haskellPackages.hoogle
        haskellPackages.pandoc
        haskellPackages.stylish-haskell
        html-tidy
        idris
        imagemagick
        jq
        leiningen
        libffi
        llvm_6
        maven
        ncurses
        ncurses.dev
        neovim
        nix-prefetch-git
        nodePackages.tern
        openssl
        openssl.dev  # for Laurence's confluence sync tool
        pkgconfig
        python36
        python36Packages.ipython
        python36Packages.pip
        python36Packages.pygments
        python36Packages.virtualenv
        # rustup
        # rustracer
        ripgrep
        sbt
        scala
        shellcheck
        stack
        texlive.combined.scheme-full
        travis
        tree
        vagrant
        vault
        wget
        which
        youtube-dl
      ];
    };

  };
}
