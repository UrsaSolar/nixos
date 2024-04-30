{ config, pkgs, ... }:{

  programs.btop = {
    enable = true;
    #catppuccin.enable = true;
    settings = {
      theme_background = false;
      truecolor = true;
      rounded_corners = true;
      update_ms = 1000;
      base_10_sizes = true;
      cpu_single_graph = true;
      # mem_graphs = false;
      io_mode = true; # Disk IO graph
      swap_disk = false; # Show swap as memory
      proc_sorting = "cpu direct"; # instantly update process list sorting
      proc_gradient = false;
      proc_per_core = true; # 100% = one core
      proc_filter_kernel = true; # filter out kernel processes
    };
  };

}
