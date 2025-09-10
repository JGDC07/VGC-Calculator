#include "headers/SV/calculatorWindow.h"

calculatorWindow::calculatorWindow(QWidget *parent) :QWidget(parent){

}

calculatorWindow::~calculatorWindow(){}

void calculatorWindow::createLayout(){
    auto *layout = new QVBoxLayout(this);
    auto *bulk_question = new QLabel("Testing", this);
    layout->addWidget(bulk_question);
    setLayout(layout);
}
