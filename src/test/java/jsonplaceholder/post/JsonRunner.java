package jsonplaceholder.post;

import com.intuit.karate.junit5.Karate;

public class JsonRunner {

    @Karate.Test
    Karate PostJson(){
        return Karate.run().relativeTo(getClass());
    }
}
