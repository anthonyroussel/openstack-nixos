{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pkgs,

  # build-system
  setuptools,

  # dependencies
  six,
  uhashring,

  # checks
  memcached,
  pytestCheckHook,
  trustme,
}:

buildPythonPackage rec {
  pname = "python-binary-memcached";
  version = "0.32.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "jaysonsantos";
    repo = "python-binary-memcached";
    tag = "v${version}";
    hash = "sha256-l4cwbchGEpKbRdHqF093EcblX5fpPLKC+t1lgZmTMxk=";
  };

  build-system = [ setuptools ];

  dependencies = [
    six
    uhashring
  ];

  nativeCheckInputs = [
    memcached
    pytestCheckHook
    trustme
  ];

  pythonImportsCheck = [ "bmemcached" ];

  meta = {
    description = "Pure python memcached client";
    homepage = "https://github.com/jaysonsantos/python-binary-memcached";
    changelog = "https://github.com/jaysonsantos/python-binary-memcached/blob/${src.tag}/CHANGELOG.md";
    license = lib.licenses.mit;
    teams = [ lib.teams.openstack ];
  };
}
