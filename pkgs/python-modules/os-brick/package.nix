{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  os-win,
  oslo-concurrency,
  oslo-config,
  oslo-context,
  oslo-i18n,
  oslo-log,
  oslo-privsep,
  oslo-serialization,
  oslo-service,
  oslo-utils,
  oslo-vmware,
  psutil,
  requests,
  tenacity,

  # checks
  castellan,
  ddt,
  stestr,
}:

buildPythonPackage rec {
  pname = "os-brick";
  version = "6.13.0";
  pyproject = true;

  src = fetchPypi {
    pname = "os_brick";
    inherit version;
    hash = "sha256-HBQXyK55DBtrzChqebDSqSZMbrv5mQY9h1+Hn4sdllc=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    os-win
    oslo-concurrency
    oslo-config
    oslo-context
    oslo-i18n
    oslo-log
    oslo-privsep
    oslo-serialization
    oslo-service
    oslo-utils
    oslo-vmware
    psutil
    requests
    tenacity
  ];

  nativeCheckInputs = [
    castellan
    ddt
    stestr
  ];

  # Disable tests requiring networking.
  checkPhase = ''
    runHook preCheck
    stestr run -e <(echo "test_get_ips")
    runHook postCheck
  '';

  pythonImportsCheck = [ "os_brick" ];

  meta = {
    description = "OpenStack Volume discovery and local storage management lib";
    homepage = "https://github.com/openstack/os-brick";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
