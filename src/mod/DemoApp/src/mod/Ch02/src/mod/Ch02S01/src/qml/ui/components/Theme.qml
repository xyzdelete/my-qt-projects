pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

QtObject {
  id: theme

  property bool isDark: false

  readonly property color seedDark: "#0B1518"
  readonly property color seedLight: '#f8fefb'
  readonly property color seed: theme.isDark ? theme.seedDark : theme.seedLight
  readonly property color background: theme.seed

  readonly property color backgroundHeader: theme.isDark ? Qt.lighter(theme.seedDark, 2.00) : Qt.darker(theme.seedLight, 1.10)
  readonly property color backgroundFooter: theme.isDark ? Qt.lighter(theme.seedDark, 2.00) : Qt.darker(theme.seedLight, 1.10)
  readonly property color backgroundHover: theme.isDark ? Qt.lighter(theme.seedDark, 2.50) : Qt.darker(theme.seedLight, 1.20)
  readonly property color backgroundCard: theme.isDark ? Qt.lighter(theme.seedDark, 3.50) : Qt.darker(theme.seedLight, 1.10)

  readonly property color textPrimary: theme.isDark ? "#F0F5F2" : Qt.darker("#F0F5F2", 4.00)
  readonly property color textSecondary: theme.isDark ? "#B6C8C2" : Qt.darker("#B6C8C2", 3.00)
  readonly property color textTertiary: theme.isDark ? "#94AAA2" : Qt.darker("#94AAA2", 2.00)

  readonly property color border: theme.isDark ? Qt.lighter(theme.seedDark, 4.00) : Qt.darker(theme.seedLight, 4.0)
  readonly property color focusRing: theme.isDark ? "#A4E9D2" : "#005447"

  readonly property color accentLight: "#76DCC0"
  readonly property color accentDark: Qt.lighter("#005447", 2.0)
  readonly property color blueDark: "#91BDF5"
  readonly property color blueLight: "#244F8C"
  readonly property color accentMain: theme.accentDark
  readonly property color accent: theme.isDark ? theme.accentDark : theme.accentLight
  readonly property color accentHover: theme.isDark ? Qt.darker(theme.accentDark, 2.00) : Qt.darker(theme.accentLight, 1.50)
  readonly property color accentPressed: theme.isDark ? Qt.darker(theme.accentDark, 1.50) : Qt.darker(theme.accentLight, 1.50)
  readonly property color blue: theme.isDark ? theme.blueDark : theme.blueLight
  readonly property color textOnBlue: theme.isDark ? "#14243A" : "#FFFFFF"

  readonly property color success: "#78D9A9"
  readonly property color successHover: theme.isDark ? Qt.darker(theme.success, 2.00) : Qt.darker(theme.success, 1.20)
  readonly property color warning: "#F0CB78"
  readonly property color warningHover: theme.isDark ? Qt.darker(theme.warning, 2.00) : Qt.darker(theme.warning, 1.20)
  readonly property color error: "#FF9F9F"
  readonly property color errorHover: theme.isDark ? Qt.darker(theme.error, 2.00) : Qt.darker(theme.error, 1.20)
  readonly property color info: "#91BDF5"
  readonly property color infoHover: theme.isDark ? Qt.darker(theme.info, 2.00) : Qt.darker(theme.info, 1.20)

  readonly property real glassCoeff: 0.95
  readonly property color glassBackground: Qt.alpha(theme.background, theme.glassCoeff)
  readonly property color glassBorder: Qt.alpha(theme.border, theme.glassCoeff)
  readonly property color glassBackgroundHeader: Qt.alpha(theme.backgroundHeader, theme.glassCoeff)
  readonly property color glassBackgroundFooter: Qt.alpha(theme.backgroundFooter, theme.glassCoeff)
  readonly property color glassBackgroundHover: Qt.alpha(theme.backgroundHover, theme.glassCoeff)
  readonly property color glassBackgroundCard: Qt.alpha(theme.backgroundCard, theme.glassCoeff)

  readonly property real languageLightnessDark: 0.70
  readonly property real languageLightnessLight: 0.30
  readonly property real languageSaturation: 0.60

  readonly property var languageHues: ({
      "JavaScript": 52,
      "Python": 208,
      "Java": 28,
      "C++": 200,
      "C": 212,
      "C#": 125,
      "TypeScript": 211,
      "Go": 189,
      "Rust": 18,
      "Swift": 14,
      "Kotlin": 262,
      "Ruby": 3,
      "PHP": 235,
      "HTML": 12,
      "CSS": 215,
      "Shell": 100,
      "Dart": 197,
      "Vue": 153,
      "React": 190
    })

  function getLanguageColor(language) {
    const hue = theme.languageHues[language];

    if (hue === undefined) {
      return theme.textSecondary;
    }

    const sat = language === "C" ? 0.30 : theme.languageSaturation;
    const light = theme.isDark ? theme.languageLightnessDark : theme.languageLightnessLight;

    return Qt.hsla(hue / 360, sat, light, 1.0);
  }

  readonly property int normalAnimation: 250
  readonly property int slowAnimation: theme.normalAnimation * 2

  function toggleTheme() {
    theme.isDark = !theme.isDark;
  }
}
