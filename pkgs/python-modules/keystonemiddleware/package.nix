{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  keystoneauth1,
  oslo-cache,
  oslo-config,
  oslo-context,
  oslo-i18n,
  oslo-log,
  oslo-serialization,
  oslo-utils,
  pycadf,
  pyjwt,
  python-keystoneclient,
  requests,
  webob,

  # checks
  fixtures,
  oslo-messaging,
  oslotest,
  pytestCheckHook,
  python-memcached,
  requests-mock,
  testresources,
  testtools,
  webtest,
}:

buildPythonPackage rec {
  pname = "keystonemiddleware";
  version = "10.12.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-DakrSvUXhBDhWhuZ9W2c3rJUbu0IjGm8OeZm/gn4ab8=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    keystoneauth1
    oslo-cache
    oslo-config
    oslo-context
    oslo-i18n
    oslo-log
    oslo-serialization
    oslo-utils
    pbr
    pycadf
    pyjwt
    python-keystoneclient
    requests
    webob
  ];

  nativeCheckInputs = [
    fixtures
    oslo-messaging
    oslotest
    pytestCheckHook
    python-memcached
    requests-mock
    testresources
    testtools
    webtest
  ];

  pythonImportsCheck = [ "keystonemiddleware" ];

  meta = {
    description = "Middleware for OpenStack Identity (Keystone)";
    homepage = "https://github.com/openstack/keystonemiddleware";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
