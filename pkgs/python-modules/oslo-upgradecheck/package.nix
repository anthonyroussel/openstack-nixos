{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  oslo-config,
  oslo-i18n,
  oslo-policy,
  oslo-utils,
  prettytable,

  # checks
  oslotest,
  stestr,
}:

buildPythonPackage rec {
  pname = "oslo-upgradecheck";
  version = "2.7.1";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_upgradecheck";
    inherit version;
    hash = "sha256-mrLnJtMuR8q0+cQlgOJybjEdgkPz5E8vZ/SHVRfynvQ=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    oslo-config
    oslo-i18n
    oslo-policy
    oslo-utils
    prettytable
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

  pythonImportsCheck = [ "oslo_upgradecheck" ];

  meta = {
    description = "Common code for writing OpenStack upgrade checks";
    homepage = "https://github.com/openstack/oslo.upgradecheck";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
