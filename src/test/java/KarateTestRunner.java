import com.intuit.karate.junit5.Karate;

public class KarateTestRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:pokemon/get/pokemonTests.feature").relativeTo(getClass());
    }
}