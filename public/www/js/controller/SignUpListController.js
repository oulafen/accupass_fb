function SignUpListController($scope, $navigate) {

    $scope.status_map = {
        'null': function () {
            return 'unbegin'
        },
        'yellow': function () {
            return 'beginning'
        },
        'lightgray': function () {
            return 'end'
        }
    }
    $scope.button_status_init=function() {
        $scope.click_activity = Activity.get_click_activity();
        $scope.present_activity = Activity.get_present_activity();
        $scope.sign_up_status = SignUp.get_sign_up_status();
        if ($scope.present_activity.active_status == 'yellow'
            && $scope.click_activity.active_name != $scope.present_activity.active_name) {
            $scope.status = 'begin_disabled';
            return;
        }
        if ($scope.present_activity.active_status == 'yellow' && $scope.sign_up_status == 'end') {
            $scope.status = 'end';
            return;
        }
        $scope.click_activity.active_name == $scope.present_activity.active_name ?
            $scope.status = $scope.status_map[$scope.present_activity.active_status]()
            : $scope.status = $scope.status_map[$scope.click_activity.active_status]();
    }
    $scope.sign_up_unbegin = function () {
        $scope.status = 'beginning';
        $scope.present_activity = $scope.click_activity;
        $scope.present_activity.active_status = 'yellow';
        Activity.save_present_activity_name($scope.present_activity.active_name)
        SignUp.update_sign_up_activities($scope.present_activity)
        SignUp.save_sign_up_status('beginning');
    }
    $scope.sign_up_beginning = function () {
        if (confirm('确认要结束本次报名吗？')) {
                SignUp.save_sign_up_status('end');
                $scope.status = 'end';
                $navigate.go('/bid/list');
        }
    }
    $scope.get_peoples=function(){
        $scope.present_activity = Activity.get_present_activity();
        $scope.peoples = $scope.present_activity.apply_people;
    }
    $scope.go_list = function () {
        $navigate.go('/activity/list', 'slide', 'right');
    }
    $scope.go_bid_list = function(){
        $navigate.go('/bid/list');
    }
    $scope.button_status_init();
    $scope.get_peoples();
}

