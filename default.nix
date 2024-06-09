{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  setuptools,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "pocket-api";
  version = "0.1.5";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "rakanalh";
    repo = "pocket-api";
    rev = "d8222dd34e3aa5e545f9b8ba407fa277c734ab82";
    hash = "sha256-DyLjDb3zvhqEPmLj6KMSsJwqmfxusNK/C30z4pYcl/8=";
  };

  nativeBuildInputs = [
    poetry-core
    setuptools
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  postCheck = ''
    # Confirm that the produced executable script is wrapped correctly and runs
    # OK, by launching it in a subshell without PYTHONPATH
    (
      unset PYTHONPATH
      echo "Testing that `isort --version-number` returns OK..."
      $out/bin/isort --version-number
    )
  '';

  preCheck = ''
    HOME=$TMPDIR
    export PATH=$PATH:$out/bin
  '';

  meta = with lib; {
    description = "A python wrapper around GetPocket API V3";
    homepage = "https://github.com/rakanalh/pocket-api";
    license = licenses.mit;
    maintainers = with maintainers; [ clementpoiret ];
    # mainProgram = "";
  };
}
