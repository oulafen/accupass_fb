function PhoneLoginController($scope, $navigate,$http) {

    $scope.error_show = 'false';

    $scope.login = function () {
        var post_data = {"name":$scope.name,'password':$scope.password};
        var post_url = '/process_phone_login';
//        var post_url = 'http://192.168.1.133:3000/users/process_phone_login';
        $http.post(post_url,post_data).success(function(respond) {
                if(respond=='false'){
                    $scope.error_show = 'true';
                }
                if(respond=='true'){
                    localStorage.user = post_data.name;
                    $navigate.go('/activity/list');
                }
            });
    }
}