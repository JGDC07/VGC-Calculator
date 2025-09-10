#include "headers/qtWindowCode/AlternateWindow.h"
#include <QApplication>
#include <QScreen>
#include <QStackedWidget>
#include <QScrollArea>
#include <QDebug>
#include "headers/SV/calculatorWindow.h"

AlternateWindow::AlternateWindow(int id, QWidget *parent) : QWidget(parent), windowId(id) {
    QVBoxLayout *layout = new QVBoxLayout(this); // Main layout for AlternateWindow
    stackedWidget = new QStackedWidget(this);
    stackedWidget->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

    switch(id){
    case 0:
        break;
    case 1:
        window = new calculatorWindow();
        window->createLayout();
        stackedWidget->addWidget(window);
        break;
    default:
        label = new QLabel(QString("This is alternate window %1").arg(id + 1), this);
        layout->addWidget(label);
    }

    layout->addWidget(stackedWidget); // Ensure stackedWidget is added to the layout
    setLayout(layout); // Set the layout for AlternateWindow
}
