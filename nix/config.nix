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
    
    emacs26 = with pkgs.stdenv.lib; pkgs.stdenv.mkDerivation rec {
      name = "emacs26";
      verison = "26.1";
      src = pkgs.fetchurl {
        url = "mirror://gnu/emacs/emacs-26.1.tar.xz";
        sha256 = "0b6k1wq44rc8gkvxhi1bbjxbz3cwg29qbq8mklq2az6p1hjgrx0w";
      };
      enableParallelBuilding = true;
      nativeBuildInputs = with pkgs; [ pkgconfig autoconf automake texinfo ];
      buildInputs = with pkgs; [
        ncurses
        libxml2
        gnutls
        gettext
        libpng
        libjpeg
        libungif
        libtiff
        librsvg
        imagemagick
        darwin.apple_sdk.frameworks.AppKit
        darwin.apple_sdk.frameworks.GSS
        darwin.apple_sdk.frameworks.ImageIO
      ];
      #propagatedBuildInputs = [ AppKit GSS ImageIO ];
      hardeningDisable = [ "format" ];
      configureFlags = [ "--with-modules" "--with-ns" "--disable-ns-self-contained" ];
      preConfigure = ''
        ./autogen.sh
        substituteInPlace lisp/international/mule-cmds.el \
          --replace /usr/share/locale ${pkgs.gettext}/share/locale
        for makefile_in in $(find . -name Makefile.in -print); do
          substituteInPlace $makefile_in --replace /bin/pwd pwd
        done
      '';
      installTargets = "tags install";
      postInstall = ''
        mkdir -p $out/share/emacs/site-lisp
        cp ${./site-start.el} $out/share/emacs/site-lisp/site-start.el
        $out/bin/emacs --batch -f batch-byte-compile $out/share/emacs/site-lisp/site-start.el
        
        rm -rf $out/var
        rm -rf $out/share/emacs/${version}/$srcdir
        
        mkdir -p $out/Applications
        mv nextstep/Emacs.app $out/Applications
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
        # emacs25Macport
        emacs26
        ffmpeg
        fish
        fswatch
        git
        html-tidy
        idris
        leiningen
        libffi
        llvm_5
        maven
        ncurses
        ncurses.dev
        neovim
        nodePackages.tern
        openssl
        openssl.dev  # for Laurence's confluence sync tool
        pkgconfig
        python35
        python35Packages.pip
        python35Packages.virtualenv
        scala
        shellcheck
        stack
        travis
        tree
        wget
        which
        youtube-dl
      ];
    };

  };
}
