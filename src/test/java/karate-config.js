function fn() {
  var config = {
  baseUrl: 'https://pokeapi.co/api/v2/',
  baseUrlJson: 'https://jsonplaceholder.typicode.com/'
  };
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}