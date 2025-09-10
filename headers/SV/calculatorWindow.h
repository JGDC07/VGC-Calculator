#ifndef CALCULATORWINDOW_H
#define CALCULATORWINDOW_H

#include "sharedWindowInfo.h"

class calculatorWindow : public QWidget, SharedCalculatorWindow{
        Q_OBJECT
    public:
        explicit calculatorWindow(QWidget *parent = nullptr);
        ~calculatorWindow();
        void createLayout();

    protected:
        // QScrollArea* setupCalculatorArea();
        // QVBoxLayout* createPokemonArea(qint8 index);
        // QVBoxLayout* createSelectionArea();
        // QVBoxLayout* createResultsArea();
};

#endif // CALCULATORWINDOW_H
