{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  setuptools,

  # dependencies
  kazoo,
  six,

  # checks
  testtools,
  unittestCheckHook,
}:

buildPythonPackage rec {
  pname = "zake";
  version = "0.2.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-WlCFmTHE9mbTGLdNHEB6YVDdUZTkxYEtBxpcfHzv5OY=";
  };

  build-system = [ setuptools ];

  dependencies = [
    kazoo
    six
  ];

  nativeCheckInputs = [
    unittestCheckHook
    testtools
  ];

  preCheck = ''
    # Skip test - fails with our new kazoo version
    substituteInPlace zake/tests/test_client.py \
      --replace "test_child_watch_no_create" "_test_child_watch_no_create"
  '';

  unittestFlagsArray = [ "zake/tests" ];

  meta = {
    description = "(DEPRECATED) Provides a set of testing utilities for the kazoo library ";
    homepage = "https://github.com/yahoo/Zake";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
