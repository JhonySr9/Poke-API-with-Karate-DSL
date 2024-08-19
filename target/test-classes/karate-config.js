function fn() {

  //General Configuration
  var config = {
  baseUrlPokemon: 'https://pokeapi.co/api/v2/',
  baseUrlJson: 'https://jsonplaceholder.typicode.com/'
  };

  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);

  //Functions
  var Numbers = Java.type("utils.Numbers");
  var numbers = new Numbers;
  config.numbers = numbers;

  return config;
}