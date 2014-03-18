function SignUp(name,phone){
    this.name=name;
    this.phone=phone;
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