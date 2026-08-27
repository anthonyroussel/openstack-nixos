{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  debtcollector,

  # checks
  eventlet,
  oslotest,
  stestrCheckHook,
  testscenarios,
}:

buildPythonPackage rec {
  pname = "futurist";
  version = "3.5.0";
  pyproject = true;

  src = fetchPypi {
    pname = "futurist";
    inherit version;
    hash = "sha256-l9AfYUS746vhshVcsrQtq07DPgn09/ffdWnzXZopqvc=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    debtcollector
  ];

  nativeCheckInputs = [
    eventlet
    oslotest
    stestrCheckHook
    testscenarios
  ];

  pythonImportsCheck = [ "futurist" ];

  meta = {
    description = "A collection of async functionality and additions from the future";
    homepage = "https://github.com/openstack/futurist";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
