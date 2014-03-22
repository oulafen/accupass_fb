function Bid(bid_name) {
    this.activity_name = localStorage.getItem('present_activity_name');
    this.user = localStorage.user;
    this.bid_name = bid_name;
    this.bid_status = 'null';
}

Bid.get_present_bid_name = function () {
    return localStorage.getItem('present_bid_name');
}

Bid.save_present_bid_name = function (bid_name) {
    localStorage.setItem('present_bid_name', bid_name);
}

Bid.get_click_bid_name = function () {
    return localStorage.getItem('click_bid_name');
}

Bid.save_click_bid_name = function (bid_name) {
    localStorage.setItem('click_bid_name', bid_name);
}

Bid.get_bids_of_present_activity = function(){
    var bids = Bid.get_bids();
    return _.filter(bids,function(bid){
        return bid.activity_name == localStorage.getItem('present_activity_name');
    })||[];
}

Bid.get_bid_name = function () {
    var bids = Bid.get_bids_of_present_activity();
    return ('竞价' + (bids.length + 1));
}

Bid.get_bids = function(){
    var bids = JSON.parse(localStorage.getItem('bids'));
    return bids || [];
}

Bid.save_bid_name_to_bids = function (bid_name) {
    var bid = new Bid(bid_name);
    var bids = Bid.get_bids();
    bids.push(bid);
    localStorage.setItem('bids',JSON.stringify(bids));
}

Bid.get_present_bid = function () {
    return _.filter(Bid.get_bids(), function (bid) {
        return bid.bid_name == localStorage.getItem('present_bid_name')
    }) || [];
}

Bid.get_click_bid = function () {
    return _.find(Bid.get_bids(), function (bid) {
        return bid.bid_name == localStorage.getItem('click_bid_name')
    }) || [];
}

Bid.get_bid_people_by_phone = function (phone) {
    return _.find(Bid.get_present_bid_peoples(), function (bid_people) {
        return bid_people.phone == phone
    }) || {};
}

Bid.update_bids = function (present_bid) {
    var bids = Bid.get_bids();
    _.each(bids, function (bid) {
        if (bid.bid_name == present_bid.bid_name) {
            bid.bid_status = present_bid.bid_status;
        }
    });
    localStorage.setItem('bids',JSON.stringify(bids));
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
    var bid_peoples = JSON.parse(localStorage.getItem('bid_peoples'));
    return bid_peoples || [];
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