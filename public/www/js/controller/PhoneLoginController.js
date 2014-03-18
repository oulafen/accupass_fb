function PhoneLoginController($scope, $navigate) {

    $scope.error_show = 'false';

    $scope.login = function () {
        var post_data = {"name":$scope.name,'password':$scope.password};
        var post_url = 'users/process_phone_login';

        $http({ method: 'post', url: post_url ,data:post_data})
            .success(function(respond) {
                if(respond=='false'){
                    $scope.error_show = 'true';
                }
                if(respond=='true'){
                    $navigate.go('/activity/list');
                }
            })
            .error(function(respond) {})
    }
}