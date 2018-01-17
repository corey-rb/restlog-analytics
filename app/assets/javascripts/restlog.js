$(document).ready(function() {

    // APP NEW SEARCH

    $('body').on('click', '#view-app-detail .filter-options .new', function (){
        $('#view-app-detail .mc-setup').toggleClass('active');
    });

    // LEFT NAVIGATION DROPDOWNS

    $('.nav li a.drop').click(function() {
        if ($(this).parent('li').hasClass('active')) {
            $('.nav li.active').removeClass('active');
        }
        else if ($('.nav li').hasClass('active')) {
            $('.nav li.active').removeClass('active');
            $(this).parent('li').addClass('active');
        }
        else {
            $(this).parent('li').addClass('active');
        }
    })

    // DASHBOARD CHART OPTIONS

    $('.chart-container .shrink').click(function() {
      $(this).parents('.chart-container').toggleClass('active');
    })
})

$(window).load(function() {
  dragula([document.querySelector('#chart-master-container')], {
    moves: function (el, container, handle) {
      return handle.className === 'move';
    }
  });
})
