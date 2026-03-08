{
  lib,
  addBinToPathHook,
  buildPythonPackage,
  click,
  daiquiri,
  fetchPypi,
  fixtures,
  jinja2,
  pbr,
  psutil,
  requests,
  setuptools-scm,
  setuptools,
  stestrCheckHook,
  testtools,
  xattr,
}:

buildPythonPackage rec {
  pname = "pifpaf";
  version = "3.4.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-f9nPb483tuvNk82wDtuB6553z18qY/x0tgz1NbVGUWE=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    click
    daiquiri
    fixtures
    jinja2
    pbr
    psutil
    xattr
  ];

  nativeCheckInputs = [
    addBinToPathHook
    requests
    stestrCheckHook
    testtools
  ];

  pythonImportsCheck = [ "pifpaf" ];

  meta = {
    description = "Suite of tools and fixtures to manage daemons for testing";
    mainProgram = "pifpaf";
    homepage = "https://github.com/jd/pifpaf";
    license = lib.licenses.asl20;
    maintainers = [ lib.maintainers.anthonyroussel ];
  };
}
