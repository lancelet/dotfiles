{ config, lib, pkgs, ... }:
{
  home.file.".config/zellij/config.kdl" = {
    source = ./zellij-config.kdl;
    recursive = true;
  };
}
