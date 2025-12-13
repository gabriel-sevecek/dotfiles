{
  fetchPypi,
  python3Packages,
  ...
}:
python3Packages.buildPythonPackage rec {
  pname = "yawsso";
  version = "1.2.1";
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-kfG8re73yxoyYJtqpkG2VHk9lWjNTIl9gG8bDLwhmfI=";
  };
  format = "pyproject";
  nativeBuildInputs = with python3Packages; [setuptools wheel];
  doCheck = false;
}
