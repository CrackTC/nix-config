profileName: {
  programs.firefox.profiles.${profileName}.settings = {
    # natural smooth scrolling v4 "sharp" - AveYo, 2020-2022
    "general.smoothScroll.msdPhysics.enabled" = true;
    "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
    "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 200;
    "general.smoothScroll.msdPhysics.regularSpringConstant" = 250;
    "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
    "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2.0;
    "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
    "general.smoothScroll.currentVelocityWeighting" = 1.0;
    "general.smoothScroll.stopDecelerationWeighting" = 1.0;

    "mousewheel.system_scroll.override.enabled" = true;
    "mousewheel.system_scroll_override.horizontal.factor" = 200;
    "mousewheel.system_scroll_override.vertical.factor" = 200;
    "mousewheel.system_scroll_override_on_root_content.enabled" = true;

    "mousewheel.default.delta_multiplier_x" = 100;
    "mousewheel.default.delta_multiplier_y" = 100;
    "mousewheel.default.delta_multiplier_z" = 100;

    "apz.allow_zooming" = true;
    "apz.force_disable_desktop_zooming_scrollbars" = false;
    "apz.paint_skipping.enabled" = true;
    "apz.windows.use_direct_manipulation" = true;
    "dom.event.wheel-deltaMode-lines.always-disabled" = false;

    "general.smoothScroll.durationToIntervalRatio" = 200;
    "general.smoothScroll.lines.durationMaxMS" = 150;
    "general.smoothScroll.lines.durationMinMS" = 150;
    "general.smoothScroll.other.durationMaxMS" = 150;
    "general.smoothScroll.other.durationMinMS" = 150;
    "general.smoothScroll.pages.durationMaxMS" = 150;
    "general.smoothScroll.pages.durationMinMS" = 150;
    "general.smoothScroll.pixels.durationMaxMS" = 150;
    "general.smoothScroll.pixels.durationMinMS" = 150;
    "general.smoothScroll.scrollbars.durationMaxMS" = 150;
    "general.smoothScroll.scrollbars.durationMinMS" = 150;
    "general.smoothScroll.mouseWheel.durationMaxMS" = 200;
    "general.smoothScroll.mouseWheel.durationMinMS" = 50;

    "layers.async-pan-zoom.enabled" = true;
    "layout.css.scroll-behavior.spring-constant" = 250;
    "mousewheel.transaction.timeout" = 1500;
    "mousewheel.acceleration.factor" = 10;
    "mousewheel.acceleration.start" = -1;
    "mousewheel.min_line_scroll_amount" = 5;
    "toolkit.scrollbox.horizontalScrollDistance" = 5;
    "toolkit.scrollbox.verticalScrollDistance" = 3;
  };
}
