function BidListController($scope, $navigate) {
    $scope.begin_button_status_init=function() {
        $scope.present_biding = Bid.get_present_biding();
        $scope.status = $scope.present_biding.bid_status == 'yellow' ? 'begin_disabled' : 'unbegin';
    }
    $scope.go_bid_apply = function (bid_name) {
        Bid.save_click_biding_name(bid_name);
        $navigate.go('/bid/apply');
    }
    $scope.go_sign_ups = function(){
        $navigate.go('/sign_ups');
    }
    $scope.bid_unbegin = function () {
        $scope.bid_name = Bid.get_bid_name();
        Bid.save_bid_name_to_activities($scope.bid_name);
        Bid.save_click_biding_name($scope.bid_name);
        Bid.save_present_biding_name($scope.bid_name);
        $scope.status = 'begin_disabled';
        $navigate.go('/bid/apply');
    }
    $scope.go_activity_list = function () {
        $navigate.go('/activity/list');
    }
    $scope.bidings = function () {
        $scope.present_activity = Activity.get_present_activity();
        $scope.bidings = $scope.present_activity.biding;
    }
    $scope.begin_button_status_init();
    $scope.bidings();
}

