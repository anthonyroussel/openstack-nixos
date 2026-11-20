{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  futurist,
  requests,

  # tests
  oslotest,
  stestrCheckHook,
}:

buildPythonPackage rec {
  pname = "etcd3gw";
  version = "2.7.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-VelbeI7E5ypX5wTC7M30QWPvI7y0/OiDxxk24e2K2Pg=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    futurist
    pbr
    requests
  ];

  nativeCheckInputs = [
    oslotest
    stestrCheckHook
  ];

  pythonImportsCheck = [ "etcd3gw" ];

  meta = {
    description = "etcd3 grpc-gateway v3 API Python client";
    homepage = "https://github.com/openstack/etcd3gw";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
