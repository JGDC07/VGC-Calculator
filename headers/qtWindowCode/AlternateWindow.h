#ifndef ALTERNATEWINDOW_H
#define ALTERNATEWINDOW_H

#include <QWidget>
#include <QLabel>
#include <QMainWindow>
#include <QToolBar>
#include <QListWidget>
#include <QTabBar>
#include <QGridLayout>
#include <QPushButton>
#include <QVector>
#include <QStackedWidget>
#include "headers/SV/calculatorWindow.h"

class AlternateWindow : public QWidget {
    Q_OBJECT

public:
    AlternateWindow(int id, QWidget *parent = nullptr);
    calculatorWindow* window;
private:
    QLabel *label;
    int windowId;
    QStackedWidget *stackedWidget;
};

#endif // ALTERNATEWINDOW_H

