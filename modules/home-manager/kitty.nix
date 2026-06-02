{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      settings = {        
        font_family                = "JetBrainsMono Nerd Font";
        font_size                  = 13;
        window_padding_width       = 12;
        dynamic_background_opacity = true;
        enable_audio_bell          = false;
        confirm_os_window_close    = 0;
        scrollback_lines           = 10000;
        cursor_shape               = "beam";
        theme                      = "Tokyo Night";
        background_opacity         = 0.85;
      };
    };
  };
}
