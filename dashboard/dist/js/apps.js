/* ==========================================================================
 * Template: Blankon Fullpack Admin Theme
 * ---------------------------------------------------------------------------
 * Author: Djava UI
 * Website: http://djavaui.com
 * Email: maildjavaui@gmail.com
 * ========================================================================== */

var BlankonApp = function(){

    return {

        // =========================================================================
        // CONSTRUCTOR APP
        // =========================================================================
        init: function () {
            BlankonApp.handleBaseURL();
            
        },

        // =========================================================================
        // SET UP BASE URL
        // =========================================================================
        handleBaseURL: function () {
            var getUrl = window.location,
                baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
            return baseUrl;
        } 
    };
}();

// Call main app init
BlankonApp.init();
