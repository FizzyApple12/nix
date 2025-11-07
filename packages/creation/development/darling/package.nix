{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch2,
  cmake,
  fuse,
  zlib,
  bzip2,
  openssl,
  libxml2,
  icu,
  lzfse,
  libiconv,
  nixosTests,
}:
stdenv.mkDerivation {
  pname = "darling";
  version = "v0.1.20251023";

  src = fetchFromGitHub {
    owner = "darlinghq";
    repo = "darling";
    rev = "c431326ef3060a0e9814394ed919263d9c8f3f10";
    hash = "";
  };

  # patches = [
  # Fix compilation
  # (fetchpatch2 {
  #   name = "cmake-cxx-standard-17.patch";
  #   url = "https://github.com/darlinghq/darling-dmg/pull/105/commits/b7c620f76a5f76748b3d14dd2a58e77f8b6ed0c0.patch";
  #   hash = "sha256-i1lisEiwYm4IxgKmBYnjscvW6ObT7XGLVbjW2i5yXV4=";
  # })
  # ];

  nativeBuildInputs = [cmake];
  buildInputs =
    [
      fuse
      openssl
      zlib
      bzip2
      libxml2
      icu
      lzfse
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [libiconv];

  CXXFLAGS = [
    "-DCOMPILE_WITH_LZFSE=1"
    "-llzfse"
  ];

  # passthru.tests = {
  # inherit (nixosTests) darling-dmg;
  # };

  meta = with lib; {
    homepage = "https://www.darlinghq.org/";
    description = "A translation layer that lets you run macOS software on Linux";
    mainProgram = "darling";
    platforms = platforms.unix;
    license = licenses.gpl3Only;
    maintainers = with maintainers; [FizzyApple12];
  };
}
