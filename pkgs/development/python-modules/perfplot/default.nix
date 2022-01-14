{ lib
, buildPythonPackage
, fetchFromGitHub
, dufte
, matplotlib
, numpy
, pipdate
, tqdm
, rich
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "perfplot";
  version = "0.9.13";
  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "nschloe";
    repo = pname;
    rev = version;
    sha256 = "0ry5x38sv8gh505z6ip90jymm7kfgyf80y3vjb2i6z567bnblam6";
  };
  format = "pyproject";

  propagatedBuildInputs = [
    dufte
    matplotlib
    numpy
    pipdate
    rich
    tqdm
  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "perfplot" ];

  meta = with lib; {
    description = "Performance plots for Python code snippets";
    homepage = "https://github.com/nschloe/perfplot";
    license = licenses.mit;
    maintainers = with maintainers; [ costrouc ];
  };
}
