{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  eventlet,
  futurist,
  jsonschema,
  keystoneauth1,
  oslo-concurrency,
  oslo-config,
  oslo-i18n,
  oslo-serialization,
  oslo-utils,
  python-keystoneclient,
  requests,
  retrying,

  # optional-dependencies
  boto3,
  os-brick,
  oslo-privsep,
  oslo-rootwrap,
  oslo-vmware,
  python-cinderclient,
  python-swiftclient,

  # checks
  ddt,
  oslotest,
  requests-mock,
  stestr,
}:

buildPythonPackage rec {
  pname = "glance-store";
  version = "5.4.0";
  pyproject = true;

  src = fetchPypi {
    pname = "glance_store";
    inherit version;
    hash = "sha256-VQH+XgpelZ0W5M3X8aqC4rtcxjsnVf4xni66vecEc8I=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    eventlet
    futurist
    jsonschema
    keystoneauth1
    oslo-concurrency
    oslo-config
    oslo-i18n
    oslo-serialization
    oslo-utils
    python-keystoneclient
    requests
    retrying
  ];

  optional-dependencies = {
    cinder = [
      os-brick
      oslo-privsep
      oslo-rootwrap
      python-cinderclient
    ];
    s3 = [ boto3 ];
    swift = [ python-swiftclient ];
    vmware = [ oslo-vmware ];
  };

  nativeCheckInputs = [
    ddt
    oslotest
    requests-mock
    stestr
  ]
  ++ optional-dependencies.cinder
  ++ optional-dependencies.s3
  ++ optional-dependencies.swift
  ++ optional-dependencies.vmware;

  checkPhase = ''
    runHook preCheck
    stestr run -e <(echo "
      glance_store.tests.unit.test_filesystem_store.TestStore.test_add_check_metadata_list_with_valid_mountpoint_locations
      glance_store.tests.unit.test_multistore_filesystem.TestMultiStore.test_add_check_metadata_list_with_valid_mountpoint_locations
    ")
    runHook postCheck
  '';

  pythonImportsCheck = [ "glance_store" ];

  meta = with lib; {
    description = "Oslo Reports library";
    homepage = "https://github.com/openstack/oslo.reports";
    license = licenses.asl20;
    teams = [ teams.openstack ];
  };
}
