package pokemon.get;

import com.intuit.karate.junit5.Karate;

public class PokeRunner {

    @Karate.Test
    Karate GetPokemon_Smoke() {
        return Karate.run("classpath:pokemon/get/pokemonTests.feature").tags("smoke");
    }

    @Karate.Test
    Karate GetPokemon_Functional() {
        return Karate.run("classpath:pokemon/get/pokemonTests.feature").tags("functional");
    }

    @Karate.Test
    Karate GetPokemon_Sanity() {
        return Karate.run("classpath:pokemon/get/pokemonTests.feature").tags("sanity");
    }
}