{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  eventlet,
  oslo-concurrency,
  oslo-config,
  oslo-i18n,
  oslo-log,
  oslo-utils,

  # checks
  ddt,
  hacking,
  oslotest,
  pycodestyle,
  stestr,
}:

buildPythonPackage rec {
  pname = "os-win";
  version = "5.9.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-TUrVEiBgzdExLWkJkhxygMcVn6aBGpZvoRaI/BQYCMA=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    eventlet
    oslo-concurrency
    oslo-config
    oslo-i18n
    oslo-log
    oslo-utils
  ];

  nativeCheckInputs = [
    ddt
    hacking
    oslotest
    pycodestyle
    stestr
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "os_win" ];

  meta = {
    description = "Windows / Hyper-V library for OpenStack projects";
    homepage = "https://github.com/openstack-archive/os-win";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
