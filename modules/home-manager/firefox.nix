{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.firefox = inputs.wrapper-modules.wrappers.firefox.wrap {
      inherit pkgs;
      settings = {
        "browser.startup.homepage" = "https://duckduckgo.com";
        "browser.search.defaultenginename" = "Duckduckgo";
        "browser.search.order.1" = "Duckduckgo";
      };
    };
  };
}
