{ unstable, ... }: 
{

  programs.yazi = {
    enable = true;
    package = unstable.yazi;
    enableZshIntegration = true;
    settings = {
      manager = {
        ratio = [ 2 3 4 ];
        linemode = "mtime";
        sort_by = "natural";
      }; 
    };
    theme = {
      manager = {
        cwd		= { fg = "#94e2d5"; };
        hovered         = { fg = "#1e1e2e"; bg = "#89b4fa"; };
        preview_hovered = { underline = true; };
        find_keyword 	= { fg = "#f9e2af"; italic = true; };
        find_position	= { fg = "#f5c2e7"; bg = "reset"; italic = true; };
        marker_copied   = { fg = "#a6e3a1"; bg = "#a6e3a1"; };
        marker_cut      = { fg = "#f38ba8"; bg = "#f38ba8"; };
        marker_selected = { fg = "#89b4fa"; bg = "#89b4fa"; };
        tab_active  	= { fg = "#1e1e2e"; bg = "#cdd6f4"; };
        tab_inactive	= { fg = "#cdd6f4"; bg = "#45475a"; };
        tab_width   	= 1;
        count_copied  	= { fg = "#1e1e2e"; bg = "#a6e3a1"; };
        count_cut     	= { fg = "#1e1e2e"; bg = "#f38ba8"; };
        count_selected	= { fg = "#1e1e2e"; bg = "#89b4fa"; };
        border_symbol	= "│";
        border_style 	= { fg = "#7f849c"; };
        syntect_theme	= "~/.config/yazi/Catppuccin-mocha.tmTheme";
      };
      status = {
        separator_open		= "";
        separator_close		= "";
        separator_style		= { fg = "#45475a"; bg = "#45475a"; };
        mode_normal		= { fg = "#1e1e2e"; bg = "#89b4fa"; bold = true; };
        mode_select		= { fg = "#1e1e2e"; bg = "#a6e3a1"; bold = true; };
        mode_unset		= { fg = "#1e1e2e"; bg = "#f2cdcd"; bold = true; };
        progress_label		= { fg = "#ffffff"; bold = true; };
        progress_normal		= { fg = "#89b4fa"; bg = "#45475a"; };
        progress_error		= { fg = "#f38ba8"; bg = "#45475a"; };
        permissions_t		= { fg = "#89b4fa"; };
        permissions_r		= { fg = "#f9e2af"; };
        permissions_w		= { fg = "#f38ba8"; };
        permissions_x		= { fg = "#a6e3a1"; };
        permissions_s		= { fg = "#7f849c"; };
      };
      input ={
	border   = { fg = "#89b4fa"; };
	title    = {};
	value    = {};
	selected = { reversed = true; };
      };
      select = {
	border   = { fg = "#89b4fa"; };
	active   = { fg = "#f5c2e7"; };
	inactive = {};
      };
      tasks = {
	border  = { fg = "#89b4fa"; };
	title   = {};
	hovered = { underline = true; };
      };
      which = {
	mask		= { bg = "#313244"; };
	cand		= { fg = "#94e2d5"; };
	rest		= { fg = "#9399b2"; };
	desc		= { fg = "#f5c2e7"; };
	separator       = "  ";
        separator_style = { fg = "#585b70"; };
      };
      help = {
	on      = { fg = "#f5c2e7"; };
	exec    = { fg = "#94e2d5"; };
	desc    = { fg = "#9399b2"; };
	hovered = { bg = "#585b70"; bold = true; };
	footer  = { fg = "#45475a"; bg = "#cdd6f4"; };
      };
      filetype = {
        rules = [
	  # Images
	  { mime = "image/*"; fg = "#94e2d5"; }
	  # Videos
	  { mime = "video/*"; fg = "#f9e2af"; }
	  { mime = "audio/*"; fg = "#f9e2af"; }
  	  # Archives
	  { mime = "application/zip";             fg = "#f5c2e7"; }
	  { mime = "application/gzip";            fg = "#f5c2e7"; }
	  { mime = "application/x-tar";           fg = "#f5c2e7"; }
	  { mime = "application/x-bzip";          fg = "#f5c2e7"; }
	  { mime = "application/x-bzip2";         fg = "#f5c2e7"; }
	  { mime = "application/x-7z-compressed"; fg = "#f5c2e7"; }
	  { mime = "application/x-rar";           fg = "#f5c2e7"; }
	  # Fallback
	  { name = "*"; fg = "#cdd6f4"; }
	  { name = "*/"; fg = "#89b4fa"; }
	]; 
      };
    };
  };

  home.file = {
    ".config/yazi/init.lua" = {
      text = builtins.readFile(./yazi-init.lua);
    };
  };

}
