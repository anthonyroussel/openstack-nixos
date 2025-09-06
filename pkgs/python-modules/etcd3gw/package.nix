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
  pytestCheckHook,
  stestr,
}:

buildPythonPackage rec {
  pname = "etcd3gw";
  version = "2.4.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-bG6eQrgQ7pqUVd00LemJ8fq2N6lNqk/DTKyySKVEc/o=";
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
    stestr
    pytestCheckHook
  ];

  pythonImportsCheck = [ "etcd3gw" ];

  meta = {
    description = "etcd3 grpc-gateway v3 API Python client";
    homepage = "https://github.com/openstack/etcd3gw";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
