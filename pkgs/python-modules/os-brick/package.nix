{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
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
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "os-brick";
  version = "7.0.0";
  pyproject = true;

  src = fetchPypi {
    pname = "os_brick";
    inherit version;
    hash = "sha256-OijcBcQY+ZLnJTiIYTYQfGe4AFGlhAFEzX9z1QuewFo=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
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
    stestrCheckHook
  ];

  disabledTests = [
    # Requires networking
    "test_get_ips"
  ];

  pythonImportsCheck = [ "os_brick" ];

  meta = {
    description = "OpenStack Volume discovery and local storage management lib";
    homepage = "https://github.com/openstack/os-brick";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
