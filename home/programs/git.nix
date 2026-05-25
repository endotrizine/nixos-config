{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "endotrizine";
      user.email = "starnicworld@gmail.com";
      core.autocrlf = "input";
      credential.helper = "store";
      credential."https://github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
      credential."https://gist.github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
    };
  };
}
