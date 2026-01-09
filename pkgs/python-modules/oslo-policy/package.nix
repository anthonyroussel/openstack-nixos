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
  stestr,
}:

buildPythonPackage rec {
  pname = "oslo-policy";
  version = "4.8.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_policy";
    inherit version;
    hash = "sha256-bjeIybdo/+d2MsyrrBh8M3rVlIz5N47DinUHzvicODY=";
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
    stestr
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_policy" ];

  meta = {
    description = "Oslo Policy library";
    homepage = "https://github.com/openstack/oslo.policy";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
