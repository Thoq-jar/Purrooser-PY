# You are working in src/browser.pyx
# -*- coding: utf-8 -*-
# cython: language_level=3


from PyQt5.QtWidgets import QMainWindow, QTabWidget, QToolBar, QAction, QLineEdit
from PyQt5.QtWebEngineWidgets import QWebEngineView
from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QIcon
from src.styles import get_styles

URL = "https://www.qwant.com/"

class Purroser(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Purroser")
        self.setGeometry(100, 100, 1600, 900)
        self.tabs = QTabWidget()
        self.setCentralWidget(self.tabs)
        self.toolbar = QToolBar()
        self.addToolBar(self.toolbar)

        app_icon_path = "../assets/purr.png"
        self.setWindowIcon(QIcon(app_icon_path))

        if self.tabs.count() == 0:
            self.add_tab(URL)

        self.add_toolbar_actions()
        self.add_fullscreen_action()  # Added fullscreen action to the toolbar

        self.setStyleSheet(get_styles())

    def add_toolbar_actions(self):
        new_tab_action = QAction("New Tab", self)
        new_tab_action.triggered.connect(self.add_tab)
        self.toolbar.addAction(new_tab_action)
        close_tab_action = QAction("Close Tab", self)
        close_tab_action.triggered.connect(self.close_current_tab)
        self.toolbar.addAction(close_tab_action)
        back_button = QAction("Back", self)
        back_button.triggered.connect(self.tabs.currentWidget().back)
        self.toolbar.addAction(back_button)
        forward_button = QAction("Forward", self)
        forward_button.triggered.connect(self.tabs.currentWidget().forward)
        self.toolbar.addAction(forward_button)
        home_button = QAction("Home", self)
        home_button.triggered.connect(lambda checked, self=self: self.home())
        self.toolbar.addAction(home_button)
        self.url_bar = QLineEdit()
        self.url_bar.returnPressed.connect(self.navigate_to_url)
        self.toolbar.addWidget(self.url_bar)
        self.add_fullscreen_action()  # Ensure fullscreen action is added here too

    def add_fullscreen_action(self):
        fullscreen_action = QAction("Full Screen", self)
        fullscreen_action.triggered.connect(lambda: self.toggle_fullscreen(self.tabs.currentWidget()))
        self.toolbar.addAction(fullscreen_action)

    def check_fullscreen_support(self, web_view):
        js_code = """
        var elem = document.documentElement;
        if (!document.fullscreenElement && 
            !document.mozFullScreenElement && 
            !document.webkitFullscreenElement && 
            !document.msFullscreenElement ) {        
            if (elem.requestFullscreen) {
                elem.requestFullscreen();
                return true;
            }
        }
        return false;
        """
        web_view.page().runJavaScript(js_code)

    def toggle_fullscreen(self, web_view):
        if self.check_fullscreen_support(web_view):
            web_view.showFullScreen()
        else:
            print("Fullscreen not supported.")

    def home(self):
        if self.tabs.count() == 0:
            self.add_tab(URL)
        self.tabs.currentWidget().setUrl(QUrl(URL))

    def add_tab(self, url=URL):
        web_view = QWebEngineView()
        if isinstance(url, str) and url:
            web_view.setUrl(QUrl(url))
        else:
            web_view.setUrl(QUrl(URL))

        web_view.setStyleSheet("background-color: black; color: white;")
        tab_label = url.split("//")[-1] if isinstance(url, str) and url else "New Tab"
        self.tabs.addTab(web_view, tab_label)
        self.tabs.setCurrentWidget(web_view)
        web_view.urlChanged.connect(lambda q: self.url_bar.setText(q.toString()))

    def close_current_tab(self, *args):
        current_index = self.tabs.currentIndex()
        if current_index != -1:
            self.tabs.removeTab(current_index)

    def navigate_to_url(self):
        url = self.url_bar.text()
        if not url.startswith("https"):
            url = "https://" + url
        self.tabs.currentWidget().setUrl(QUrl(url))
