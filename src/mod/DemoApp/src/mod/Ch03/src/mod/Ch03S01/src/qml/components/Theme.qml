pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick

QtObject {
  id: rootId

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

  readonly property color accent: rootId.isDark ? rootId.accentDark : rootId.accentLight
  readonly property color accentHoverDark: rootId.lighterOf(rootId.accentDark, rootId.hoveredColorCoeff)
  readonly property color accentHoverLight: rootId.darkerOf(rootId.accentLight, rootId.hoveredColorCoeff)
  readonly property color accentHover: rootId.isDark ? rootId.accentHoverDark : rootId.accentHoverLight
  readonly property color accentGlassDark: rootId.alphaOf(rootId.accentDark, rootId.glassCoeff)
  readonly property color accentGlassLight: rootId.alphaOf(rootId.accentLight, rootId.glassCoeff)
  readonly property color accentGlass: rootId.isDark ? rootId.accentGlassDark : rootId.accentGlassLight
  readonly property color accentGlassHoverDark: rootId.alphaOf(rootId.accentHoverDark, rootId.glassCoeff)
  readonly property color accentGlassHoverLight: rootId.alphaOf(rootId.accentHoverLight, rootId.glassCoeff)
  readonly property color accentGlassHover: rootId.isDark ? rootId.accentGlassHoverDark : rootId.accentGlassHoverLight

  readonly property color warning: rootId.isDark ? rootId.warningDark : rootId.warningLight
  readonly property color warningHoverDark: rootId.lighterOf(rootId.warningDark, rootId.hoveredColorCoeff)
  readonly property color warningHoverLight: rootId.darkerOf(rootId.warningLight, rootId.hoveredColorCoeff)
  readonly property color warningHover: rootId.isDark ? rootId.warningHoverDark : rootId.warningHoverLight
  readonly property color warningGlassDark: rootId.alphaOf(rootId.warningDark, rootId.glassCoeff)
  readonly property color warningGlassLight: rootId.alphaOf(rootId.warningLight, rootId.glassCoeff)
  readonly property color warningGlass: rootId.isDark ? rootId.warningGlassDark : rootId.warningGlassLight
  readonly property color warningGlassHoverDark: rootId.alphaOf(rootId.warningHoverDark, rootId.glassCoeff)
  readonly property color warningGlassHoverLight: rootId.alphaOf(rootId.warningHoverLight, rootId.glassCoeff)
  readonly property color warningGlassHover: rootId.isDark ? rootId.warningGlassHoverDark : rootId.warningGlassHoverLight

  readonly property color error: rootId.isDark ? rootId.errorDark : rootId.errorLight
  readonly property color errorHoverDark: rootId.lighterOf(rootId.errorDark, rootId.hoveredColorCoeff)
  readonly property color errorHoverLight: rootId.darkerOf(rootId.errorLight, rootId.hoveredColorCoeff)
  readonly property color errorHover: rootId.isDark ? rootId.errorHoverDark : rootId.errorHoverLight
  readonly property color errorGlassDark: rootId.alphaOf(rootId.errorDark, rootId.glassCoeff)
  readonly property color errorGlassLight: rootId.alphaOf(rootId.errorLight, rootId.glassCoeff)
  readonly property color errorGlass: rootId.isDark ? rootId.errorGlassDark : rootId.errorGlassLight
  readonly property color errorGlassHoverDark: rootId.alphaOf(rootId.errorHoverDark, rootId.glassCoeff)
  readonly property color errorGlassHoverLight: rootId.alphaOf(rootId.errorHoverLight, rootId.glassCoeff)
  readonly property color errorGlassHover: rootId.isDark ? rootId.errorGlassHoverDark : rootId.errorGlassHoverLight

  readonly property color info: rootId.isDark ? rootId.infoDark : rootId.infoLight
  readonly property color infoHoverDark: rootId.lighterOf(rootId.infoDark, rootId.hoveredColorCoeff)
  readonly property color infoHoverLight: rootId.darkerOf(rootId.infoLight, rootId.hoveredColorCoeff)
  readonly property color infoHover: rootId.isDark ? rootId.infoHoverDark : rootId.infoHoverLight
  readonly property color infoGlassDark: rootId.alphaOf(rootId.infoDark, rootId.glassCoeff)
  readonly property color infoGlassLight: rootId.alphaOf(rootId.infoLight, rootId.glassCoeff)
  readonly property color infoGlass: rootId.isDark ? rootId.infoGlassDark : rootId.infoGlassLight
  readonly property color infoGlassHoverDark: rootId.alphaOf(rootId.infoHoverDark, rootId.glassCoeff)
  readonly property color infoGlassHoverLight: rootId.alphaOf(rootId.infoHoverLight, rootId.glassCoeff)
  readonly property color infoGlassHover: rootId.isDark ? rootId.infoGlassHoverDark : rootId.infoGlassHoverLight

  readonly property color backgroundDark: rootId.seedDark
  readonly property color backgroundLight: rootId.seedLight
  readonly property color background: rootId.isDark ? rootId.backgroundDark : rootId.backgroundLight
  readonly property color backgroundHoverDark: rootId.lighterOf(rootId.backgroundDark, rootId.hoveredColorCoeff)
  readonly property color backgroundHoverLight: rootId.darkerOf(rootId.backgroundLight, rootId.hoveredColorCoeff)
  readonly property color backgroundHover: rootId.isDark ? rootId.backgroundHoverDark : rootId.backgroundHoverLight
  readonly property color backgroundGlassDark: rootId.alphaOf(rootId.backgroundDark, rootId.glassCoeff)
  readonly property color backgroundGlassLight: rootId.alphaOf(rootId.backgroundLight, rootId.glassCoeff)
  readonly property color backgroundGlass: rootId.isDark ? rootId.backgroundGlassDark : rootId.backgroundGlassLight
  readonly property color backgroundGlassHoverDark: rootId.alphaOf(rootId.backgroundHoverDark, rootId.glassCoeff)
  readonly property color backgroundGlassHoverLight: rootId.alphaOf(rootId.backgroundHoverLight, rootId.glassCoeff)
  readonly property color backgroundGlassHover: rootId.isDark ? rootId.backgroundGlassHoverDark : rootId.backgroundGlassHoverLight

  readonly property color backgroundHeaderDark: rootId.lighterOf(rootId.accentDark, rootId.backgroundHeaderLightnessCoeff)
  readonly property color backgroundHeaderLight: rootId.darkerOf(rootId.accentLight, rootId.backgroundHeaderLightnessCoeff)
  readonly property color backgroundHeader: rootId.isDark ? rootId.backgroundHeaderDark : rootId.backgroundHeaderLight
  readonly property color backgroundHeaderHoverDark: rootId.lighterOf(rootId.backgroundHeaderDark, rootId.hoveredColorCoeff)
  readonly property color backgroundHeaderHoverLight: rootId.darkerOf(rootId.backgroundHeaderLight, rootId.hoveredColorCoeff)
  readonly property color backgroundHeaderHover: rootId.isDark ? rootId.backgroundHeaderHoverDark : rootId.backgroundHeaderHoverLight
  readonly property color backgroundGlassHeaderDark: rootId.alphaOf(rootId.backgroundHeaderDark, rootId.glassCoeff)
  readonly property color backgroundGlassHeaderLight: rootId.alphaOf(rootId.backgroundHeaderLight, rootId.glassCoeff)
  readonly property color backgroundGlassHeader: rootId.isDark ? rootId.backgroundGlassHeaderDark : rootId.backgroundGlassHeaderLight
  readonly property color backgroundGlassHeaderHoverDark: rootId.alphaOf(rootId.backgroundHeaderHoverDark, rootId.glassCoeff)
  readonly property color backgroundGlassHeaderHoverLight: rootId.alphaOf(rootId.backgroundHeaderHoverLight, rootId.glassCoeff)
  readonly property color backgroundGlassHeaderHover: rootId.isDark ? rootId.backgroundGlassHeaderHoverDark : rootId.backgroundGlassHeaderHoverLight

  readonly property color backgroundFooterDark: rootId.lighterOf(rootId.accentDark, rootId.backgroundFooterLightnessCoeff)
  readonly property color backgroundFooterLight: rootId.darkerOf(rootId.accentLight, rootId.backgroundFooterLightnessCoeff)
  readonly property color backgroundFooter: rootId.isDark ? rootId.backgroundFooterDark : rootId.backgroundFooterLight
  readonly property color backgroundFooterHoverDark: rootId.lighterOf(rootId.backgroundFooterDark, rootId.hoveredColorCoeff)
  readonly property color backgroundFooterHoverLight: rootId.darkerOf(rootId.backgroundFooterLight, rootId.hoveredColorCoeff)
  readonly property color backgroundFooterHover: rootId.isDark ? rootId.backgroundFooterHoverDark : rootId.backgroundFooterHoverLight
  readonly property color backgroundGlassFooterDark: rootId.alphaOf(rootId.backgroundFooterDark, rootId.glassCoeff)
  readonly property color backgroundGlassFooterLight: rootId.alphaOf(rootId.backgroundFooterLight, rootId.glassCoeff)
  readonly property color backgroundGlassFooter: rootId.isDark ? rootId.backgroundGlassFooterDark : rootId.backgroundGlassFooterLight
  readonly property color backgroundGlassFooterHoverDark: rootId.alphaOf(rootId.backgroundFooterHoverDark, rootId.glassCoeff)
  readonly property color backgroundGlassFooterHoverLight: rootId.alphaOf(rootId.backgroundFooterHoverLight, rootId.glassCoeff)
  readonly property color backgroundGlassFooterHover: rootId.isDark ? rootId.backgroundGlassFooterHoverDark : rootId.backgroundGlassFooterHoverLight

  readonly property color backgroundCardDark: rootId.lighterOf(rootId.backgroundDark, rootId.backgroundCardLightnessCoeff)
  readonly property color backgroundCardLight: rootId.darkerOf(rootId.backgroundLight, rootId.backgroundCardLightnessCoeff)
  readonly property color backgroundCard: rootId.isDark ? rootId.backgroundCardDark : rootId.backgroundCardLight
  readonly property color backgroundCardHoverDark: rootId.lighterOf(rootId.backgroundCardDark, rootId.hoveredColorCoeff)
  readonly property color backgroundCardHoverLight: rootId.darkerOf(rootId.backgroundCardLight, rootId.hoveredColorCoeff)
  readonly property color backgroundCardHover: rootId.isDark ? rootId.backgroundCardHoverDark : rootId.backgroundCardHoverLight
  readonly property color backgroundGlassCardDark: rootId.alphaOf(rootId.backgroundCardDark, rootId.glassCoeff)
  readonly property color backgroundGlassCardLight: rootId.alphaOf(rootId.backgroundCardLight, rootId.glassCoeff)
  readonly property color backgroundGlassCard: rootId.isDark ? rootId.backgroundGlassCardDark : rootId.backgroundGlassCardLight
  readonly property color backgroundGlassCardHoverDark: rootId.alphaOf(rootId.backgroundCardHoverDark, rootId.glassCoeff)
  readonly property color backgroundGlassCardHoverLight: rootId.alphaOf(rootId.backgroundCardHoverLight, rootId.glassCoeff)
  readonly property color backgroundGlassCardHover: rootId.isDark ? rootId.backgroundGlassCardHoverDark : rootId.backgroundGlassCardHoverLight

  readonly property color borderDark: rootId.lighterOf(rootId.backgroundDark, rootId.borderLightnessCoeff)
  readonly property color borderLight: rootId.darkerOf(rootId.backgroundLight, rootId.borderLightnessCoeff)
  readonly property color border: rootId.isDark ? rootId.borderDark : rootId.borderLight

  readonly property color textPrimaryDark: rootId.lighterOf(rootId.backgroundDark, rootId.textPrimaryLightnessCoeff)
  readonly property color textPrimaryLight: rootId.darkerOf(rootId.backgroundLight, rootId.textPrimaryLightnessCoeff)
  readonly property color textPrimary: rootId.isDark ? rootId.textPrimaryDark : rootId.textPrimaryLight

  readonly property color textSecondaryDark: rootId.lighterOf(rootId.textPrimaryDark, rootId.textSecondaryLightnessCoeff)
  readonly property color textSecondaryLight: rootId.darkerOf(rootId.textPrimaryLight, rootId.textSecondaryLightnessCoeff)
  readonly property color textSecondary: rootId.isDark ? textSecondaryDark : textSecondaryLight

  readonly property color textTertiaryDark: rootId.lighterOf(rootId.textSecondaryDark, rootId.textTertiaryDarkLightnessCoeff)
  readonly property color textTertiaryLight: rootId.darkerOf(rootId.textSecondaryLight, rootId.textTertiaryDarkLightnessCoeff)
  readonly property color textTertiary: rootId.isDark ? rootId.textTertiaryDark : rootId.textTertiaryLight

  readonly property color glassBorder: rootId.alphaOf(rootId.border, rootId.glassCoeff)

  readonly property color accentGlassGradientStart: rootId.isDark ? rootId.accentGlassHoverDark : rootId.accentGlassLight
  readonly property color accentGlassGradientEnd: rootId.isDark ? rootId.accentGlassDark : rootId.accentGlassHoverLight

  readonly property color backgroundGlassCardGradientStart: rootId.isDark ? rootId.alphaOf(rootId.accentGlassHoverDark, rootId.backgroundGlassCardGlassCoeff) : rootId.alphaOf(rootId.accentGlassLight, rootId.backgroundGlassCardGlassCoeff)
  readonly property color backgroundGlassCardGradientEnd: rootId.isDark ? rootId.alphaOf(rootId.accentGlassDark, rootId.backgroundGlassCardGlassCoeff) : rootId.alphaOf(rootId.accentGlassHoverLight, rootId.backgroundGlassCardGlassCoeff)

  readonly property color backgroundGlassCardHoverGradientStart: rootId.isDark ? rootId.alphaOf(rootId.accentGlassHoverDark, rootId.backgroundGlassCardHoverGlassCoeff) : rootId.alphaOf(rootId.accentGlassLight, rootId.backgroundGlassCardHoverGlassCoeff)
  readonly property color backgroundGlassCardHoverGradientEnd: rootId.isDark ? rootId.alphaOf(rootId.accentGlassDark, rootId.backgroundGlassCardHoverGlassCoeff) : rootId.alphaOf(rootId.accentGlassHoverLight, rootId.backgroundGlassCardHoverGlassCoeff)

  readonly property color backgroundGlassCardPressedGradientStart: rootId.isDark ? rootId.alphaOf(rootId.accentGlassDark, rootId.backgroundGlassCardPressedGlassCoeff) : rootId.alphaOf(rootId.accentGlassHoverLight, rootId.backgroundGlassCardPressedGlassCoeff)
  readonly property color backgroundGlassCardPressedGradientEnd: rootId.isDark ? rootId.alphaOf(rootId.accentGlassHoverDark, rootId.backgroundGlassCardPressedGlassCoeff) : rootId.alphaOf(rootId.accentGlassLight, rootId.backgroundGlassCardPressedGlassCoeff)

  readonly property color backgroundGlassHeaderGradientStart: rootId.isDark ? rootId.backgroundGlassHeaderHoverDark : rootId.backgroundGlassHeaderLight
  readonly property color backgroundGlassHeaderGradientEnd: rootId.isDark ? rootId.backgroundGlassHeaderDark : rootId.backgroundGlassHeaderHoverLight
  readonly property color backgroundGlassFooterGradientStart: rootId.isDark ? rootId.backgroundGlassFooterHoverDark : rootId.backgroundGlassFooterLight
  readonly property color backgroundGlassFooterGradientEnd: rootId.isDark ? rootId.backgroundGlassFooterDark : rootId.backgroundGlassFooterHoverLight
  readonly property color backgroundGlassGradientStart: rootId.isDark ? rootId.backgroundGlassHoverDark : rootId.backgroundGlassLight
  readonly property color backgroundGlassGradientEnd: rootId.isDark ? rootId.backgroundGlassDark : rootId.backgroundGlassHoverLight
  readonly property color buttonPressedGlassAccentGradientStart: rootId.isDark ? rootId.accentGlassDark : rootId.accentGlassHoverLight
  readonly property color buttonPressedGlassAccentGradientEnd: rootId.isDark ? rootId.accentGlassHoverDark : rootId.accentGlassLight
  readonly property color buttonAccentGlassGradientStart: rootId.isDark ? rootId.accentGlassHoverDark : rootId.backgroundGlass
  readonly property color buttonAccentGlassGradientEnd: rootId.isDark ? rootId.backgroundGlass : rootId.accentGlassHoverLight

  readonly property real languageLightnessDark: 0.50
  readonly property real languageLightnessLight: 0.25
  readonly property real languageSaturation: 0.50

  function languageHue(language: string): real {
    switch (language) {
    case "JavaScript":
      return 52;
    case "Python":
      return 208;
    case "Java":
      return 28;
    case "C++":
      return 200;
    case "C":
      return 212;
    case "C#":
      return 125;
    case "TypeScript":
      return 211;
    case "Go":
      return 189;
    case "Rust":
      return 18;
    case "Swift":
      return 14;
    case "Kotlin":
      return 262;
    case "Ruby":
      return 3;
    case "PHP":
      return 235;
    case "HTML":
      return 12;
    case "CSS":
      return 215;
    case "Shell":
      return 100;
    case "Dart":
      return 197;
    case "Vue":
      return 153;
    case "React":
      return 190;
    default:
      return -1;
    }
  }
  function getLanguageColor(language: string): color {
    // Hue (0-360°): the color itself on the color wheel (0 = red, 120 = green, 240 = blue)
    const hue = rootId.languageHue(language) / 360;

    if (hue < 0) {
      return rootId.textSecondary;
    }

    // Saturation (0-1): how vivid the color is (0 = gray, 1 = fully colorful)
    const saturation = rootId.languageSaturation;
    // Lightness (0-1): how bright the color is (0 = black, 0.5 = the "pure" color, 1 = white)
    const lightness = rootId.isDark ? rootId.languageLightnessDark : rootId.languageLightnessLight;
    // alpha (opacity, 1.0 = fully opaque)
    const alpha = 1;

    return Qt.hsla(hue, saturation, lightness, alpha);
  }
  function toggleTheme(): void {
    rootId.isDark = !rootId.isDark;
  }
  function alphaOf(c: color, a: real): color {
    return Qt.rgba(c.r, c.g, c.b, a);
  }
  function lighterOf(c: color, f: real): color {
    return Qt.lighter(c, f);
  }
  function darkerOf(c: color, f: real): color {
    return Qt.darker(c, f);
  }
}
