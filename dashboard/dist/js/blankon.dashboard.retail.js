var BlankonDashboardRetail = function () {

    // =========================================================================
    // SETTINGS APP
    // =========================================================================
    var globalImgPath = BlankonApp.handleBaseURL()+'/img';

    return {

        // =========================================================================
        // CONSTRUCTOR APP
        // =========================================================================
        init: function () { 
            BlankonDashboardRetail.topProductChart();
            BlankonDashboardRetail.topStoreChart();
        },

        
        
        

        // =========================================================================
        // TOP PRODUCT
        // =========================================================================
        topProductChart: function () {
            $('.top-product-chart').horizBarChart({
                selector: '.bar',
                speed: 3000
            });
        },

        // =========================================================================
        // TOP STORES
        // =========================================================================
        topStoreChart: function () { 
                $('.top-store-chart').horizBarChart({
                    selector: '.bar',
                    speed: 3000
                }); 
        }

    };

}();

// Call main app init
BlankonDashboardRetail.init();
