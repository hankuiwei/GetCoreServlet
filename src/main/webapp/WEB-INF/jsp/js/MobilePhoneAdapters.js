(function (doc, win) {
    let docEl = doc.documentElement,
        resizeEvt = "orientationchange" in window ? "orientationchange" : "resize",
        recalc = function () {
            var clientWidth = docEl.clientWidth;
            if (!clientWidth) return;
            docEl.style.fontSize = 100 * (clientWidth / 720) + "px";
        };
    recalc();
    if (!doc.addEventListener) return;
    win.addEventListener(resizeEvt, recalc, false);
})(document, window)