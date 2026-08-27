{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  debtcollector,
  eventlet,
  greenlet,
  oslo-concurrency,
  oslo-config,
  oslo-i18n,
  oslo-log,
  oslo-utils,
  paste,
  pastedeploy,
  routes,
  webob,
  yappi,

  # checks
  cotyledon,
  futurist,
  oslotest,
  procps,
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "oslo-service";
  version = "4.8.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_service";
    inherit version;
    hash = "sha256-X4I1f0yLIL9AtTAmLIe4KdpKsWMd/m5YAez25dhsYKk=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    debtcollector
    eventlet
    greenlet
    oslo-concurrency
    oslo-config
    oslo-i18n
    oslo-log
    oslo-utils
    paste
    pastedeploy
    pbr
    routes
    webob
    yappi
  ];

  nativeCheckInputs = [
    cotyledon
    futurist
    oslotest
    procps # required to run ps
    stestrCheckHook
  ];

  disabledTests = [
    # Disable tests that requires networking
    "oslo_service.tests.test_wsgi.TestWSGIServerWithSSL.test_app_using_ipv6_and_ssl"
  ];

  pythonImportsCheck = [ "oslo_service" ];

  meta = {
    description = "Library for running OpenStack services";
    homepage = "https://github.com/openstack/oslo.service";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
