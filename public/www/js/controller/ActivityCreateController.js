function ActivityCreateController($scope, $navigate) {
    $scope.input_name = '';

    $scope.back_button_status = function () {
        $scope.activities = Activity.get_activities();
        $scope.show = $scope.activities.length != 0;
    }

    $scope.go_activity_list_page = function () {
        $navigate.go('/activity/list');
    }

    $scope.set_active_name = function(){
        if (!$scope.input_name.length==0){
            process_active_name($scope.input_name)
        }
    }

    function process_active_name (name) {
        $scope.activity = new Activity('', null, [], []);

        if (Activity.judge_activity_name_is_repeat(name)) {
            $scope.name_repeat = true;
        }  else{
            $scope.activity.active_name = name;
            $scope.activities.unshift($scope.activity);

            Activity.save_activities($scope.activities);
            Activity.save_present_activity_name(name);
            Activity.save_click_activity_name(name);

            $navigate.go('/sign_ups', 'slide', 'left');
        }
    }

    $scope.back_button_status();

    SignUp.save_sign_up_status('unbegin');
}