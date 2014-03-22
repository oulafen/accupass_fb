function BidListController($scope, $navigate) {
    $scope.begin_button_status_init=function() {
        $scope.present_bid = Bid.get_present_bid();
        $scope.status = $scope.present_bid.bid_status == 'yellow' ? 'begin_disabled' : 'unbegin';
    }

    $scope.go_bid_apply = function (bid_name) {
        Bid.save_click_bid_name(bid_name);
        $navigate.go('/bid/apply');
    }

    $scope.go_sign_ups = function(){
        $navigate.go('/sign_ups');
    }

    $scope.bid_unbegin = function () {
        $scope.bid_name = Bid.get_bid_name();
        Bid.save_bid_name_to_bids($scope.bid_name);
        Bid.save_click_bid_name($scope.bid_name);
        Bid.save_present_bid_name($scope.bid_name);
        $scope.status = 'begin_disabled';
        $navigate.go('/bid/apply');
    }

    $scope.go_activity_list = function () {
        $navigate.go('/activity/list');
    }

    $scope.bids = function () {
        $scope.bidings = Bid.get_bids();
    }

    $scope.begin_button_status_init();

    $scope.bids();
}

