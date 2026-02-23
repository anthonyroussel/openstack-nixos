{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  debtcollector,
  dogpile-cache,
  etcd3gw,
  oslo-config,
  oslo-i18n,
  oslo-log,
  oslo-utils,
  pymemcache,
  pymongo,
  python-binary-memcached,
  python-memcached,
  redis,

  # checks
  oslotest,
  stestr,
}:

buildPythonPackage rec {
  pname = "oslo-cache";
  version = "4.1.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_cache";
    inherit version;
    hash = "sha256-WJb9S1aEbvMe9q5Qtm8zvf23rehtQuYiTwtMqDn7Ls0=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    debtcollector
    dogpile-cache
    oslo-config
    oslo-i18n
    oslo-log
    oslo-utils
    pbr
  ];

  optional-dependencies = {
    dogpile = [
      python-memcached
      pymemcache
      python-binary-memcached
      redis
    ];
    etcd3gw = [
      etcd3gw
    ];
    mongo = [
      pymongo
    ];
  };

  nativeCheckInputs = [
    oslotest
    stestr
  ]
  ++ optional-dependencies.mongo
  ++ optional-dependencies.dogpile;

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_cache" ];

  meta = {
    description = "Oslo Cache library";
    homepage = "https://github.com/openstack/oslo.cache";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
