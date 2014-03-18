function Bid(bid_name, bid_status, bid_people) {
    this.bid_name = bid_name;
    this.bid_status = bid_status;
    this.bid_people = bid_people;
}

Bid.get_present_biding_name = function () {
    return localStorage.getItem('present_biding_name');
}
Bid.save_present_biding_name = function (bid_name) {
    localStorage.setItem('present_biding_name', bid_name);
}
Bid.get_click_biding_name = function () {
    return localStorage.getItem('click_biding_name');
}
Bid.save_click_biding_name = function (bid_name) {
    localStorage.setItem('click_biding_name', bid_name);
}
Bid.get_bid_name = function () {
    return ('竞价' + (Activity.get_present_activity().biding.length + 1));
}
Bid.save_bid_name_to_activities = function (bid_name) {
    var activities = Activity.get_activities();
    var biding = new Bid(bid_name, 'null', []);
    _.map(activities, function (activity) {
        if (activity.active_name == Activity.get_present_activity_name()) {
            activity.biding.unshift(biding);
        }
    });
    Activity.save_activities(activities);
}
Bid.get_present_biding = function () {
    return _.find(Activity.get_present_activity().biding, function (biding) {
        return biding.bid_name == localStorage.getItem('present_biding_name')
    }) || [];
}
Bid.get_click_biding = function () {
    return _.find(Activity.get_click_activity().biding, function (biding) {
        return biding.bid_name == localStorage.getItem('click_biding_name')
    }) || [];
}
Bid.get_bid_people_by_phone = function (phone) {
    return _.find(Activity.get_present_activity().apply_people, function (bid_people) {
        return bid_people.phone == phone
    }) || {};
}
Bid.update_biding_activities = function (present_biding) {
    var activities = Activity.get_activities();
    var present_activity = Activity.get_present_activity();
    _.each(present_activity.biding, function (biding) {
        if (biding.bid_name == present_biding.bid_name) {
            biding.bid_status = present_biding.bid_status;
        }
    });
    _.map(activities, function (activity) {
        if (activity.active_name == present_activity.active_name) {
            activity.biding = present_activity.biding;
        }
        return activity
    });
    Activity.save_activities(activities);
}
Bid.get_prices = function () {
    var prices = [];
    _.each(Bid.get_bid_peoples_by_price(), function (present_bid_people) {
        var price = {};
        if (!Bid.judge_find_in_prices(prices, present_bid_people.price)) {
            price.price = present_bid_people.price;
            price.number = Bid.get_same_price(present_bid_people.price).length;
            prices.push(price);
        }
    });
    return prices;
}
Bid.get_present_bid_peoples = function () {
    return Bid.get_present_biding().bid_people;
}
Bid.judge_find_in_prices = function (prices, p) {
    return _.find(prices, function (price) {
        return price.price == p;
    });
}
Bid.get_same_price = function (price) {
    return _.filter(Bid.get_present_bid_peoples(), function (present_bid_people) {
        return  present_bid_people.price == price
    });
}
Bid.get_bid_peoples_by_price = function () {
    return _.sortBy(Bid.get_present_bid_peoples(), function (bid_people) {
        return bid_people.price
    });
}
Bid.get_bid_winner = function () {
    var win_price = _.find(Bid.get_prices(), function (price) {
        return price.number == 1;
    }) || [];
    return _.find(Bid.get_bid_peoples_by_price(), function (present_bid_people) {
        return present_bid_people.price == win_price.price;
    });
}