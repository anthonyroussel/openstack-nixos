{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  keystoneauth1,
  openstacksdk,
  oslo-config,
  oslo-i18n,
  oslo-log,

  # checks
  oslotest,
  stestr,
}:

buildPythonPackage rec {
  pname = "oslo-limit";
  version = "2.9.2";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_limit";
    inherit version;
    hash = "sha256-8TDEpZItdVbJAPhPzbTIBYRM6S45UhFpIZjTWQGSifg=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    keystoneauth1
    openstacksdk
    oslo-config
    oslo-i18n
    oslo-log
  ];

  nativeCheckInputs = [
    oslotest
    stestr
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_limit" ];

  meta = {
    description = "Oslo Limit library";
    homepage = "https://github.com/openstack/oslo.limit";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
