{ config, lib, pkgs, ... }:
{
  home.file.".config/helix/" = {
    source = ./helix;
    recursive = true;
  };
}
