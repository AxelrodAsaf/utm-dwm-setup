c.qt.args = ["--disable-gpu", "--disable-gpu-compositing"]
c.content.blocking.enabled = True
c.url.start_pages = ['www.google.com']
c.content.blocking.method = "both"
c.content.javascript.enabled = True
config.load_autoconfig(False)
c.url.searchengines = {
    'DEFAULT': 'https://www.google.com/search?={}',
    '!g': 'https://www.google.com/search?q={}',
    '!gh': 'https://github.com/search?q={}',
    '!yt': 'https://www.youtube.com/results?search_query={}',
    '!w': 'https://en.wikipedia.org/wiki/{}'
}

# --- UI toggles (canonical, reproducible) ---
# Status bar toggle
config.bind(',s', 'config-cycle statusbar.show always never')

# Tab bar toggle
config.bind(',t', 'config-cycle tabs.show always never')

# Global dark mode toggle (QtWebEngine 5.x requires restart)
config.bind(',d', 'config-cycle content.user_stylesheets "~/.config/qutebrowser/css/dark-all-sites.css" "" ;; reload')
