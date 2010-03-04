include(../conf.pri)
include(../defaults.pri)
include(../macros.pri)

TEMPLATE = app
CONFIG += warn_on \
	thread \
	qt
QT += xml
LIBS += -lpoppler-qt4
usekde {
	DEFINES += KTIKZ_USE_KDE
	INCLUDEPATH += $${KDE_INCLUDEDIRS}
	LIBS += -lpoppler-qt4 -L$${KDE_LIBDIRS} -lkfile
}

DEFINES += APPVERSION=\\\"$${APPVERSION}\\\"
DEFINES += KTIKZ_INSTALL_TRANSLATIONS=\\\"$${TRANSLATIONSDIR}\\\"

### Build files

DESTDIR = ../build/bin
MOC_DIR = ../build/moc
OBJECTS_DIR = ../build/obj
RCC_DIR = ../build/rcc
UI_DIR = ../build/ui

### Input

FORMS += configappearancewidget.ui \
	configeditorwidget.ui \
	configgeneralwidget.ui \
	editgotolinewidget.ui \
	editindentdialog.ui \
	editreplacewidget.ui \
	templatewidget.ui
#SOURCES += $$formSources($$FORMS) \ # linguist does not use translations in corresponding cpp files if we use this :-(
SOURCES += aboutdialog.cpp \
	colorbutton.cpp \
	configappearancewidget.cpp \
	configdialog.cpp \
	configeditorwidget.cpp \
	configgeneralwidget.cpp \
	editgotolinewidget.cpp \
	editindentdialog.cpp \
	editreplacewidget.cpp \
	editreplacecurrentwidget.cpp \
	ktikzapplication.cpp \
	lineedit.cpp \
	loghighlighter.cpp \
	logtextedit.cpp \
	main.cpp \
	mainwindow.cpp \
	templatewidget.cpp \
	tikzcommandinserter.cpp \
	tikzcommandwidget.cpp \
	tikzeditor.cpp \
	tikzeditorhighlighter.cpp \
	tikzeditorview.cpp \
	tikzpreview.cpp \
	tikzpreviewgenerator.cpp
HEADERS += $$headerFiles($$SOURCES)
RESOURCES = application.qrc
TRANSLATIONS = ktikz_de.ts ktikz_es.ts ktikz_fr.ts

### Output

TARGET = ktikz
target.path = $${BINDIR}
INSTALLS += target

unix:!macx {
	ICONDIR = $$replace(TRANSLATIONSDIR, "/", "\/")
	DESKTOPCREATE = "sed -e \"s/Icon=/Icon=$${ICONDIR}\/ktikz-128.png/\" ktikz.desktop.template > ktikz.desktop"
	system($$DESKTOPCREATE)
	desktop.path = $${DESKTOPDIR}
	desktop.files = ktikz.desktop
	INSTALLS += desktop
}

### Translations

translationscreate.commands = $$LRELEASECOMMAND $$TRANSLATIONS; $$QMAKECOMMAND
translationscreate.target = translations
QMAKE_EXTRA_TARGETS = translationscreate

QMAKE_CLEAN += $$qmFiles($$TRANSLATIONS)

translations.path = $${TRANSLATIONSDIR}
translations.files = $$qmFiles($$TRANSLATIONS) images/ktikz-128.png template_example.pgs
INSTALLS += translations