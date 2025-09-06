{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  castellan,
  cryptography,
  oslo-i18n,
  oslo-log,
  oslo-serialization,
  oslo-utils,

  # checks
  mock,
  oslotest,
  stestr,
}:

buildPythonPackage rec {
  pname = "cursive";
  version = "0.2.3";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-9DX2zb5qUX8FTBEFw25DbXhoEk8bIn0xD+gJ2RiowQw=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    castellan
    cryptography
    oslo-i18n
    oslo-log
    oslo-serialization
    oslo-utils
  ];

  nativeCheckInputs = [
    mock
    oslotest
    stestr
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "cursive" ];

  meta = {
    description = "Library for validation of digital signatures";
    homepage = "https://opendev.org/x/cursive";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
