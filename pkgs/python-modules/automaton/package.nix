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
  version = "3.3.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-1zz3um2kPvKt91xJ2tM0/SQRbO6g3U5roecgdAQ5opM=";
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
