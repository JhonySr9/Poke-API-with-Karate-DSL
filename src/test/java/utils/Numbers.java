package utils;

public class Numbers {

    public int randomNumber(double max) {
        int randomNumber = 0;
        while (randomNumber == 0) {
            randomNumber = (int) Math.floor(Math.random() * max);
        }
        return randomNumber;
    }
}
