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
  stestrCheckHook,
  testscenarios,
}:

buildPythonPackage rec {
  pname = "taskflow";
  version = "6.5.0";
  pyproject = true;

  src = fetchPypi {
    pname = "taskflow";
    inherit version;
    hash = "sha256-BVApBWjwKm3Dqb0Pzt5seVaJPayiq4PMf64XiAIPZD8=";
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
    stestrCheckHook
    testscenarios
  ];

  pythonImportsCheck = [ "taskflow" ];

  meta = {
    description = "OpenStack Library to complete workflows/tasks in HA manner";
    homepage = "https://github.com/openstack/taskflow";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
