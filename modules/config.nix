{ config, lib, ... }:

let
  userConfigOptions = config.userConfigOptions;
in
{
  options.userConfigOptions = {
    defaultUser = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "zaroc";
        description = "Username for the Default user";
      };
    };
  };
}
