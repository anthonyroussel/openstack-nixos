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
  version = "2.8.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Ip4F1Dw68NdIGTs1aa982FE38m/LLVUWfs3EACBIiG8=";
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
