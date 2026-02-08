pragma ComponentBehavior: Bound

import QtQuick

QtObject {
  id: root

  property bool isDark: true

  readonly property int animationDuration: 250

  readonly property color seedLight: '#f8fefb'
  readonly property color seedDark: "#0B1518"
  readonly property color accentLight: '#7ce4c8'
  readonly property color accentDark: "#00705f"
  readonly property color warningDark: '#ff9800'
  readonly property color warningLight: '#9a3412'
  readonly property color errorDark: '#fe2c5a'
  readonly property color errorLight: "#fe2c5a"
  readonly property color infoDark: '#3b85ee'
  readonly property color infoLight: "#3b85ee"

  readonly property real hoveredColorCoeff: 1.25
  readonly property real backgroundHeaderLightnessCoeff: 1.1
  readonly property real backgroundFooterLightnessCoeff: 1.1
  readonly property real backgroundCardLightnessCoeff: 1.1
  readonly property real borderLightnessCoeff: 4.0
  readonly property real textPrimaryLightnessCoeff: 20.0
  readonly property real textSecondaryLightnessCoeff: 0.95
  readonly property real textTertiaryDarkLightnessCoeff: 0.95
  readonly property real glassCoeff: 0.95
  readonly property real backgroundGlassCardGlassCoeff: 0.2
  readonly property real backgroundGlassCardHoverGlassCoeff: 0.3
  readonly property real backgroundGlassCardPressedGlassCoeff: 0.4

  readonly property color accent: root.isDark ? root.accentDark : root.accentLight
  readonly property color accentHoverDark: Qt.lighter(root.accentDark, root.hoveredColorCoeff)
  readonly property color accentHoverLight: Qt.darker(root.accentLight, root.hoveredColorCoeff)
  readonly property color accentHover: root.isDark ? root.accentHoverDark : root.accentHoverLight
  readonly property color accentGlassDark: Qt.alpha(root.accentDark, root.glassCoeff)
  readonly property color accentGlassLight: Qt.alpha(root.accentLight, root.glassCoeff)
  readonly property color accentGlass: root.isDark ? root.accentGlassDark : root.accentGlassLight
  readonly property color accentGlassHoverDark: Qt.alpha(root.accentHoverDark, root.glassCoeff)
  readonly property color accentGlassHoverLight: Qt.alpha(root.accentHoverLight, root.glassCoeff)
  readonly property color accentGlassHover: root.isDark ? root.accentGlassHoverDark : root.accentGlassHoverLight

  readonly property color warning: root.isDark ? root.warningDark : root.warningLight
  readonly property color warningHoverDark: Qt.lighter(root.warningDark, root.hoveredColorCoeff)
  readonly property color warningHoverLight: Qt.darker(root.warningLight, root.hoveredColorCoeff)
  readonly property color warningHover: root.isDark ? root.warningHoverDark : root.warningHoverLight
  readonly property color warningGlassDark: Qt.alpha(root.warningDark, root.glassCoeff)
  readonly property color warningGlassLight: Qt.alpha(root.warningLight, root.glassCoeff)
  readonly property color warningGlass: root.isDark ? root.warningGlassDark : root.warningGlassLight
  readonly property color warningGlassHoverDark: Qt.alpha(root.warningHoverDark, root.glassCoeff)
  readonly property color warningGlassHoverLight: Qt.alpha(root.warningHoverLight, root.glassCoeff)
  readonly property color warningGlassHover: root.isDark ? root.warningGlassHoverDark : root.warningGlassHoverLight

  readonly property color error: root.isDark ? root.errorDark : root.errorLight
  readonly property color errorHoverDark: Qt.lighter(root.errorDark, root.hoveredColorCoeff)
  readonly property color errorHoverLight: Qt.darker(root.errorLight, root.hoveredColorCoeff)
  readonly property color errorHover: root.isDark ? root.errorHoverDark : root.errorHoverLight
  readonly property color errorGlassDark: Qt.alpha(root.errorDark, root.glassCoeff)
  readonly property color errorGlassLight: Qt.alpha(root.errorLight, root.glassCoeff)
  readonly property color errorGlass: root.isDark ? root.errorGlassDark : root.errorGlassLight
  readonly property color errorGlassHoverDark: Qt.alpha(root.errorHoverDark, root.glassCoeff)
  readonly property color errorGlassHoverLight: Qt.alpha(root.errorHoverLight, root.glassCoeff)
  readonly property color errorGlassHover: root.isDark ? root.errorGlassHoverDark : root.errorGlassHoverLight

  readonly property color info: root.isDark ? root.infoDark : root.infoLight
  readonly property color infoHoverDark: Qt.lighter(root.infoDark, root.hoveredColorCoeff)
  readonly property color infoHoverLight: Qt.darker(root.infoLight, root.hoveredColorCoeff)
  readonly property color infoHover: root.isDark ? root.infoHoverDark : root.infoHoverLight
  readonly property color infoGlassDark: Qt.alpha(root.infoDark, root.glassCoeff)
  readonly property color infoGlassLight: Qt.alpha(root.infoLight, root.glassCoeff)
  readonly property color infoGlass: root.isDark ? root.infoGlassDark : root.infoGlassLight
  readonly property color infoGlassHoverDark: Qt.alpha(root.infoHoverDark, root.glassCoeff)
  readonly property color infoGlassHoverLight: Qt.alpha(root.infoHoverLight, root.glassCoeff)
  readonly property color infoGlassHover: root.isDark ? root.infoGlassHoverDark : root.infoGlassHoverLight

  readonly property color backgroundDark: root.seedDark
  readonly property color backgroundLight: root.seedLight
  readonly property color background: root.isDark ? root.backgroundDark : root.backgroundLight
  readonly property color backgroundHoverDark: Qt.lighter(root.backgroundDark, root.hoveredColorCoeff)
  readonly property color backgroundHoverLight: Qt.darker(root.backgroundLight, root.hoveredColorCoeff)
  readonly property color backgroundHover: root.isDark ? root.backgroundHoverDark : root.backgroundHoverLight
  readonly property color backgroundGlassDark: Qt.alpha(root.backgroundDark, root.glassCoeff)
  readonly property color backgroundGlassLight: Qt.alpha(root.backgroundLight, root.glassCoeff)
  readonly property color backgroundGlass: root.isDark ? root.backgroundGlassDark : root.backgroundGlassLight
  readonly property color backgroundGlassHoverDark: Qt.alpha(root.backgroundHoverDark, root.glassCoeff)
  readonly property color backgroundGlassHoverLight: Qt.alpha(root.backgroundHoverLight, root.glassCoeff)
  readonly property color backgroundGlassHover: root.isDark ? root.backgroundGlassHoverDark : root.backgroundGlassHoverLight

  readonly property color backgroundHeaderDark: Qt.lighter(root.accentDark, root.backgroundHeaderLightnessCoeff)
  readonly property color backgroundHeaderLight: Qt.darker(root.accentLight, root.backgroundHeaderLightnessCoeff)
  readonly property color backgroundHeader: root.isDark ? root.backgroundHeaderDark : root.backgroundHeaderLight
  readonly property color backgroundHeaderHoverDark: Qt.lighter(root.backgroundHeaderDark, root.hoveredColorCoeff)
  readonly property color backgroundHeaderHoverLight: Qt.darker(root.backgroundHeaderLight, root.hoveredColorCoeff)
  readonly property color backgroundHeaderHover: root.isDark ? root.backgroundHeaderHoverDark : root.backgroundHeaderHoverLight
  readonly property color backgroundGlassHeaderDark: Qt.alpha(root.backgroundHeaderDark, root.glassCoeff)
  readonly property color backgroundGlassHeaderLight: Qt.alpha(root.backgroundHeaderLight, root.glassCoeff)
  readonly property color backgroundGlassHeader: root.isDark ? root.backgroundGlassHeaderDark : root.backgroundGlassHeaderLight
  readonly property color backgroundGlassHeaderHoverDark: Qt.alpha(root.backgroundHeaderHoverDark, root.glassCoeff)
  readonly property color backgroundGlassHeaderHoverLight: Qt.alpha(root.backgroundHeaderHoverLight, root.glassCoeff)
  readonly property color backgroundGlassHeaderHover: root.isDark ? root.backgroundGlassHeaderHoverDark : root.backgroundGlassHeaderHoverLight

  readonly property color backgroundFooterDark: Qt.lighter(root.accentDark, root.backgroundFooterLightnessCoeff)
  readonly property color backgroundFooterLight: Qt.darker(root.accentLight, root.backgroundFooterLightnessCoeff)
  readonly property color backgroundFooter: root.isDark ? root.backgroundFooterDark : root.backgroundFooterLight
  readonly property color backgroundFooterHoverDark: Qt.lighter(root.backgroundFooterDark, root.hoveredColorCoeff)
  readonly property color backgroundFooterHoverLight: Qt.darker(root.backgroundFooterLight, root.hoveredColorCoeff)
  readonly property color backgroundFooterHover: root.isDark ? root.backgroundFooterHoverDark : root.backgroundFooterHoverLight
  readonly property color backgroundGlassFooterDark: Qt.alpha(root.backgroundFooterDark, root.glassCoeff)
  readonly property color backgroundGlassFooterLight: Qt.alpha(root.backgroundFooterLight, root.glassCoeff)
  readonly property color backgroundGlassFooter: root.isDark ? root.backgroundGlassFooterDark : root.backgroundGlassFooterLight
  readonly property color backgroundGlassFooterHoverDark: Qt.alpha(root.backgroundFooterHoverDark, root.glassCoeff)
  readonly property color backgroundGlassFooterHoverLight: Qt.alpha(root.backgroundFooterHoverLight, root.glassCoeff)
  readonly property color backgroundGlassFooterHover: root.isDark ? root.backgroundGlassFooterHoverDark : root.backgroundGlassFooterHoverLight

  readonly property color backgroundCardDark: Qt.lighter(root.backgroundDark, root.backgroundCardLightnessCoeff)
  readonly property color backgroundCardLight: Qt.darker(root.backgroundLight, root.backgroundCardLightnessCoeff)
  readonly property color backgroundCard: root.isDark ? root.backgroundCardDark : root.backgroundCardLight
  readonly property color backgroundCardHoverDark: Qt.lighter(root.backgroundCardDark, root.hoveredColorCoeff)
  readonly property color backgroundCardHoverLight: Qt.darker(root.backgroundCardLight, root.hoveredColorCoeff)
  readonly property color backgroundCardHover: root.isDark ? root.backgroundCardHoverDark : root.backgroundCardHoverLight
  readonly property color backgroundGlassCardDark: Qt.alpha(root.backgroundCardDark, root.glassCoeff)
  readonly property color backgroundGlassCardLight: Qt.alpha(root.backgroundCardLight, root.glassCoeff)
  readonly property color backgroundGlassCard: root.isDark ? root.backgroundGlassCardDark : root.backgroundGlassCardLight
  readonly property color backgroundGlassCardHoverDark: Qt.alpha(root.backgroundCardHoverDark, root.glassCoeff)
  readonly property color backgroundGlassCardHoverLight: Qt.alpha(root.backgroundCardHoverLight, root.glassCoeff)
  readonly property color backgroundGlassCardHover: root.isDark ? root.backgroundGlassCardHoverDark : root.backgroundGlassCardHoverLight

  readonly property color borderDark: Qt.lighter(root.backgroundDark, root.borderLightnessCoeff)
  readonly property color borderLight: Qt.darker(root.backgroundLight, root.borderLightnessCoeff)
  readonly property color border: root.isDark ? root.borderDark : root.borderLight

  readonly property color textPrimaryDark: Qt.lighter(root.backgroundDark, root.textPrimaryLightnessCoeff)
  readonly property color textPrimaryLight: Qt.darker(root.backgroundLight, root.textPrimaryLightnessCoeff)
  readonly property color textPrimary: root.isDark ? root.textPrimaryDark : root.textPrimaryLight

  readonly property color textSecondaryDark: Qt.lighter(root.textPrimaryDark, root.textSecondaryLightnessCoeff)
  readonly property color textSecondaryLight: Qt.darker(root.textPrimaryLight, root.textSecondaryLightnessCoeff)
  readonly property color textSecondary: root.isDark ? textSecondaryDark : textSecondaryLight

  readonly property color textTertiaryDark: Qt.lighter(root.textSecondaryDark, root.textTertiaryDarkLightnessCoeff)
  readonly property color textTertiaryLight: Qt.darker(root.textSecondaryLight, root.textTertiaryDarkLightnessCoeff)
  readonly property color textTertiary: root.isDark ? root.textTertiaryDark : root.textTertiaryLight

  readonly property color glassBorder: Qt.alpha(root.border, root.glassCoeff)

  readonly property color accentGlassGradientStart: root.isDark ? root.accentGlassHoverDark : root.accentGlassLight
  readonly property color accentGlassGradientEnd: root.isDark ? root.accentGlassDark : root.accentGlassHoverLight

  readonly property color backgroundGlassCardGradientStart: root.isDark ? Qt.alpha(root.accentGlassHoverDark, root.backgroundGlassCardGlassCoeff) : Qt.alpha(root.accentGlassLight, root.backgroundGlassCardGlassCoeff)
  readonly property color backgroundGlassCardGradientEnd: root.isDark ? Qt.alpha(root.accentGlassDark, root.backgroundGlassCardGlassCoeff) : Qt.alpha(root.accentGlassHoverLight, root.backgroundGlassCardGlassCoeff)

  readonly property color backgroundGlassCardHoverGradientStart: root.isDark ? Qt.alpha(root.accentGlassHoverDark, root.backgroundGlassCardHoverGlassCoeff) : Qt.alpha(root.accentGlassLight, root.backgroundGlassCardHoverGlassCoeff)
  readonly property color backgroundGlassCardHoverGradientEnd: root.isDark ? Qt.alpha(root.accentGlassDark, root.backgroundGlassCardHoverGlassCoeff) : Qt.alpha(root.accentGlassHoverLight, root.backgroundGlassCardHoverGlassCoeff)

  readonly property color backgroundGlassCardPressedGradientStart: root.isDark ? Qt.alpha(root.accentGlassDark, root.backgroundGlassCardPressedGlassCoeff) : Qt.alpha(root.accentGlassHoverLight, root.backgroundGlassCardPressedGlassCoeff)
  readonly property color backgroundGlassCardPressedGradientEnd: root.isDark ? Qt.alpha(root.accentGlassHoverDark, root.backgroundGlassCardPressedGlassCoeff) : Qt.alpha(root.accentGlassLight, root.backgroundGlassCardPressedGlassCoeff)

  readonly property color backgroundGlassHeaderGradientStart: root.isDark ? root.backgroundGlassHeaderHoverDark : root.backgroundGlassHeaderLight
  readonly property color backgroundGlassHeaderGradientEnd: root.isDark ? root.backgroundGlassHeaderDark : root.backgroundGlassHeaderHoverLight
  readonly property color backgroundGlassFooterGradientStart: root.isDark ? root.backgroundGlassFooterHoverDark : root.backgroundGlassFooterLight
  readonly property color backgroundGlassFooterGradientEnd: root.isDark ? root.backgroundGlassFooterDark : root.backgroundGlassFooterHoverLight
  readonly property color backgroundGlassGradientStart: root.isDark ? root.backgroundGlassHoverDark : root.backgroundGlassLight
  readonly property color backgroundGlassGradientEnd: root.isDark ? root.backgroundGlassDark : root.backgroundGlassHoverLight
  readonly property color buttonPressedGlassAccentGradientStart: root.isDark ? root.accentGlassDark : root.accentGlassHoverLight
  readonly property color buttonPressedGlassAccentGradientEnd: root.isDark ? root.accentGlassHoverDark : root.accentGlassLight

  readonly property var languageHues: {
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
  }

  readonly property real languageLightnessDark: 0.50
  readonly property real languageLightnessLight: 0.25
  readonly property real languageSaturation: 0.50

  function getLanguageColor(language) {
    // Hue (0-360°): the color itself on the color wheel (0 = red, 120 = green, 240 = blue)
    const hue = root.languageHues[language] / 360;

    if (hue === NaN) {
      return root.textSecondary;
    }

    // Saturation (0-1): how vivid the color is (0 = gray, 1 = fully colorful)
    const saturation = root.languageSaturation;
    // Lightness (0-1): how bright the color is (0 = black, 0.5 = the "pure" color, 1 = white)
    const lightness = root.isDark ? root.languageLightnessDark : root.languageLightnessLight;
    // alpha (opacity, 1.0 = fully opaque)
    const alpha = 1;

    return Qt.hsla(hue, saturation, lightness, alpha);
  }

  function toggleTheme() {
    root.isDark = !root.isDark;
  }
}
