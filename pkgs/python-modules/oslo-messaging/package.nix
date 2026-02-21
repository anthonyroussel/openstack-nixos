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
  stestr,
  testscenarios,
}:

buildPythonPackage rec {
  pname = "oslo-messaging";
  version = "17.3.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_messaging";
    inherit version;
    hash = "sha256-c4GgjzEJHyi4LLk8CgTtW7KkSH2rG4c9H+atZVOUh3c=";
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
    stestr
    testscenarios
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_messaging" ];

  meta = {
    description = "Oslo Messaging library";
    homepage = "https://github.com/openstack/oslo.messaging";
    license = lib.licenses.asl20;
    mainProgram = "oslo-messaging-send-notification";
    teams = [ lib.teams.openstack ];
  };
}
