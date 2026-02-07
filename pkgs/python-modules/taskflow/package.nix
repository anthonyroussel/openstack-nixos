{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  automaton,
  cachetools,
  debtcollector,
  fasteners,
  futurist,
  jsonschema,
  networkx,
  oslo-serialization,
  oslo-utils,
  pydot,
  tenacity,

  # checks
  alembic,
  etcd3gw,
  kazoo,
  kombu,
  oslotest,
  redis,
  sqlalchemy-utils,
  sqlalchemy,
  stestr,
  testscenarios,
  yahoo-zake,
}:

buildPythonPackage rec {
  pname = "taskflow";
  version = "6.1.1";
  pyproject = true;

  src = fetchPypi {
    pname = "taskflow";
    inherit version;
    hash = "sha256-ygzTK9yhrFUVM720sMNMfCJ3K9Y7i96I8g50ihEuW34=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    automaton
    cachetools
    debtcollector
    fasteners
    futurist
    jsonschema
    networkx
    oslo-serialization
    oslo-utils
    pbr
    pydot
    tenacity
  ];

  nativeCheckInputs = [
    alembic
    etcd3gw
    kazoo
    kombu
    oslotest
    redis
    sqlalchemy
    sqlalchemy-utils
    stestr
    testscenarios
    yahoo-zake
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "taskflow" ];

  meta = {
    description = "OpenStack Library to complete workflows/tasks in HA manner";
    homepage = "https://github.com/openstack/taskflow";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
