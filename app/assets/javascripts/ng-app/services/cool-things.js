angular.module('MyApp.services').factory('CoolThings', [
  'railsResourceFactory',
  function (railsResourceFactory) {
    return railsResourceFactory({
      url: '/cool-things',
      name: 'coolThings'
    });
  }
]);