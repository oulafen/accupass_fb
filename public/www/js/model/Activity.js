function Activity(active_name) {
    this.user = localStorage.user;
    this.active_name = active_name;
    this.active_status = 'null';
}

Activity.get_activities = function () {
    return JSON.parse(localStorage.getItem('activities')) || [];
}

Activity.save_activities = function (activities) {
    localStorage.setItem('activities', JSON.stringify(activities));
}

Activity.get_present_activity_name = function () {
    return localStorage.getItem('present_activity_name');
}

Activity.save_present_activity_name = function (present_activity_name) {
    localStorage.setItem('present_activity_name', present_activity_name)
}

Activity.get_click_activity_name = function () {
    return localStorage.getItem('click_activity_name');
}

Activity.save_click_activity_name = function (click_activity_name) {
    localStorage.setItem('click_activity_name', click_activity_name);
}

Activity.judge_activity_name_is_repeat = function (name) {
    var activities = Activity.get_activities();
    var repeat_result = false;
    _.each(activities, function (activity) {
        if (activity.active_name == name) {
            repeat_result = true;
        }
    });
    return repeat_result;
}

Activity.get_click_activity = function () {
    var activities = JSON.parse(localStorage.getItem('activities'));
    var name=localStorage.getItem('click_activity_name');
    return _.find(activities, function (activity) {
        return activity.active_name == name;
    });
}

Activity.get_present_activity = function () {
    var activities = JSON.parse(localStorage.getItem('activities'));
    var name = localStorage.getItem('present_activity_name');
    return _.find(activities, function (activity) {
        return activity.active_name == name;
    }) || new Activity('');
}

Activity.get_sign_ups = function(){
    return JSON.parse(localStorage.getItem('sign_ups'))||[];

}

