{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Teiwo";
    userEmail = "CLoudUndefined@users.noreply.github.com";
    extraConfig = {
      core = {
        editor = "hx";
      };
      pull = {
        rebase = true;
      };
      init = {
        defaultBranch = "master";
      };
    };
  };
}