{ config, lib, pkgs, ... }:
{
  home.file.".alacritty.yml".source = ./alacritty.yml;
}
