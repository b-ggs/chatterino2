QT                += widgets core gui network multimedia svg concurrent
CONFIG            += communi
COMMUNI           += core model util

INCLUDEPATH       += src/
TARGET             = chatterino
TEMPLATE           = app
PRECOMPILED_HEADER = src/PrecompiledHeader.hpp
CONFIG            += precompile_header
DEFINES           += CHATTERINO
DEFINES           += "AB_NAMESPACE=chatterino"
DEFINES           += AB_CUSTOM_THEME
DEFINES           += AB_CUSTOM_SETTINGS
CONFIG            += AB_NOT_STANDALONE

useBreakpad {
    LIBS += -L$$PWD/lib/qBreakpad/handler/build
    include(lib/qBreakpad/qBreakpad.pri)
    DEFINES += C_USE_BREAKPAD
}

# use C++17
win32-msvc* {
    QMAKE_CXXFLAGS += /std:c++17
} else {
    QMAKE_CXXFLAGS += -std=c++17
}

# https://bugreports.qt.io/browse/QTBUG-27018
equals(QMAKE_CXX, "clang++")|equals(QMAKE_CXX, "g++") {
    TARGET = bin/chatterino
}

# Icons
macx:ICON = resources/chatterino.icns
win32:RC_FILE = resources/windows.rc

macx {
    LIBS += -L/usr/local/lib
}

# Submodules
DEFINES += IRC_NAMESPACE=Communi

include(lib/warnings.pri)
include(lib/appbase.pri)
include(lib/fmt.pri)
include(lib/humanize.pri)
include(lib/libcommuni.pri)
include(lib/websocketpp.pri)
include(lib/wintoast.pri)
include(lib/signals.pri)
include(lib/settings.pri)
include(lib/serialize.pri)
include(lib/winsdk.pri)
include(lib/rapidjson.pri)

exists( $$OUT_PWD/conanbuildinfo.pri ) {
    message("Using conan packages")
    CONFIG += conan_basic_setup
    include($$OUT_PWD/conanbuildinfo.pri)
    LIBS += -lGdi32
}
else{
    include(lib/boost.pri)
    include(lib/openssl.pri)
}

# Optional feature: QtWebEngine
#exists ($(QTDIR)/include/QtWebEngine/QtWebEngine) {
#    message(Using QWebEngine)
#    QT += webenginewidgets
#    DEFINES += "USEWEBENGINE"
#}

SOURCES += \
    src/Application.cpp \
    src/autogenerated/ResourcesAutogen.cpp \
    src/BrowserExtension.cpp \
    src/common/Channel.cpp \
    src/common/CompletionModel.cpp \
    src/common/DownloadManager.cpp \
    src/common/Env.cpp \
    src/common/LinkParser.cpp \
    src/common/NetworkManager.cpp \
    src/common/NetworkPrivate.cpp \
    src/common/NetworkRequest.cpp \
    src/common/NetworkResult.cpp \
    src/common/UsernameSet.cpp \
    src/controllers/accounts/Account.cpp \
    src/controllers/accounts/AccountController.cpp \
    src/controllers/accounts/AccountModel.cpp \
    src/controllers/commands/Command.cpp \
    src/controllers/commands/CommandController.cpp \
    src/controllers/commands/CommandModel.cpp \
    src/controllers/highlights/HighlightBlacklistModel.cpp \
    src/controllers/highlights/HighlightController.cpp \
    src/controllers/highlights/HighlightModel.cpp \
    src/controllers/highlights/UserHighlightModel.cpp \
    src/controllers/ignores/IgnoreController.cpp \
    src/controllers/ignores/IgnoreModel.cpp \
    src/controllers/moderationactions/ModerationAction.cpp \
    src/controllers/moderationactions/ModerationActionModel.cpp \
    src/controllers/moderationactions/ModerationActions.cpp \
    src/controllers/notifications/NotificationController.cpp \
    src/controllers/notifications/NotificationModel.cpp \
    src/controllers/pings/PingController.cpp \
    src/controllers/pings/PingModel.cpp \
    src/controllers/taggedusers/TaggedUser.cpp \
    src/controllers/taggedusers/TaggedUsersController.cpp \
    src/controllers/taggedusers/TaggedUsersModel.cpp \
    src/main.cpp \
    src/messages/Emote.cpp \
    src/messages/Image.cpp \
    src/messages/ImageSet.cpp \
    src/messages/layouts/MessageLayout.cpp \
    src/messages/layouts/MessageLayoutContainer.cpp \
    src/messages/layouts/MessageLayoutElement.cpp \
    src/messages/Link.cpp \
    src/messages/Message.cpp \
    src/messages/MessageBuilder.cpp \
    src/messages/MessageColor.cpp \
    src/messages/MessageContainer.cpp \
    src/messages/MessageElement.cpp \
    src/messages/search/AuthorPredicate.cpp \
    src/messages/search/LinkPredicate.cpp \
    src/messages/search/SubstringPredicate.cpp \
    src/providers/bttv/BttvEmotes.cpp \
    src/providers/bttv/LoadBttvChannelEmote.cpp \
    src/providers/chatterino/ChatterinoBadges.cpp \
    src/providers/emoji/Emojis.cpp \
    src/providers/ffz/FfzEmotes.cpp \
    src/providers/irc/AbstractIrcServer.cpp \
    src/providers/irc/IrcAccount.cpp \
    src/providers/irc/IrcChannel2.cpp \
    src/providers/irc/IrcConnection2.cpp \
    src/providers/irc/IrcServer.cpp \
    src/providers/LinkResolver.cpp \
    src/providers/twitch/ChatroomChannel.cpp \
    src/providers/twitch/IrcMessageHandler.cpp \
    src/providers/twitch/PartialTwitchUser.cpp \
    src/providers/twitch/PubsubActions.cpp \
    src/providers/twitch/PubsubClient.cpp \
    src/providers/twitch/PubsubHelpers.cpp \
    src/providers/twitch/TwitchAccount.cpp \
    src/providers/twitch/TwitchAccountManager.cpp \
    src/providers/twitch/TwitchApi.cpp \
    src/providers/twitch/TwitchBadges.cpp \
    src/providers/twitch/TwitchChannel.cpp \
    src/providers/twitch/TwitchEmotes.cpp \
    src/providers/twitch/TwitchHelpers.cpp \
    src/providers/twitch/TwitchMessageBuilder.cpp \
    src/providers/twitch/TwitchParseCheerEmotes.cpp \
    src/providers/twitch/TwitchServer.cpp \
    src/providers/twitch/TwitchUser.cpp \
    src/RunGui.cpp \
    src/singletons/Badges.cpp \
    src/singletons/Emotes.cpp \
    src/singletons/helper/GifTimer.cpp \
    src/singletons/helper/LoggingChannel.cpp \
    src/singletons/Logging.cpp \
    src/singletons/NativeMessaging.cpp \
    src/singletons/Paths.cpp \
    src/singletons/Resources.cpp \
    src/singletons/Settings.cpp \
    src/singletons/Theme.cpp \
    src/singletons/Toasts.cpp \
    src/singletons/TooltipPreviewImage.cpp \
    src/singletons/Updates.cpp \
    src/singletons/WindowManager.cpp \
    src/util/DebugCount.cpp \
    src/util/FormatTime.cpp \
    src/util/IncognitoBrowser.cpp \
    src/util/InitUpdateButton.cpp \
    src/util/JsonQuery.cpp \
    src/util/RapidjsonHelpers.cpp \
    src/util/StreamLink.cpp \
    src/widgets/AccountSwitchPopup.cpp \
    src/widgets/AccountSwitchWidget.cpp \
    src/widgets/AttachedWindow.cpp \
    src/widgets/dialogs/EmotePopup.cpp \
    src/widgets/dialogs/LastRunCrashDialog.cpp \
    src/widgets/dialogs/LoginDialog.cpp \
    src/widgets/dialogs/LogsPopup.cpp \
    src/widgets/dialogs/NotificationPopup.cpp \
    src/widgets/dialogs/QualityPopup.cpp \
    src/widgets/dialogs/SelectChannelDialog.cpp \
    src/widgets/dialogs/SettingsDialog.cpp \
    src/widgets/dialogs/TextInputDialog.cpp \
    src/widgets/dialogs/UpdateDialog.cpp \
    src/widgets/dialogs/UserInfoPopup.cpp \
    src/widgets/dialogs/WelcomeDialog.cpp \
    src/widgets/helper/ChannelView.cpp \
    src/widgets/helper/ComboBoxItemDelegate.cpp \
    src/widgets/helper/DebugPopup.cpp \
    src/widgets/helper/EditableModelView.cpp \
    src/widgets/helper/NotebookButton.cpp \
    src/widgets/helper/NotebookTab.cpp \
    src/widgets/helper/ResizingTextEdit.cpp \
    src/widgets/helper/ScrollbarHighlight.cpp \
    src/widgets/helper/SearchPopup.cpp \
    src/widgets/helper/SettingsDialogTab.cpp \
    src/widgets/Notebook.cpp \
    src/widgets/Scrollbar.cpp \
    src/widgets/settingspages/AboutPage.cpp \
    src/widgets/settingspages/AccountsPage.cpp \
    src/widgets/settingspages/CommandPage.cpp \
    src/widgets/settingspages/ExternalToolsPage.cpp \
    src/widgets/settingspages/GeneralPage.cpp \
    src/widgets/settingspages/HighlightingPage.cpp \
    src/widgets/settingspages/IgnoresPage.cpp \
    src/widgets/settingspages/KeyboardSettingsPage.cpp \
    src/widgets/settingspages/ModerationPage.cpp \
    src/widgets/settingspages/NotificationPage.cpp \
    src/widgets/settingspages/SettingsPage.cpp \
    src/widgets/splits/ClosedSplits.cpp \
    src/widgets/splits/Split.cpp \
    src/widgets/splits/SplitContainer.cpp \
    src/widgets/splits/SplitHeader.cpp \
    src/widgets/splits/SplitInput.cpp \
    src/widgets/splits/SplitOverlay.cpp \
    src/widgets/StreamView.cpp \
    src/widgets/Window.cpp \

HEADERS += \
    src/Application.hpp \
    src/autogenerated/ResourcesAutogen.hpp \
    src/BrowserExtension.hpp \
    src/common/Aliases.hpp \
    src/common/Atomic.hpp \
    src/common/Channel.hpp \
    src/common/Common.hpp \
    src/common/CompletionModel.hpp \
    src/common/ConcurrentMap.hpp \
    src/common/DownloadManager.hpp \
    src/common/Env.hpp \
    src/common/LinkParser.hpp \
    src/common/NetworkCommon.hpp \
    src/common/NetworkManager.hpp \
    src/common/NetworkPrivate.hpp \
    src/common/NetworkRequest.hpp \
    src/common/NetworkResult.hpp \
    src/common/NullablePtr.hpp \
    src/common/ProviderId.hpp \
    src/common/SignalVector.hpp \
    src/common/SignalVectorModel.hpp \
    src/common/UniqueAccess.hpp \
    src/common/UsernameSet.hpp \
    src/common/Version.hpp \
    src/controllers/accounts/Account.hpp \
    src/controllers/accounts/AccountController.hpp \
    src/controllers/accounts/AccountModel.hpp \
    src/controllers/commands/Command.hpp \
    src/controllers/commands/CommandController.hpp \
    src/controllers/commands/CommandModel.hpp \
    src/controllers/highlights/HighlightBlacklistModel.hpp \
    src/controllers/highlights/HighlightBlacklistUser.hpp \
    src/controllers/highlights/HighlightController.hpp \
    src/controllers/highlights/HighlightModel.hpp \
    src/controllers/highlights/HighlightPhrase.hpp \
    src/controllers/highlights/UserHighlightModel.hpp \
    src/controllers/ignores/IgnoreController.hpp \
    src/controllers/ignores/IgnoreModel.hpp \
    src/controllers/ignores/IgnorePhrase.hpp \
    src/controllers/moderationactions/ModerationAction.hpp \
    src/controllers/moderationactions/ModerationActionModel.hpp \
    src/controllers/moderationactions/ModerationActions.hpp \
    src/controllers/notifications/NotificationController.hpp \
    src/controllers/notifications/NotificationModel.hpp \
    src/controllers/pings/PingController.hpp \
    src/controllers/pings/PingModel.hpp \
    src/controllers/taggedusers/TaggedUser.hpp \
    src/controllers/taggedusers/TaggedUsersController.hpp \
    src/controllers/taggedusers/TaggedUsersModel.hpp \
    src/ForwardDecl.hpp \
    src/messages/Emote.hpp \
    src/messages/Image.hpp \
    src/messages/ImageSet.hpp \
    src/messages/layouts/MessageLayout.hpp \
    src/messages/layouts/MessageLayoutContainer.hpp \
    src/messages/layouts/MessageLayoutElement.hpp \
    src/messages/LimitedQueue.hpp \
    src/messages/LimitedQueueSnapshot.hpp \
    src/messages/Link.hpp \
    src/messages/Message.hpp \
    src/messages/MessageBuilder.hpp \
    src/messages/MessageColor.hpp \
    src/messages/MessageContainer.hpp \
    src/messages/MessageElement.hpp \
    src/messages/MessageParseArgs.hpp \
    src/messages/search/AuthorPredicate.hpp \
    src/messages/search/LinkPredicate.hpp \
    src/messages/search/MessagePredicate.hpp \
    src/messages/search/SubstringPredicate.hpp \
    src/messages/Selection.hpp \
    src/PrecompiledHeader.hpp \
    src/providers/bttv/BttvEmotes.hpp \
    src/providers/bttv/LoadBttvChannelEmote.hpp \
    src/providers/chatterino/ChatterinoBadges.hpp \
    src/providers/emoji/Emojis.hpp \
    src/providers/ffz/FfzEmotes.hpp \
    src/providers/irc/AbstractIrcServer.hpp \
    src/providers/irc/IrcAccount.hpp \
    src/providers/irc/IrcChannel2.hpp \
    src/providers/irc/IrcConnection2.hpp \
    src/providers/irc/IrcServer.hpp \
    src/providers/LinkResolver.hpp \
    src/providers/twitch/ChatroomChannel.hpp \
    src/providers/twitch/EmoteValue.hpp \
    src/providers/twitch/IrcMessageHandler.hpp \
    src/providers/twitch/PartialTwitchUser.hpp \
    src/providers/twitch/PubsubActions.hpp \
    src/providers/twitch/PubsubClient.hpp \
    src/providers/twitch/PubsubHelpers.hpp \
    src/providers/twitch/TwitchAccount.hpp \
    src/providers/twitch/TwitchAccountManager.hpp \
    src/providers/twitch/TwitchApi.hpp \
    src/providers/twitch/TwitchBadges.hpp \
    src/providers/twitch/TwitchChannel.hpp \
    src/providers/twitch/TwitchCommon.hpp \
    src/providers/twitch/TwitchEmotes.hpp \
    src/providers/twitch/TwitchHelpers.hpp \
    src/providers/twitch/TwitchMessageBuilder.hpp \
    src/providers/twitch/TwitchParseCheerEmotes.hpp \
    src/providers/twitch/TwitchServer.hpp \
    src/providers/twitch/TwitchUser.hpp \
    src/RunGui.hpp \
    src/singletons/Badges.hpp \
    src/singletons/Emotes.hpp \
    src/singletons/helper/GifTimer.hpp \
    src/singletons/helper/LoggingChannel.hpp \
    src/singletons/Logging.hpp \
    src/singletons/NativeMessaging.hpp \
    src/singletons/Paths.hpp \
    src/singletons/Resources.hpp \
    src/singletons/Settings.hpp \
    src/singletons/Theme.hpp \
    src/singletons/Toasts.hpp \
    src/singletons/TooltipPreviewImage.hpp \
    src/singletons/Updates.hpp \
    src/singletons/WindowManager.hpp \
    src/util/ConcurrentMap.hpp \
    src/util/DebugCount.hpp \
    src/util/FormatTime.hpp \
    src/util/IncognitoBrowser.hpp \
    src/util/InitUpdateButton.hpp \
    src/util/IrcHelpers.hpp \
    src/util/IsBigEndian.hpp \
    src/util/JsonQuery.hpp \
    src/util/LayoutCreator.hpp \
    src/util/QObjectRef.hpp \
    src/util/QStringHash.hpp \
    src/util/rangealgorithm.hpp \
    src/util/RapidjsonHelpers.hpp \
    src/util/RemoveScrollAreaBackground.hpp \
    src/util/SampleCheerMessages.hpp \
    src/util/SharedPtrElementLess.hpp \
    src/util/StandardItemHelper.hpp \
    src/util/StreamLink.hpp \
    src/widgets/AccountSwitchPopup.hpp \
    src/widgets/AccountSwitchWidget.hpp \
    src/widgets/AttachedWindow.hpp \
    src/widgets/dialogs/EmotePopup.hpp \
    src/widgets/dialogs/LastRunCrashDialog.hpp \
    src/widgets/dialogs/LoginDialog.hpp \
    src/widgets/dialogs/LogsPopup.hpp \
    src/widgets/dialogs/NotificationPopup.hpp \
    src/widgets/dialogs/QualityPopup.hpp \
    src/widgets/dialogs/SelectChannelDialog.hpp \
    src/widgets/dialogs/SettingsDialog.hpp \
    src/widgets/dialogs/TextInputDialog.hpp \
    src/widgets/dialogs/UpdateDialog.hpp \
    src/widgets/dialogs/UserInfoPopup.hpp \
    src/widgets/dialogs/WelcomeDialog.hpp \
    src/widgets/helper/ChannelView.hpp \
    src/widgets/helper/ComboBoxItemDelegate.hpp \
    src/widgets/helper/CommonTexts.hpp \
    src/widgets/helper/DebugPopup.hpp \
    src/widgets/helper/EditableModelView.hpp \
    src/widgets/helper/Line.hpp \
    src/widgets/helper/NotebookButton.hpp \
    src/widgets/helper/NotebookTab.hpp \
    src/widgets/helper/ResizingTextEdit.hpp \
    src/widgets/helper/ScrollbarHighlight.hpp \
    src/widgets/helper/SearchPopup.hpp \
    src/widgets/helper/SettingsDialogTab.hpp \
    src/widgets/Notebook.hpp \
    src/widgets/Scrollbar.hpp \
    src/widgets/settingspages/AboutPage.hpp \
    src/widgets/settingspages/AccountsPage.hpp \
    src/widgets/settingspages/CommandPage.hpp \
    src/widgets/settingspages/ExternalToolsPage.hpp \
    src/widgets/settingspages/GeneralPage.hpp \
    src/widgets/settingspages/HighlightingPage.hpp \
    src/widgets/settingspages/IgnoresPage.hpp \
    src/widgets/settingspages/KeyboardSettingsPage.hpp \
    src/widgets/settingspages/ModerationPage.hpp \
    src/widgets/settingspages/NotificationPage.hpp \
    src/widgets/settingspages/SettingsPage.hpp \
    src/widgets/splits/ClosedSplits.hpp \
    src/widgets/splits/Split.hpp \
    src/widgets/splits/SplitContainer.hpp \
    src/widgets/splits/SplitHeader.hpp \
    src/widgets/splits/SplitInput.hpp \
    src/widgets/splits/SplitOverlay.hpp \
    src/widgets/StreamView.hpp \
    src/widgets/Window.hpp \

RESOURCES += \
    resources/resources.qrc \
    resources/resources_autogenerated.qrc

DISTFILES +=

FORMS +=

# do not use windows min/max macros
#win32 {
#    DEFINES += NOMINMAX
#}

linux:isEmpty(PREFIX) {
    message("Using default installation prefix (/usr/local). Change PREFIX in qmake command")
    PREFIX = /usr/local
}

linux {
    desktop.files = resources/chatterino.desktop
    desktop.path = $$PREFIX/share/applications

    build_icons.path = .
    build_icons.commands = @echo $$PWD  && mkdir -p $$PWD/resources/linuxinstall/icons/hicolor/256x256 && cp $$PWD/resources/icon.png $$PWD/resources/linuxinstall/icons/hicolor/256x256/chatterino.png

    icon.files = $$PWD/resources/linuxinstall/icons/hicolor/256x256/chatterino.png
    icon.path = $$PREFIX/share/icons/hicolor/256x256/apps

    target.path = $$PREFIX/bin

    INSTALLS += desktop build_icons icon target
}

git_commit=$$(GIT_COMMIT)
git_release=$$(GIT_RELEASE)
# Git data
isEmpty(git_commit) {
git_commit=$$system(git rev-parse HEAD)
}
isEmpty(git_release) {
git_release=$$system(git describe)
}
git_hash = $$str_member($$git_commit, 0, 8)

# Passing strings as defines requires you to use this weird triple-escape then quotation mark syntax.
# https://stackoverflow.com/questions/3348711/add-a-define-to-qmake-with-a-value/18343449#18343449
DEFINES += CHATTERINO_GIT_COMMIT=\\\"$$git_commit\\\"
DEFINES += CHATTERINO_GIT_RELEASE=\\\"$$git_release\\\"
DEFINES += CHATTERINO_GIT_HASH=\\\"$$git_hash\\\"
