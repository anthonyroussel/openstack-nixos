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
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "cursive";
  version = "0.3.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-hk9tL/xbPD4LJ6+jUMrxUkpVAjkfsSitziFeRJ+yRKs=";
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
    stestrCheckHook
  ];

  pythonImportsCheck = [ "cursive" ];

  meta = {
    description = "Library for validation of digital signatures";
    homepage = "https://opendev.org/x/cursive";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
