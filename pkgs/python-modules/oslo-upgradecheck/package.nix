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
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "oslo-upgradecheck";
  version = "2.8.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_upgradecheck";
    inherit version;
    hash = "sha256-dlbsxUoIGR+G2aIeub30P7fcMFuc70yapXegJ/LuN0A=";
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
    stestrCheckHook
  ];

  pythonImportsCheck = [ "oslo_upgradecheck" ];

  meta = {
    description = "Common code for writing OpenStack upgrade checks";
    homepage = "https://github.com/openstack/oslo.upgradecheck";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
