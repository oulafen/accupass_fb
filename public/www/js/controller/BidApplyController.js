function BidApplyController($scope, $navigate) {
    $scope.status_map = {
        'null': 'unbegin',
        'yellow': 'beginning',
        'lightgray': 'end'
    }
    $scope.bid_apply_begin_button_status_init = function () {
        $scope.present_biding = Bid.get_present_biding();
        $scope.click_biding = Bid.get_click_biding();
        if ($scope.present_biding.bid_status == 'yellow' &&
            $scope.click_biding.bid_name != $scope.present_biding.bid_name) {
            $scope.status = 'begin_disabled';
        } else {
            $scope.status = $scope.click_biding.bid_name == $scope.present_biding.bid_name ?
                $scope.status_map[$scope.present_biding.bid_status] :
                $scope.status_map[$scope.click_biding.bid_status];
        }
    }
    $scope.go_bid_list = function () {
        $navigate.go('/bid/list');
    }
    $scope.get_bid_peoples = function () {
        $scope.present_biding = Bid.get_present_biding();
        $scope.bid_peoples = $scope.present_biding.bid_people;
    }
    $scope.bid_apply_unbegin = function () {
        $scope.present_activity = Activity.get_present_activity();
        $scope.status = 'beginning';
        if ($scope.present_biding.bid_status != 'yellow') {
            $scope.present_biding.bid_name = $scope.click_biding.bid_name;
            $scope.sign_up_status = SignUp.get_sign_up_status();
            $scope.sign_up_status = 'end';
            SignUp.save_sign_up_status($scope.sign_up_status);
            $scope.present_biding.bid_status = 'yellow';
            $scope.present_activity.active_status = 'yellow';
            Bid.update_biding_activities($scope.present_biding);
            SignUp.update_sign_up_activities($scope.present_activity);
            Bid.save_present_biding_name($scope.present_biding.bid_name);
        }
    }
    $scope.bid_apply_beginning = function () {
        $scope.present_activity = Activity.get_present_activity();
        if (confirm('确定要结束本次竞价吗？')) {
            $scope.status = 'end';
            $scope.sign_up_status = 'unbegin';
            SignUp.save_sign_up_status($scope.sign_up_status);
            $scope.present_biding.bid_status = 'lightgray';
            $scope.present_activity.active_status = 'lightgray';
            Bid.update_biding_activities($scope.present_biding);
            SignUp.update_sign_up_activities($scope.present_activity);
            $navigate.go('/bid/result');
        }
    }
    $scope.click_biding_name = Bid.get_click_biding_name();
    $scope.bid_apply_begin_button_status_init();
    $scope.get_bid_peoples();
}

