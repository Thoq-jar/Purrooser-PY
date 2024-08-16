def get_styles():
    return """
        QMainWindow {
            background-color: #2E2E2E;
            color: white;
        }
        QTabWidget::pane {
            background-color: #2E2E2E;
            color: white;
        }
        QTabBar::tab {
            background-color: #3E3E3E;
            color: white;
            padding: 10px;
        }
        QTabBar::tab:selected {
            background-color: #4E4E4E;
            color: white;           
        }
        QToolBar {
            background-color: #3E3E3E;
            color: white;
        }
        QLineEdit {
            background-color: #3E3E3E;
            color: white;
        }
        QWebEngineView {
            background-color: #2E2E2E;
            color: white;
        }
        QWebEngineView::scroll-bar {
            width: 0px;
        }
        QWebEngineView::verticalScrollBar {
            width: 0px;
        }
        QWebEngineView::horizontalScrollBar {
            height: 0px;
        }
    """
