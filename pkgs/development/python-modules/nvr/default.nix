{ stdenv, buildPythonPackage, fetchFromGitHub, python, pytest, pynvim, psutil }:

buildPythonPackage rec {
  pname = "nvr";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "mhinz";
    repo = "neovim-remote";
    rev = "v${version}";
    sha256 = "0f9x053yr8wq35l2s2dsnb0iygd4g4yya2h3iv0yh3440jjj5vfj";
  };

  # argparse is just required for python2.6
  prePatch = ''
    substituteInPlace setup.py \
      --replace "'argparse'," ""
  '';

  checkInputs = [ pytest ];
  propagatedBuildInputs = [ pynvim psutil ];

  # checkPhase = ''
  #   ${python.interpreter} -m pytest
  # '';

  meta = with stdenv.lib; {
    description = "Neovim Remote library";
    homepage = https://github.com/mhinz/neovim-remote;
    license = licenses.mit;
    # maintainers = with maintainers; [ psyanticy ];
  };
}
