{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  hatchling,

  # checks
  pytestCheckHook,
  python-memcached,
}:

buildPythonPackage rec {
  pname = "uhashring";
  version = "2.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ultrabug";
    repo = "uhashring";
    tag = version;
    hash = "sha256-6zNPExbcwTUne0lT8V6xp2Gf6J1VgG7Q93qizVOAc+k=";
  };

  build-system = [
    hatchling
  ];

  nativeCheckInputs = [
    pytestCheckHook
    python-memcached
  ];

  pythonImportsCheck = [ "uhashring" ];

  meta = {
    description = "Full featured consistent hashing python library compatible with ketama";
    homepage = "https://github.com/ultrabug/uhashring";
    license = lib.licenses.bsd3;
    maintainers = [ lib.maintainers.anthonyroussel ];
  };
}
