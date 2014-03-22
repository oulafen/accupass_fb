function SignUp(){
//    this.name=name;
//    this.phone=phone;
}

SignUp.get_sign_up_status=function(){
    return localStorage.getItem('sign_up_status');
}

SignUp.save_sign_up_status=function(status){
    localStorage.setItem('sign_up_status',status);
}

SignUp.update_sign_up_activities=function(present_activity){
    var activities = JSON.parse(localStorage.getItem('activities'));
    _.each(activities, function (activity) {
        if (activity.active_name == present_activity.active_name) {
            activity.active_status = present_activity.active_status;
        }
    });
    localStorage.setItem('activities',JSON.stringify(activities));
}

SignUp.get_present_sign_ups = function(){
    var sign_ups = JSON.parse(localStorage.getItem('sign_ups'))
    return _.filter(sign_ups,function(sign_up){
        return sign_up.activity_name == localStorage.getItem('present_activity_name')
    }) ||[];
}