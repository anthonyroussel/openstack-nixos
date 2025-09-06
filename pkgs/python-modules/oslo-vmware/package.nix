{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  eventlet,
  lxml,
  oslo-concurrency,
  oslo-context,
  oslo-i18n,
  oslo-utils,
  requests,
  suds-community,
  urllib3,

  # checks
  ddt,
  hacking,
  oslotest,
  stestr,
}:

buildPythonPackage rec {
  pname = "oslo-vmware";
  version = "4.7.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_vmware";
    inherit version;
    hash = "sha256-ZKIttXRliLSzFYLX4D4cYmmq1CrF1Ifwd0ACiz+qn+U=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    eventlet
    lxml
    oslo-concurrency
    oslo-context
    oslo-i18n
    oslo-utils
    requests
    suds-community
    urllib3
  ];

  nativeCheckInputs = [
    ddt
    hacking
    oslotest
    stestr
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_vmware" ];

  meta = {
    description = "Oslo VMWare library";
    homepage = "https://github.com/openstack/oslo.vmware";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
