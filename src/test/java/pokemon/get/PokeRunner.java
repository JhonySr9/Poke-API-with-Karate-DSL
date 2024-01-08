package pokemon.get;

import com.intuit.karate.junit5.Karate;

public class PokeRunner {

    @Karate.Test
    Karate GetPokemon() {
        return Karate.run().relativeTo(getClass());
    }
}