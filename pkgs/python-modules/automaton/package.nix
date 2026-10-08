{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  prettytable,

  # checks
  oslotest,
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "automaton";
  version = "3.5.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-OJbQPTKLUuNBt90Tw+OWPw2kSsiKFgrAfnYaCH3ap+M=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    prettytable
  ];

  nativeCheckInputs = [
    oslotest
    stestrCheckHook
  ];

  pythonImportsCheck = [ "automaton" ];

  meta = {
    description = "Friendly state machines for Python";
    homepage = "https://github.com/openstack/automaton";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
