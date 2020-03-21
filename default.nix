{}:

with import <nixpkgs> {};

stdenv.mkDerivation rec {

  version = "3.5.765.990";
  name = "tresorit-${version}";

  src = fetchurl {
    url = https://installerstorage.blob.core.windows.net/public/install/tresorit_installer.run;
    sha256 = "04hp4wv3h3hkqa1hdhwx3ks8v1zhxwj5pphq1q6782yksn470siq";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ xorg.libXext
                  xorg.libxcb
                  xorg.libX11
                  fuse
                  libGL ];

  dontBuild = true;
  dontConfigure = true;
  dontMake = true;

  unpackPhase  = ''
    tail -n+94 $src | tar xz -C $TMP
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -rf $TMP/tresorit_x64/* $out/bin/
    rm $out/bin/uninstall.sh
  '';

  meta = with stdenv.lib; {
    description = "Tresorit is the ultra-secure place in the cloud to store, sync and share files easily from anywhere, anytime.";
    homepage = https://tresorit.com;
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = [ maintainers.apeyroux ];
  };
}
