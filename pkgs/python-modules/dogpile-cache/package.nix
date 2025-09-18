{
  lib,
  buildPythonPackage,
  fetchPypi,
  pythonOlder,

  # build-system
  setuptools,

  # dependencies
  decorator,
  python-binary-memcached,
  stevedore,
  typing-extensions,

  # checks
  mako,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "dogpile-cache";
  version = "1.4.1";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchPypi {
    pname = "dogpile_cache";
    inherit version;
    hash = "sha256-4lxg5nel4o/4YSR2X78YxTJXvNeDB0nNW6NQrOKhKYk=";
  };

  build-system = [ setuptools ];

  dependencies = [
    decorator
    stevedore
  ]
  ++ lib.optionals (pythonOlder "3.11") [
    typing-extensions
  ];

  optional-dependencies = {
    bmemcached = [
      python-binary-memcached
    ];
  };

  nativeCheckInputs = [
    mako
    pytestCheckHook
  ];

  meta = {
    description = "Caching front-end based on the Dogpile lock";
    homepage = "https://github.com/sqlalchemy/dogpile.cache";
    license = lib.licenses.mit;
    teams = [ lib.teams.openstack ];
  };
}
