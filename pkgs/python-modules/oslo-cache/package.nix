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
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "oslo-cache";
  version = "4.3.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_cache";
    inherit version;
    hash = "sha256-x0etol4gkldG2jaiCO7FDw1MMQ/KrBC0NraTk+6BQP4=";
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
    stestrCheckHook
  ]
  ++ optional-dependencies.mongo
  ++ optional-dependencies.dogpile;

  pythonImportsCheck = [ "oslo_cache" ];

  meta = {
    description = "Oslo Cache library";
    homepage = "https://github.com/openstack/oslo.cache";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
