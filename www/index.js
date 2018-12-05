(function() {

    $(document).on('ready', function(event) {
        console.log($('.tab-content').first().html());
        formatTabs();
        Shiny.addCustomMessageHandler('page', function(message) {
            currentPage = message;
        });
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

var pages = ['home', 'creators', 'intro', 'q1', 'q2', 'q3', 'donate'];
var currentPage = 'home';

function nextPage() {
    let index = pages.indexOf(currentPage);
    let length = pages.length - 1;
    let nextElement = pages[index];
    if (index != length) {
        nextElement = pages[index + 1];
    }

    Shiny.setInputValue('controller', nextElement);
}
