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
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "oslo-reports";
  version = "3.9.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_reports";
    inherit version;
    hash = "sha256-ZuBWPVy1r8D6y6CPSJBkk9RKmgSH0Uo7ArEvtg7ZVRM=";
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
    stestrCheckHook
  ];

  pythonImportsCheck = [ "oslo_reports" ];

  meta = {
    description = "OpenStack library for creating Guru Meditation Reports";
    homepage = "https://github.com/openstack/oslo.reports";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
