import sys
from PyQt5.QtWidgets import QApplication
from browser import Purroser # type: ignore


def main():
    app = QApplication(sys.argv)
    browser = Purroser()
    browser.show()
    sys.exit(app.exec_())
