public class Player {

    private String name;
    private int totalWins = 0;
    private int othelloWins = 0;
    private int connectFourWins = 0;

    Player(String input) {
        name = input;
    }
    Player(String input, int othello, int connectFour) {
        name = input;
        othelloWins = othello;
        connectFourWins = connectFour;
        totalWins = othello + connectFour;
    }

    void setName(String input) {
        name = input;
    }
    void setOthelloWins(int wins) {
        othelloWins = wins;
        totalWins = othelloWins + connectFourWins;
    }
    void setConnectFourWins(int wins) {
        connectFourWins = wins;
        totalWins = connectFourWins + othelloWins;
    }

    String getName() {
        return name;
    }
    int getOthelloWins() {
        return othelloWins;
    }
    int getConnectFourWins() {
        return connectFourWins;
    }
    int getTotalWins() {
        return totalWins;
    }

    void addOthelloWin() {
        othelloWins++;
        totalWins++;
    }
    void addConnectFourWin() {
        connectFourWins++;
        totalWins++;
    }
}
