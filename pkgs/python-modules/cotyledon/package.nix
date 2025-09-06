{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,
  setuptools-scm,

  # dependencies
  setproctitle,

  # optional-dependencies
  oslo-config,
  sphinx-rtd-theme,
  sphinx,

  # checks
  mock,
  pytest-cov,
  pytest-xdist,
  pytest,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "cotyledon";
  version = "2.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "sileht";
    repo = "cotyledon";
    tag = version;
    hash = "sha256-1E5ugF9faCSUOynsEVM0G2ir+7Mi5elX4+oQzfREueE=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    setproctitle
  ];

  optional-dependencies = {
    doc = [
      sphinx
      sphinx-rtd-theme
    ];
    oslo = [ oslo-config ];
  };

  nativeCheckInputs = [
    mock
    pytest
    pytest-cov
    pytest-xdist
    pytestCheckHook
  ]
  ++ optional-dependencies.oslo;

  disabledTests = [
    # Disable slow tests
    "test_workflow"
    "test_options"
    "test_sighup"
  ];

  disabledTestPaths = [
    # Fix import file mismatch
    # import file mismatch:
    # imported module 'cotyledon.tests.test_functional' has this __file__ attribute:
    #   /build/source/build/lib/cotyledon/tests/test_functional.py
    # which is not the same as the test file we want to collect:
    #   /build/source/cotyledon/tests/test_functional.py
    "cotyledon/tests"
  ];

  pythonImportsCheck = [ "cotyledon" ];

  meta = {
    description = "Framework for defining long-running services";
    homepage = "https://github.com/sileht/cotyledon";
    license = lib.licenses.asl20;
    maintainers = [ lib.maintainers.anthonyroussel ];
  };
}
