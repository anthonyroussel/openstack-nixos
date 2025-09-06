{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  cffi,
  debtcollector,
  eventlet,
  greenlet,
  oslo-config,
  oslo-i18n,
  oslo-log,
  oslo-utils,

  # checks
  oslotest,
  stestr,
}:

buildPythonPackage rec {
  pname = "oslo-privsep";
  version = "3.8.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_privsep";
    inherit version;
    hash = "sha256-c8TgZWvdsj9iD5FqIbZBPKADRIMUSllovKzt06NER/Y=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    cffi
    debtcollector
    eventlet
    greenlet
    oslo-config
    oslo-i18n
    oslo-log
    oslo-utils
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

  pythonImportsCheck = [ "oslo_privsep" ];

  meta = {
    description = "OpenStack library for privilege separation";
    homepage = "https://github.com/openstack/oslo.privsep";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
