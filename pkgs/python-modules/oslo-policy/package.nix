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
  version = "5.0.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_policy";
    inherit version;
    hash = "sha256-s+hdRe6gpgyyNiQQxtA5Bt7CGg+B32msFoZ4UfB15dE=";
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
