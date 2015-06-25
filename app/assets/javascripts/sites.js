$( document ).ready(function() {

    $('.t_input').keyup(function () {
        $('#TextBoxDiv2').remove()
        $('#textbox2').remove()
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
                            var newTextBoxDiv = $(document.createElement('div')).attr("id", 'TextBoxDiv1')
                            $('#result').text(output_string)
                            $('#result').after(newTextBoxDiv)

                            newTextBoxDiv.after().html('<label>Enter Phone #:</label>' +
                            '<input type="text" class="text_input_1" name="textbox1" id="textbox1" value="" >' +
                            '<label class="grey-label" id="char-counter"></label>')
                            $('#result').html(output_string)
                        }else{
                            output_string = "<p>"+data[0].site_name+" " + data[0].telephone_num + "</p>"
                            $('#result').html(output_string)
                            $('#TextBoxDiv1').remove()
                        }

                    } else if (data.length > 1) {
                        var output_string
                        output_string = '<ul>'
                        $.each(data, function (index, value) {
                            output_string += '<li>' + value.site_name + '</li>'
                        })
                        output_string += '</ul>'
                        $('#result').html(output_string)
                        $('#TextBoxDiv1').remove()
                    } else {
                        $('#result').html('<span></span>')
                        $('#TextBoxDiv1').remove()
                    }
                })
        } else {
            $('#result').html('<span></span>')
            $('#TextBoxDiv1').remove()
        }
    })
})

$(document).on( 'keyup', '.text_input_1', function () {
    var content = $('#textbox1').val()
    if (content.match(/\d{3}(.)?\d{3}(.)?\d{4}/)){
        var newTextBoxDiv = $(document.createElement('div')).attr("id", 'TextBoxDiv2')
        $('#TextBoxDiv1').after(newTextBoxDiv)
        new_input_box_string = '<label>Enter problem in 100 characters or less:</label>' +
                                '<input type="text" name="textbox2" id="textbox2" value="" size="100">'
        newTextBoxDiv.after().html(new_input_box_string)
    }else{
        $('#TextBoxDiv2').remove()
    }
})

$(document).on( 'keyup', '#textbox2', function () {
    var content = $('#textbox2').val()
    var content_size = content.length
    $('#char-counter').text( content_size )
})
