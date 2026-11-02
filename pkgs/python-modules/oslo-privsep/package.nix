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
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "oslo-privsep";
  version = "3.12.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_privsep";
    inherit version;
    hash = "sha256-Fm7c1KPpgvTqhRMI32QIvGrVMj+92DrWsqefrtULlhc=";
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
    stestrCheckHook
  ];

  pythonImportsCheck = [ "oslo_privsep" ];

  meta = {
    description = "OpenStack library for privilege separation";
    homepage = "https://github.com/openstack/oslo.privsep";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
