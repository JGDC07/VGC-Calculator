#ifndef MAIN_H
#define MAIN_H

#include <QString>
#include <QMainWindow>
#include <QToolBar>
#include <QListWidget>
#include <QTabBar>
#include <QGridLayout>
#include <QPushButton>
#include <QVector>
#include <QStackedWidget>
#include <QFile>
#include "AlternateWindow.h"

class MainWindow : public QMainWindow {
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    void setupAutoUpdater();
    void alwaysOnTop(bool always);

private slots:
    void openAlternateWindow(int index);
    void updateFavorites();
    void checkForUpdates();
    void switchTab(int i);
    void closeTab(int i);
    bool eventFilter(QObject *o, QEvent *e);

private:
    QStackedWidget *stackedWidget;
    QWidget *centralWidget;
    QGridLayout *gridLayout;
    QListWidget *sidebar;
    QTabBar *topBar;
    QVector<AlternateWindow *> alternateWindows;
};


#endif // MAIN_H
