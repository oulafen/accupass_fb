function reload_show_page( ){
//    setTimeout(" self.location.reload()",50);
    setTimeout(" syn_show()",50);
}



function syn_show(){
    var myusername = $("#show").val();
    $.ajax({
        type: "GET",
        url: "show#show",
        data: myusername,
        cache: false
//        success: function(data){
//            $("#resultarea").text(data);
//        }
    });

}
