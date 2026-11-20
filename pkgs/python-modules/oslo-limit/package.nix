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
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "oslo-limit";
  version = "2.12.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_limit";
    inherit version;
    hash = "sha256-YPeS+qBEhaJl19q12DVxrX1860VfBYg9BK4/BI8SmKI=";
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
    stestrCheckHook
  ];

  pythonImportsCheck = [ "oslo_limit" ];

  meta = {
    description = "Oslo Limit library";
    homepage = "https://github.com/openstack/oslo.limit";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
