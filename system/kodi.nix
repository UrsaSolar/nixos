{ pkgs, ... }:{
    
  environment.systemPackages = [
  	(pkgs.kodi.passthru.withPackages (kodiPkgs: with kodiPkgs; [
      jellyfin
      somafm
      netflix
      youtube

	  ]))
  ];

}

