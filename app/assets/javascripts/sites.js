$( document ).ready(function() {

    $('.b_input').click( function(){
        $.post('sites/increment',
            function(data, status){
                var output_string = data[0].increment_var
                $('#result').text(output_string)
            }
        )
    })

    $('.t_input').keyup(function () {
        var content = $('.t_input').val()
        if (content.length > 0) {
            $.post('sites/get_by_chars',
                {
                    chars: content
                },
                function (data, status) {
                    if (data.length === 1) {
                        var output_string = data[0].site_name
                        if (data[0].telephone_num === null){
                            var newTextBoxDiv = $('#TextBoxDiv1').show()
                            $('#result').text(output_string)
                            $('#result').after(newTextBoxDiv)

                            $('#result').html(output_string)
                        }else{
                            output_string = "<p>"+data[0].site_name+" " + data[0].telephone_num + "</p>"
                            $('#result').html(output_string)
                            $('#TextBoxDiv1').hide()
                        }

                    } else if (data.length > 1) {
                        var output_string
                        output_string = '<ul>'
                        $.each(data, function (index, value) {
                            output_string += '<li>' + value.site_name + '</li>'
                        })
                        output_string += '</ul>'
                        $('#result').html(output_string)
                        $('#TextBoxDiv1').hide()
                    } else {
                        $('#result').html('<span></span>')
                        $('#TextBoxDiv1').hide()
                    }
                })
        } else {
            $('#result').html('<span></span>')
            $('#TextBoxDiv1').hide()
        }
    })

    $( '#dialog' ).dialog({
        autoOpen: false,
        modal: true,
        buttons:{
            OK: function() {
                callMailer()
                $(this).dialog('close')
            },
            Change: function() { $(this).dialog('close') }
        },
        title: 'Confirm phone and message...',
        position:{
            my: 'center',
            at: 'center'
        }
    });
    $( '#sendbtn1').click( function(){
        var phone_value = $('#textbox1').val()
        var message_val = $('#textbox2').val()
        $('#phone-val').text( phone_value )
        $('#msg-val').text( message_val )
        $('#dialog').dialog( 'open' )
    })
})

$(document).on( 'keyup', '.text_input_1', function () {
    var content = $('#textbox1').val()
    if (content.match(/\d{3}(.)?\d{3}(.)?\d{4}/)){
        $('#TextBoxDiv2').show()
    }else{
        $('#TextBoxDiv2').hide()
    }
})

$(document).on( 'keyup', '#textbox2', function () {
    var content = $('#textbox2').val()
    var content_length_left = 100 - content.length
    if (content_length_left > 0){
        $('#char-counter').text( content_length_left )
    }else if (content_length_left === 0){
        $('#char-counter').text( 0 )
    }else{
        $('#char-counter').text( 0 )
        $('#textbox2').val(content.substring(0,100))
    }
})

function callMailer(){
    var phVal = $('#textbox1').val()
    var msgVal = $('#textbox2').val()
    $.post('sites/send_request_message',
        {
            phone: phVal,
            message: msgVal
        },
        function(data, status){
            var output_string = data.increment
            $('#result').text(output_string)
        }
    )
}