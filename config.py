config.load_autoconfig(True)
config.set('colors.webpage.darkmode.enabled', True)
c.colors.webpage.darkmode.algorithm = 'lightness-hsl'
c.colors.webpage.darkmode.policy.images = 'never'
config.set('colors.webpage.preferred_color_scheme', 'dark')
