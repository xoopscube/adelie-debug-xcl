// xHelp functions for AdelieDebug
function animateSlider(hash) {
    if (!$("#xhelp-main div.xhelp-open").length) {
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
    $(hash + "_view").slideToggle().addClass("xhelp-open");
}
function openAndClose(hash) {
    if ($(hash + "_view").hasClass("xhelp-open")) {
        $($(hash + "_view")).slideToggle().removeClass();
    } else {
        $("#xhelp-main div.xhelp-open").slideToggle().removeClass();
        $(hash + "_view").slideToggle().addClass("xhelp-open");
    }
}
function renameElement($element,newElement){
    $element.wrap("<"+newElement+">");
    $newElement = $element.parent();
    //Copying Attributes
    $.each($element.prop('attributes'), function() {
        $newElement.attr(this.name,this.value);
    });
    $element.contents().unwrap();
    return $newElement;
}

// xHelp View Control
$(function() {
    $("#xhelp-menu a, #close-view").click(function(e) {
        e.preventDefault();
        animateSlider(this.hash);
    });
    // view control
    $("#minimize").hide();
    // maximize
    var p = $('#adelie_view').position();
    $("#maximize").click(function (e) {
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
    // minimize
    $("#minimize").click(function (e) {
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
});

// xHelp Panel Scroll
$(function () {
    // Open Details and Scroll to Error Id
    $('.errorId').click(function(e){
        var id= $(this).prop("hash");
        // Open details
        renameElement($('details.timeline'),'details open');
        $('#adelieReport').animate({
            scrollTop: $(id).offset().top - $(id).offsetParent().offset().top -20
        }, 500);
        e.preventDefault();
    });
    // Click Error and Scroll to Top
    $('.ERROR').click(function(e){
        $('#adelieReport').animate({
            scrollTop: $('#adelieReport').offset().top - $('#adelieReport').offsetParent().offset().top -20
        }, 500);
        e.preventDefault();
    });

});
