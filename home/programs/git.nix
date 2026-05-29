{ pkgs, ... }:
{
  programs.git = {
  	enable = true;
  	delta = {
    	enable = true;
    	options = {
      	navigate = true;
    		line-numbers = true;
      	# side-by-side = true;   # раскомmenть если хочешь две колонки
    	};
  	};
		settings = {
  		user.name = "endotrizine";
  		user.email = "starnicworld@gmail.com";
  		core.autocrlf = "input";
  		credential.helper = "store";
			credential."https://github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
  		credential."https://gist.github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
		};
	};

	programs.lazygit.settings.git.paging = {
  	colorArg = "always";
  	pager = "delta --paging=never";
	};

}
