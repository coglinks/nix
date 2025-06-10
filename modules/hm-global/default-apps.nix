{ ... }:

{
	xdg.mimeApps = {
		enable = true;
		defaultApplications = {
			"text/html" = "firefox-esr.desktop";
			"x-scheme-handler/http" = "firefox-esr.desktop";
			"x-scheme-handler/https" = "firefox-esr.desktop";
			"x-scheme-handler/about" = "firefox-esr.desktop";
			"x-scheme-handler/unknown" = "firefox-esr.desktop";
			"application/pdf"="org.pwmt.zathura.desktop";
			"image/jpeg"="feh.desktop";
			"image/png"="feh.desktop";
			"image/jpg"="feh.desktop";
			"image/webp"="feh.desktop";
			"image/gif"="feh.desktop";
		};
	};
}
