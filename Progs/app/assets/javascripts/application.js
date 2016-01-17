// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//  require turbolinks
//= require_tree .

$(function(){
    function isWinner (){
        var result = [
            ["x", "o", "o"],
            ["x", "x", "x"],
            ["o", "x", "o"]
        ];

        function rowTest(index) {
            var winner = '';
            var prevSymbol = '';
            result[index].some(function(el, idx){
                if(prevSymbol && prevSymbol != el){
                    return true;
                } else if(prevSymbol == el && idx == 2){
                    winner = el;
                }
                prevSymbol = el;
            });
        }
        function columnTest(index) {
            //проверка того, что кто-либо выиграл в указанном столбце
        }

        var testResult = rowTest(1);

        if(testResult == "x") {
            console.log("выиграл x");
        } else if(testResult == "o") {
            console.log("выиграл o");
        } else {
            console.log("никто не выиграл");
        }
    }
    //==========================================================
    var clickCount =0;
    var curSymbol;
    var touch = null;

    $(document).ready(function() {
        source = new EventSource('/steps');

        source.onmessage = function(event) {
            var step = JSON.parse(event.data);

            console.log(step);
            $($('.col-xs-4')[step.position]).html(step.symbol);

            touch = step.symbol != curSymbol;
            if (step.winner){
                alert("Winner is " + step.winner.user_name);
                window.location.href = "/finish";
            }
        };

        $.get('/number_of_user/', {room_id: $('input[name=room_id]').val()}).then(function(result) {
            console.log(result);
            curSymbol = result.symbol;
            touch = result.number == '1';
        });

        var lastSymbol = "o";
        $('.xo .col-xs-4').click(function() {
            if($(this).html() == "x" || $(this).html() == "o" || touch == false)
                return;
            clickCount++;

            console.log($('.col-xs-4').index(this));
            $(this).html(curSymbol);
            $.post('/steps/', {room_id: $('input[name=room_id]').val(),position: $('.col-xs-4').index(this), symbol: curSymbol}).then(function(result){
                console.log(result);

                if(result && result.winner){
                    alert("Winner is " + result.winner.user_name);
                    window.location.href = "/finish";
                }
            });
        })
    })

});
