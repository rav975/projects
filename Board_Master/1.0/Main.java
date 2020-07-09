import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws IOException {

        PlayerList playerList = new PlayerList();

        if(playerList.loadPlayers())
            playerList.printWins();

        boolean go = true;

        while(go) {
            int x;
            try {
                System.out.println("Welcome to Board Master!\n");
                System.out.println("1. Othello\n2. Connect Four\n3. Add New Player\n4. Exit\nEnter a number to choose a game: ");
                Scanner input = new Scanner(System.in);
                x = input.nextInt();
            } catch(Exception e) {
                System.out.println("Not a number.");
                continue;
            }

            switch(x) {
                case 1:
                    Player playerBlack;
                    Player playerWhite;
                    while(true) {
                        System.out.println("Who will be black?");
                        Scanner input = new Scanner(System.in);
                        String black = input.next();
                        playerBlack = playerList.getPlayer(black);
                        if (playerBlack != null)
                            break;
                        else
                            System.out.println("Player does not exist.");
                    }
                    while(true) {
                        System.out.println("Who will be white?");
                        Scanner input = new Scanner(System.in);
                        String white = input.next();
                        playerWhite = playerList.getPlayer(white);
                        if (playerWhite != null)
                            break;
                        else
                            System.out.println("Player does not exist.");
                    }
                    Othello.playOthello(playerBlack, playerWhite);
                    playerList.printWins();
                    break;
                case 2:
                    Player playerBlack2;
                    Player playerWhite2;
                    while(true) {
                        System.out.println("Who will be black?");
                        Scanner input = new Scanner(System.in);
                        String black = input.next();
                        playerBlack2 = playerList.getPlayer(black);
                        if (playerBlack2 != null)
                            break;
                        else
                            System.out.println("Player does not exist.");
                    }
                    while(true) {
                        System.out.println("Who will be white?");
                        Scanner input = new Scanner(System.in);
                        String white = input.next();
                        playerWhite2 = playerList.getPlayer(white);
                        if (playerWhite2 != null)
                            break;
                        else
                            System.out.println("Player does not exist.");
                    }
                    ConnectFour.playConnectFour(playerBlack2, playerWhite2);
                    playerList.printWins();
                    break;
                case 3:
                    System.out.println("Enter player name:");
                    Scanner input = new Scanner(System.in);
                    playerList.addPlayer(input.nextLine());
                    playerList.printWins();
                    break;
                case 4:
                    System.out.println("Goodbye!");
                    playerList.recordData();
                    go = false;
                    break;
            }
        }
    }
}
