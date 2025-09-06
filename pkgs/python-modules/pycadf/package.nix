{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  pbr,
  setuptools,

  # dependencies
  oslo-config,
  oslo-serialization,

  # checks
  fixtures,
  pytestCheckHook,
  testtools,
}:

buildPythonPackage rec {
  pname = "pycadf";
  version = "4.0.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "openstack";
    repo = "pycadf";
    tag = version;
    hash = "sha256-jIpjOADfZmEX8ev3oBN8FiH41The/8X6SC5WetuLRMo=";
  };

  # Set version manually since prb reads from git, not tarball
  env.PBR_VERSION = version;

  build-system = [
    setuptools
    pbr
  ];

  dependencies = [
    oslo-config
    oslo-serialization
  ];

  nativeCheckInputs = [
    fixtures
    pytestCheckHook
    testtools
  ];

  pythonImportsCheck = [ "pycadf" ];

  meta = {
    description = "CADF Python module";
    homepage = "https://github.com/openstack/pycadf";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
