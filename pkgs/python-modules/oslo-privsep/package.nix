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
  version = "3.13.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_privsep";
    inherit version;
    hash = "sha256-whzfj6VLGmORs4T/MVCPmv+lj2IX8pD8Xtldy0oKyds=";
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
