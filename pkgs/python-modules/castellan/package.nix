{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  cryptography,
  keystoneauth1,
  oslo-config,
  oslo-context,
  oslo-i18n,
  oslo-log,
  oslo-utils,
  python-barbicanclient,
  requests,
  stevedore,

  # tests
  oslotest,
  requests-mock,
  stestr,
}:

buildPythonPackage rec {
  pname = "castellan";
  version = "5.6.0";
  pyproject = true;

  src = fetchPypi {
    pname = "castellan";
    inherit version;
    hash = "sha256-kX9DofHSboe++LbeDhf+OVX198wFt0b8gE/ax8E7zF4=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    cryptography
    keystoneauth1
    oslo-config
    oslo-context
    oslo-i18n
    oslo-log
    oslo-utils
    pbr
    python-barbicanclient
    requests
    stevedore
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

  pythonImportsCheck = [ "castellan" ];

  meta = {
    description = "Generic Key Manager interface for OpenStack";
    homepage = "https://github.com/openstack/castellan";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
