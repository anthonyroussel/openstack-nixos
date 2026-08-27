{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  amqp,
  cachetools,
  futurist,
  kombu,
  oslo-context,
  oslo-log,
  oslo-metrics,
  oslo-middleware,
  oslo-serialization,
  oslo-service,
  webob,

  # checks
  confluent-kafka,
  oslotest,
  pifpaf,
  stestrCheckHook,
  testscenarios,
}:

buildPythonPackage rec {
  pname = "oslo-messaging";
  version = "18.3.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_messaging";
    inherit version;
    hash = "sha256-pGi+6CJuPnmHjKsZBKiVn9T5JPOmR0RwND9RsIGMt0U=";
  };

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    amqp
    cachetools
    futurist
    kombu
    oslo-context
    oslo-log
    oslo-metrics
    oslo-middleware
    oslo-serialization
    oslo-service
    pbr
    webob
  ];

  nativeCheckInputs = [
    confluent-kafka
    oslotest
    pifpaf
    stestrCheckHook
    testscenarios
  ];

  pythonImportsCheck = [ "oslo_messaging" ];

  meta = {
    description = "Oslo Messaging library";
    homepage = "https://github.com/openstack/oslo.messaging";
    license = lib.licenses.asl20;
    mainProgram = "oslo-messaging-send-notification";
    teams = [ lib.teams.openstack ];
  };
}
