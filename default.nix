let
  nixpkgs = fetchGit {
    url = https://github.com/NixOS/nixpkgs.git;
    rev = "d767ba99964eb776c2b482ca8a3a0ef42d7ccf8b";
  };
pkgs = import nixpkgs { };
in with pkgs;

stdenv.mkDerivation {
  name = "KeepCurrent";
  propagatedBuildInputs = with python3Packages; [
    # reproduce pipenv
    gensim
    spacy
    sphinx
    flake8
    black
    spacy_models.en_core_web_sm
    jupyter
    pymysql
    ipython
    click
    coverage
    boto3
    ];
  src = if stdenv.lib.inNixShell then null else ./.;
  nativeBuildInputs = stdenv.lib.optionals stdenv.lib.inNixShell [
    bashInteractive];
   shellHook = ''
   #set env variables
   '';
}
