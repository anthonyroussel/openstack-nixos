{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  bcrypt,
  debtcollector,
  jinja2,
  oslo-config,
  oslo-context,
  oslo-i18n,
  oslo-utils,
  statsd,
  stevedore,
  webob,

  # checks
  oslo-serialization,
  oslotest,
  stestr,
}:

buildPythonPackage rec {
  pname = "oslo-middleware";
  version = "6.6.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_middleware";
    inherit version;
    hash = "sha256-bMucgPGJ/rxcxQ4RPA6JTJksNpff1v5yL/hPzNtbpSY=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    bcrypt
    debtcollector
    jinja2
    oslo-config
    oslo-context
    oslo-i18n
    oslo-utils
    pbr
    statsd
    stevedore
    webob
  ];

  nativeCheckInputs = [
    oslo-serialization
    oslotest
    stestr
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_middleware" ];

  meta = {
    description = "Oslo Middleware library";
    homepage = "https://github.com/openstack/oslo.middleware";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
