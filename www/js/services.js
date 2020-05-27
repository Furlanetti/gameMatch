angular.module('starter', [])
.service('UserService', function() {
  // For the purpose of this example I will store user data on ionic local storage but you should save it on a database
  var setUser = function(user_data) {
    window.localStorage.starter_facebook_user = JSON.stringify(user_data);
  };

  var getUser = function(){
    return JSON.parse(window.localStorage.starter_facebook_user || '{}');
  };

  return {
    getUser: getUser,
    setUser: setUser
  };
})

.service('PerfilService', function() {
    var perfils = [];
    var myPerfilService = {};
    
    myPerfilService.addPerfil = function(perfil) {
        perfils.push(perfil);
    };
    myPerfilService.removePerfil = function(perfil) {
        var index = perfils.indexOf(perfil);
        perfils.splice(index, 1);
    };
    myPerfilService.perfils = function() {
        return perfils;
    };
    
    return myPerfilService;
});
;