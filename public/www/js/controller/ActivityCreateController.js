function ActivityCreateController($scope, $navigate) {
    $scope.input_name = '';
    $scope.back_button_status = function () {
        $scope.activities = Activity.get_activities();
        $scope.show = $scope.activities.length != 0;
    }
    $scope.go_activity_list_page = function () {
        $navigate.go('/activity/list');
    }
    $scope.set_active_name = function () {
        $scope.activity = new Activity('', null, [], []);
        if (!$scope.button_be_gray && Activity.judge_activity_name_is_repeat($scope.input_name)) {
            $scope.name_repeat = true;
        } else {
            $scope.activity.active_name = $scope.input_name;
            $scope.activities.unshift($scope.activity);
            Activity.save_activities($scope.activities);
            Activity.save_present_activity_name($scope.input_name);
            Activity.save_click_activity_name($scope.input_name);
            $navigate.go('/sign_ups', 'slide', 'left');
        }
    }
    $scope.create_button_status = function () {
        $scope.button_be_gray = $scope.input_name.length == 0;
    }
    $scope.create_button_status_change = function () {
        $scope.create_button_status();
    }
    $scope.back_button_status();
    $scope.create_button_status();
    SignUp.save_sign_up_status('unbegin');
}
