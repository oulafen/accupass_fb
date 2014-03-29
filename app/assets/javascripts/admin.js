function show_change_success(){
    $(document).ready(function(){
        $('#change_success').show(400)
    })
    $('#close').click(function(){
        $('#change_success').hide(400)
    })
}