import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class PlayerList {

    ArrayList<Player> playerList = new ArrayList<>(1);

    void printWins() {
        System.out.println("Names\t\tOthello\t\tConnect4\t\tTotal" + "\n");
        for(int i = 0; i < playerList.size(); i++)
            System.out.println(playerList.get(i).getName() + "\t\t\t" + playerList.get(i).getOthelloWins() + "\t\t\t" +
                    playerList.get(i).getConnectFourWins() + "\t\t\t" + playerList.get(i).getTotalWins());
        System.out.println();
    }
    boolean loadPlayers(){

        Scanner input;

        try {
            File file = new File("player_Data.txt");
            input = new Scanner(file);
        } catch (FileNotFoundException e) {
            System.out.println("Player data could not be loaded.");
            return false;
        }

        while (input.hasNextLine()) {

            try {
                String line = input.nextLine();
                String[] lineArray = line.split("\t\t");
                Player newPlayer = new Player(lineArray[0], Integer.parseInt(lineArray[1]), Integer.parseInt(lineArray[2]));
                playerList.add(newPlayer);
            } catch (Exception e) {
                System.out.println("Player data incorrectly formatted.");
                playerList.clear();
                return false;
            }
        }
        input.close();
        return true;
    }

    void addPlayer(String name) {
        playerList.add(new Player(name));
    }
    Player getPlayer(String name) {
        for(int i = 0; i < playerList.size(); i ++) {
            if(playerList.get(i).getName().equals(name)) {
                return playerList.get(i);
            }
        }
        return null;
    }

    boolean recordData() throws IOException {
        if(playerList.isEmpty())
            return false;
        else {
            File file = new File("player_Data.txt");
            FileWriter writer = new FileWriter(file, false);

            for(int i = 0; i < playerList.size(); i++) {
                writer.write(playerList.get(i).getName() + "\t\t" + playerList.get(i).getOthelloWins() + "\t\t" +
                        playerList.get(i).getConnectFourWins() + "\t\t" + playerList.get(i).getTotalWins() + System.lineSeparator());
            }
            writer.close();
            return true;
        }
    }


}
