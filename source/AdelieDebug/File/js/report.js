// jQuery functions for AdelieDebug
$(function() {

    $("#xhelper-menu a").click(function(e) {
        e.preventDefault();
        animateSlider(this.hash);
    });

    function animateSlider(hash) {
        if (!$("#xhelper-main div.xhelper-open").length) {
            if (hash == "#adelie") {
                openPopup(hash);
            }
            if (hash == "#kint") {
                openPopup(hash);
            }
        } else {
            if (hash == "#adelie") {
                openAndClose(hash)
            }
            if (hash == "#kint") {
                openAndClose(hash)
            }
        }
    }
    function openPopup(hash) {
        $(hash + "_view").slideToggle().addClass("xhelper-open");
    }
    function openAndClose(hash) {
        if ($(hash + "_view").hasClass("xhelper-open")) {
            $($(hash + "_view")).slideToggle().removeClass();
        } else {
            $("#xhelper-main div.xhelper-open").slideToggle().removeClass();
            $(hash + "_view").slideToggle().addClass("xhelper-open");
        }
    }

    // view control
    $("#minimize").hide();
    var p = $('#adelie_view').position();
    $("#maximize").bind("click", function (e) {
        e.preventDefault();
        $("#adelie_view").animate({
            width: $(window).width(),
            height:$(window).height(),
            top: "-1"
        }, 500);
        $('#adelie_view').css({
            "top": "0"
        });
        $("#maximize").hide(100);
        $("#minimize").show(100);
    });
    $("#minimize").bind("click", function (e) {
        e.preventDefault();
        $('#adelie_view').css({
            "position": "fixed",
            "top": "auto",
            "bottom": "44px"
        });
        $("#adelie_view").animate({
            width: "50vw",
            height: "400px",
            left: p.left+'px'
        }, 500);
        $("#maximize").show(100);
        $("#minimize").hide(100);
    });

    // About

});

// About

$( function() {
    // Declare the initial dialog outside any event
    var $dialog = $('#dialogAbout');

    $dialog.dialog({
        autoOpen: false,
        closeText: "hide",
        dialogClass: "dialogCredits",
        closeOnEscape: true,
        // buttons: {
        //     "Close": function () {
        //         $(this).dialog("close")
        //     }
        // },
        position: {
            my: "left top",
            at: "left center",
            of: "#about" },
        resizable: false,
        show: {
            effect: "blind",
            duration: 350
        },
        hide: {
            effect: "blind",
            duration: 350
        },
        classes: {
            "ui-dialog":"dialogCredits",
            "ui-dialog-titlebar":"dialogAboutTitle",
            "ui-dialog-titlebar-close":"dialogAboutClose",
        },

    }).removeClass("ui-button-icon-only");

    // Append the HTML and open the dialog
    $( "#about" ).on( "click", function() {
        //$dialog.html("<br><a id='modalClose'>CloseMe</a>");
        $dialog.dialog( "open" );
    });

    // Bind the click event that closes the modal
    $("body").on('click', '.dialogAboutClose', function (e) {
        // prevent the default action, e.g., following a link
        e.preventDefault();
        // Need to close the Modal
        $dialog.dialog('close');
    });


} );


