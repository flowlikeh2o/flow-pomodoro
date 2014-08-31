#include "teststorage.h"
#include "testtask.h"

#include <QtTest/QtTest>
#include <QGuiApplication>

int main(int argc, char *argv[])
{ 
    QGuiApplication app(argc, argv);
    app.setAttribute(Qt::AA_Use96Dpi, true);
    TestStorage test1;
    return QTest::qExec(&test1, argc, argv);

    TestTask test2;
    return QTest::qExec(&test2, argc, argv);
}