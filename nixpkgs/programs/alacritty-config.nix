{ config, lib, pkgs, ... }:
{
  home.file.".alacritty.toml".source = ./alacritty.toml;
}
