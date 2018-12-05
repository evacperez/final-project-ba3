(function() {

    $(document).on('ready', function(event) {
        console.log($('.tab-content').first().html());
        formatTabs();
    });

    function formatTabs() {
        let nav = $('ul').first();
        for (let i = 0; i < nav.children().length; i++) {
            let tab = nav.children().eq(i);

            if (i != nav.children().length - 1) {
                let link = tab.children().first();
                let icon = $('<i class="fas fa-chevron-right"></i>');
                icon.css('float', 'right');

                link.append(icon);
            }
        }
        let percentage = (100 / nav.children().length) + "%";
        nav.children().css('width', percentage);
    }
})();

function setPage(value) {
    let time = Math.round(new Date());
    Shiny.setInputValue('controller', time);
}
