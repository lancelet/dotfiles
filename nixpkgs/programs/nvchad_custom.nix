{ config, lib, pkgs, ... }:
{
  home.file.".config/nvim/lua/custom/" = {
    source = ./nvchad_custom;
    recursive = true;
  };
}
