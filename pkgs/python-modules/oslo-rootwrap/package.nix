{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  pbr,
  setuptools,

  # dependencies
  coreutils,
  debtcollector,

  # checks
  oslotest,
  stestr,
}:

buildPythonPackage rec {
  pname = "oslo-rootwrap";
  version = "7.8.0";
  pyproject = true;

  src = fetchPypi {
    pname = "oslo_rootwrap";
    inherit version;
    hash = "sha256-lVqlnV2+uk18LMragBOSmKO3UOwBgFyxnIakHJWfjtk=";
  };

  postPatch = ''
    for file in oslo_rootwrap/tests/test_rootwrap.py oslo_rootwrap/filters.py oslo_rootwrap/tests/test_functional.py; do
      substituteInPlace $file \
        --replace "/bin/cat" "${coreutils}/bin/cat" \
        --replace "/bin/echo" "${coreutils}/bin/echo" \
        --replace "/bin/kill" "${coreutils}/bin/echo"
    done
  '';

  build-system = [
    pbr
    setuptools
  ];

  dependencies = [
    debtcollector
    pbr
  ];

  nativeCheckInputs = [ stestr ];

  checkPhase = ''
    runHook preCheck
    stestr run -e <(echo "
      # Requires networking
      oslo_rootwrap.tests.test_rootwrap.RootwrapTestCase.test_ChainingRegExpFilter_match
      oslo_rootwrap.tests.test_rootwrap.RootwrapTestCase.test_ChainingRegExpFilter_multiple
      oslo_rootwrap.tests.test_rootwrap.RootwrapTestCase.test_exec_dirs_search
      oslo_rootwrap.tests.test_rootwrap.RootwrapTestCase.test_KillFilter
      oslo_rootwrap.tests.test_rootwrap.RootwrapTestCase.test_match_filter_recurses_exec_command_filter_matches
      oslo_rootwrap.tests.test_rootwrap.RootwrapTestCase.test_RegExpFilter_match
      # Faulty test
      oslo_rootwrap.tests.test_functional.RootwrapDaemonTest.test_run_with_later_install_cmd
    ")
    runHook postCheck
  '';

  pythonImportsCheck = [ "oslo_rootwrap" ];

  meta = {
    description = "Oslo Rootwrap library";
    homepage = "https://github.com/openstack/oslo.rootwrap";
    license = lib.licenses.asl20;
    teams = [ lib.teams.openstack ];
  };
}
