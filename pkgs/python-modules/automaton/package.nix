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
  stestr,
}:

buildPythonPackage rec {
  pname = "automaton";
  version = "3.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-BHZwiG6bwxbjkVwjsJLN5QHUnK4NN6k6xt3jS1BEssw=";
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
    stestr
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "automaton" ];

  meta = {
    description = "Friendly state machines for Python";
    homepage = "https://github.com/openstack/automaton";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
