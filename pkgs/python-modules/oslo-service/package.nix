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
  stestr,
}:

buildPythonPackage rec {
  pname = "oslo-service";
  version = "4.5.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_service";
    inherit version;
    hash = "sha256-qR9qNtQaOBgl/LFDlvEwVcukF0gonSMdSYk3lQDigOs=";
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
    stestr
  ];

  # Disable tests that requires networking
  checkPhase = ''
    runHook preCheck
    stestr run -e <(echo "
      oslo_service.tests.test_wsgi.TestWSGIServerWithSSL.test_app_using_ipv6_and_ssl
    ")
    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_service" ];

  meta = {
    description = "Library for running OpenStack services";
    homepage = "https://github.com/openstack/oslo.service";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
