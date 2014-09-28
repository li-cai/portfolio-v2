function resizeLayout() {
    $('#nav').css('top', $(window).height() - 165);

    if ($(window).width() < 940) {
        $('.wrapper').addClass('resized');
    }
    else {
        $('.wrapper').removeClass('resized');
    }   

    //if ($(window).width() < 597) {
        // $('#top-banner').addClass('topbanner-resized');
        // $('#top-nav').addClass('topnav-resized');
        // $('img.header').addClass('header-resized');

        //$('#banner').addClass('banner-resized');
        //$('#nav').addClass('nav-resized')
        //$('#nav').removeAttr('style');
        //$('#nav').css('margin-top', '10px');
    //}

    // else {
    //     $('#top-banner').removeClass('topbanner-resized');
    //     $('#top-nav').removeClass('topnav-resized');
    //     $('img.header').removeClass('header-resized');

    //     $('#banner').removeClass('banner-resized');
    //     $('#nav').removeClass('nav-resized');
    //     $('#nav').removeAttr('style');
    //     $('#nav').css('top', $(window).height() - 165);
    // }

    if ($(window).height() < $('#about').height() + 160) {
        $('#banner').addClass("about-resized");
    }
    else {
        $('#banner').removeClass("about-resized");
    }

    if ($(window).width() < 350) {
        $('img.header').removeClass('header-resized');
    }
    else {
        $('img.header').addClass('header-resized');
    }
}

function loadMainPage() {
    $('.content').removeAttr('style');

    if ($(".about-resized")[0]) {
        $('#banner').removeClass('about-resized');
    }

    if ($(window).width() < 580) {
        $('#nav').removeClass('nav-resized');
        $('#banner').removeClass('banner-resized');

        $('#about').hide();
        $('#nav').attr('id', 'top-nav');
        $('#banner').attr('id', 'top-banner');

        resizeLayout();
    }
    else {
        var animateTime = 1100;
        $('#nav').animate({top: '13.5px'},
                          {duration: animateTime, queue: false,
                           complete: function() {
                               $('#nav').attr({'id': 'top-nav', 'style': ''});
                          }}
                         ); // end nav animate

        $('#banner').animate({height: '150px'}, 
                             {duration: animateTime, queue: false, 
                              complete: function () {
                                  $('#about').hide();
                                  $('#banner').attr({'id': 'top-banner', 'style': ''});
                             }}
                            ); // end banner animate                    
    }         
}

function loadSplashPage() {
    if ($('#top-banner').length > 0) {
        $('#projects-link, #resume-link').removeClass('active');
        $('#about-link').addClass('active');

        if ($(window).width() < 580) {
            $('#top-nav').removeClass('topnav-resized');
            $('#top-banner').removeClass('topbanner-resized');

            $('.content').css('display', 'none');
            $('#projects, #resume').addClass('hidden');
            $('#about').show();

            $('#top-nav').attr('id', 'nav');
            $('#top-banner').attr('id', 'banner');

            resizeLayout();
        }
        else {
            var animateTime = 1100;
            $('#top-nav').animate({top: $(window).height() - 163.5},
                                  {duration: animateTime, queue: false, 
                                   complete: function() {
                                       $('#top-nav').attr('id', 'nav');
                                       $('#nav').removeAttr('style');
                                       $('#nav').css('top', $(window).height() - 165);
                                       $('#projects, #resume').addClass('hidden');
                                       $('.content').css('display', 'none');
                                  }}
                                 ); // end top-nav animate

            $('#about').show();

            $('#top-banner').animate({height: $(window).height() - 30},
                                     {duration: animateTime, queue: false,
                                     complete: function() {
                                         $('#top-banner').attr('id', 'banner');
                                         $('#banner').removeAttr('style');
                                     }}
                                    ); // end top-banner animate      
            resizeLayout();          
        }
    }
}

function showTiles(slideTime) {
    $('#tiles').stop().slideDown({duration: slideTime, queue: false});
    $('#development, #design').stop().slideUp({duration: slideTime, queue: false});   
}

function hideTiles(slideTime, selector) {
    $('#tiles').stop().slideUp({duration: slideTime, queue: false});
    selector.stop().slideDown({duration: slideTime, queue: false});    
}

function resetTiles() {
    if ($('#tiles').css('display') == 'none') {
        $('#tiles').removeAttr('style');
        $('#development, #design').css('display', 'none');
    }
}

$(function() {
    var slideTime = 1200;

    resizeLayout();

    $(window).resize(function() {
        resizeLayout();
    }); // end resize

    if ($('#banner').length > 0) {
        $(window).scroll(function() {
            resizeLayout();
        }); // end scroll
    }

    $('#nav').css('top', $(window).height() - 165);

    $('.content').css('display', 'none');
    $('#projects, #resume, #development, #design').addClass('hidden');

    $('#projects-link').click(function() {
        $('#projects-link').addClass('active');
        $('#resume-link, #about-link').removeClass('active');
        $('#projects').removeClass('hidden');
        $('#resume').addClass('hidden');
    }); // end click

    $('#resume-link').click(function() {
        $('#resume-link').addClass('active');
        $('#projects-link, #about-link').removeClass('active');
        $('#resume').removeClass('hidden');
        $('#projects').addClass('hidden');
    }); // end click

    $('#about-link').click(function() {
        loadSplashPage();
    }); // end click

    $('#projects-link').click(function() {
        if (!$('projects-link').hasClass('active')) {
            resetTiles();
        }
    });

    // navigation link effects
    $('div.nav-flag').each(function() {

        if ($(this).attr('id') != 'about-link' &&
            $('#banner').length > 0) {

            // click effect
            $(this).click(function() {
                loadMainPage();    
            }); // end click
        }
    }); // end each

    $('#dev-tile').click(function() {
        hideTiles(slideTime, $('#development'))
    }); // end click

    $('#design-tile').click(function() {
        hideTiles(slideTime, $('#design'))
    }); // end click

    $('.back-tile').each(function() {
        $(this).click(function() {
            showTiles(slideTime);       
        }); // end click
    }); // end each

}); // end ready
