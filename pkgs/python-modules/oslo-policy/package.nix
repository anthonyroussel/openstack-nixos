{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  oslo-config,
  oslo-context,
  oslo-i18n,
  oslo-serialization,
  oslo-utils,
  requests,
  sphinx,

  # checks
  oslotest,
  requests-mock,
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "oslo-policy";
  version = "6.0.1";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_policy";
    inherit version;
    hash = "sha256-CYMlnTkZsVyqN1WyL7oUUZBPYKwgpIZWvGGvr0IPemc=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    oslo-config
    oslo-context
    oslo-i18n
    oslo-serialization
    oslo-utils
    requests
    sphinx
  ];

  nativeCheckInputs = [
    oslotest
    requests-mock
    stestrCheckHook
  ];

  pythonImportsCheck = [ "oslo_policy" ];

  meta = {
    description = "Oslo Policy library";
    homepage = "https://github.com/openstack/oslo.policy";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
