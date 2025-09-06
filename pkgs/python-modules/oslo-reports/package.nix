{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  jinja2,
  oslo-config,
  oslo-i18n,
  oslo-serialization,
  oslo-utils,
  psutil,

  # checks
  greenlet,
  oslotest,
  stestr,
}:

buildPythonPackage rec {
  pname = "oslo-reports";
  version = "3.6.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_reports";
    inherit version;
    hash = "sha256-PckVrfKEMVT87vGHrl4YE8Cjjf8X+vOriEnU2mfpSZg=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    jinja2
    oslo-config
    oslo-i18n
    oslo-serialization
    oslo-utils
    psutil
  ];

  nativeCheckInputs = [
    greenlet
    oslotest
    stestr
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_reports" ];

  meta = {
    description = "OpenStack library for creating Guru Meditation Reports";
    homepage = "https://github.com/openstack/oslo.reports";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
