function ActivityListController($scope, $navigate,$http) {
    $scope.set_create_button_status = function () {
        $scope.present_activity = Activity.get_present_activity();
        $scope.button_status = $scope.present_activity.active_status == 'yellow' ?  'disable' : 'able';
    }

    $scope.go_create = function () {
        $navigate.go('/activity/create', 'slide', 'left');
    }

    $scope.go_apply = function (activity_name) {
        Activity.save_click_activity_name(activity_name);
        $navigate.go('/sign_ups', 'slide', 'left');
    }

    $scope.synchronize_data = function(){
        var activities = Activity.get_activities();
        var sign_ups = JSON.parse(localStorage.getItem('sign_ups'));
        var bids = JSON.parse(localStorage.getItem('bids'));
        var bid_peoples = JSON.parse(localStorage.getItem('bid_peoples'));
        console.log('activities-->',activities);
        console.log('sign_ups-->',sign_ups);
        console.log('bids-->',bids);
        console.log('bid_peoples-->',bid_peoples);

    }

    $scope.set_create_button_status();

    $scope.activities = Activity.get_activities();
}
