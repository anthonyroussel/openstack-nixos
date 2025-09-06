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
  stestr,
  testscenarios,
}:

buildPythonPackage rec {
  pname = "futurist";
  version = "3.2.1";
  pyproject = true;

  src = fetchPypi {
    pname = "futurist";
    inherit version;
    hash = "sha256-Ad1PMKzfuy4utgkdpWXt7YLYy69sSKNsx/c8Ec+n+z8=";
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
    stestr
    testscenarios
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "futurist" ];

  meta = {
    description = "A collection of async functionality and additions from the future";
    homepage = "https://github.com/openstack/futurist";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
