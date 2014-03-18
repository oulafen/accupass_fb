function SMSSignUp(name, phone) {
    this.name = name;
    this.phone = phone;
}
SMSSignUp.get_message_content = function (message_json) {
    return message_json.messages[0].message.substring(2).replace(/^\s+$/g, '');
}
SMSSignUp.reconstruct_bm_message = function (message_json) {
    var message = new SMSSignUp(SMSSignUp.get_message_content(message_json), message_json.messages[0].phone);
    return message;
}
SMSSignUp.judge_bm_repeat = function (phone) {
    return _.find(Activity.get_present_activity().apply_people, function (people) {
        return people.phone == phone
    });
}
SMSSignUp.save_bm_message_to_activities = function (message) {
    var activities = Activity.get_activities();
    var present_activity_name = localStorage.getItem('present_activity_name');
    _.map(activities, function (activity) {
        if (activity.active_name == present_activity_name) {
            activity.apply_people.unshift(message);
        }
    })
    Activity.save_activities(activities);
}
SMSSignUp.refresh_apply = function (flag) {
    var page = document.getElementById(flag);
    if (page) {
        var scope = angular.element(page).scope();
        scope.$apply(function () {
            scope.get_peoples();
        })
    }
}
SMSSignUp.check_message = function (message_json) {
    var message_flag = message_json.messages[0].message.substring(0, 2).toUpperCase();
    if ((message_flag == 'JJ' || message_flag == 'BM') && message_json.messages[0].message.length > 2) {
        return true;
    }
}
SMSSignUp.check_bm_activity = function (message) {
    SMSSignUp.sign_up_status_map[SignUp.get_sign_up_status()](message);
}
SMSSignUp.sign_up_status_map = {
    'unbegin': function (message) {
        console.log(message.name, '，你好，报名活动还未开始。');
    },
    'beginning': function (message) {
        if (!SMSSignUp.judge_bm_repeat(message.phone)) {
            SMSSignUp.save_bm_message_to_activities(message);
            SMSSignUp.refresh_apply('sign_up');
            console.log(message.name, '，恭喜你，报名成功！');
        } else {
            console.log(message.name, '，你好，请勿重复报名。');
        }
    },
    'end': function (message) {
        console.log(message.name, '，你好，报名活动已结束。');
    }
}