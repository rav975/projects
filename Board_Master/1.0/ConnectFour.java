import java.io.IOException;
import java.util.*;

public class ConnectFour {

    private char turn = 'B';
    private Board gameBoard;
    private Player playerBlack;
    private Player playerWhite;

    private ConnectFour(Player black, Player white) {
        gameBoard = new Board(7);
        playerBlack = black;
        playerWhite = white;
    }

    private void changeTurn() {
        if (turn == Board.blackChip)
            turn = Board.whiteChip;
        else
            turn = Board.blackChip;
    }

    private Board getGameBoard() {
        return gameBoard;
    }
    private char getTurn() {
        return turn;
    }
    private Player getPlayerBlack() {
        return playerBlack;
    }
    private Player getPlayerWhite() {
        return playerWhite;
    }

    private boolean makeMove(int col) {
        if(turn == Board.blackChip)
            return placeBlackChip(col);
        else
            return placeWhiteChip(col);
    }
    private boolean placeBlackChip(int col) {
        boolean placed = false;
        for(int i = gameBoard.getSize()-1; i >= 0; i--) {
            if(gameBoard.getCell(i, col).getStatus() == Board.nullChip) {
                gameBoard.getCell(i, col).setToBlack();
                placed = true;
                break;
            }
        }
        return placed;
    }
    private boolean placeWhiteChip(int col) {
        boolean placed = false;
        for(int i = gameBoard.getSize()-1; i >= 0; i--) {
            if(gameBoard.getCell(i, col).getStatus() == Board.nullChip) {
                gameBoard.getCell(i, col).setToWhite();
                placed = true;
                break;
            }
        }
        return placed;
    }

    private boolean connect4() {

        for(int n = 0; n < gameBoard.getSize(); n++) {
            for(int m = 0; m < gameBoard.getSize(); m++) {

                if(gameBoard.getCell(n,m).getStatus() == Board.nullChip)
                    continue;
                if(gameBoard.getCell(n, m).getStatus() != turn)
                    continue;;

                for(int i = 0; i < gameBoard.getCell(n, m).getTestDirections().size(); i++) {

                    ArrayList<Board.Cell> testArray = new ArrayList<>(1);
                    testArray.add(gameBoard.getCell(n, m));

                    switch(gameBoard.getCell(n, m).getTestDirections().get(i)) {

                        case 'D':
                            traverseDown(n, m, testArray);
                            if(testArray.size() >= 4)
                                return true;
                            break;

                        case 'R':
                            traverseRight(n, m, testArray);
                            if(testArray.size() >= 4)
                                return true;
                            break;

                        case 'Y':
                            traverseDL(n, m, testArray);
                            if(testArray.size() >= 4)
                                return true;
                            break;

                        case 'Z':
                            traverseDR(n, m, testArray);
                            if(testArray.size() >= 4)
                                return true;
                            break;
                    }
                }
            }
        }
        return false;
    }

    private void traverseDown(int n, int m, ArrayList<Board.Cell> list) {

        boolean startOnEdgeCol = false;

        if((m == 0) || (m == (gameBoard.getSize() - 1)))
            startOnEdgeCol = true;

        int currentRow = n;

        while(gameBoard.getCell(currentRow + 1, m).getStatus() == turn) {
            list.add(gameBoard.getCell(currentRow + 1, m));
            currentRow++;
            if(startOnEdgeCol) {
                if(gameBoard.getCell(currentRow, m).isCorner())
                    break;
            }
            else if (gameBoard.getCell(currentRow, m).isEdgeCell())
                break;
        }
    }
    private void traverseRight(int n, int m, ArrayList<Board.Cell> list) {

        boolean startOnEdgeRow = false;

        if((n == 0) || (n == (gameBoard.getSize() - 1)))
            startOnEdgeRow = true;

        int currentCol = m;

        while(gameBoard.getCell(n, currentCol + 1).getStatus() == turn) {
            list.add(gameBoard.getCell(n, currentCol + 1));
            currentCol++;
            if(startOnEdgeRow) {
                if(gameBoard.getCell(n, currentCol).isCorner())
                    break;
            }
            else if (gameBoard.getCell(n, currentCol).isEdgeCell())
                break;
        }
    }
    private void traverseDL(int n, int m, ArrayList<Board.Cell> list) {

        int currentRow = n;
        int currentCol = m;

        while(gameBoard.getCell(currentRow + 1, currentCol - 1).getStatus() == turn) {
            list.add(gameBoard.getCell(currentRow + 1, currentCol - 1));
            currentRow++;
            currentCol--;
            if (gameBoard.getCell(currentRow, currentCol).isEdgeCell())
                break;
        }
    }
    private void traverseDR(int n, int m, ArrayList<Board.Cell> list) {

        int currentRow = n;
        int currentCol = m;

        while(gameBoard.getCell(currentRow + 1, currentCol + 1).getStatus() == turn) {
            list.add(gameBoard.getCell(currentRow + 1, currentCol + 1));
            currentRow++;
            currentCol++;
            if (gameBoard.getCell(currentRow, currentCol).isEdgeCell())
                break;
        }
    }

    static void playConnectFour(Player black, Player white) throws IOException {

        boolean gameOver = false;

        ConnectFour game = new ConnectFour(black, white);

        while(!gameOver) {

            int move = 0;
            game.getGameBoard().printBoard();

            do {
                if(game.getTurn() == Board.blackChip)
                    System.out.println("BLACK'S TURN.\n999 = QUIT GAME\nCHOOSE COLUMN:");
                else
                    System.out.println("WHITE'S TURN.\n999 = QUIT GAME\nCHOOSE COLUMN:");

                try {
                    Scanner input = new Scanner(System.in);
                    move = input.nextInt();
                } catch(Exception e){
                    System.out.println("NOT A NUMBER.");
                }
            } while((move < 1 || move > game.getGameBoard().getSize()) && (move != 999));

            if(move == 999) {
                System.out.println("GAME ENDED.\n");
                break;
            }
            if(game.makeMove(move-1)) {
                if (game.connect4()) {
                    game.getGameBoard().printBoard();
                    System.out.println("CONNECT FOUR!\n");
                    gameOver = true;
                    if(game.getTurn() == Board.blackChip) {
                        System.out.println("BLACK WINS!\n");
                        game.getPlayerBlack().addConnectFourWin();
                    }
                    else {
                        System.out.println("WHITE WINS!\n");
                        game.getPlayerWhite().addConnectFourWin();
                    }
                }
                else
                    game.changeTurn();
            }
            else
                System.out.println("COLUMN FULL.");
        }
    }
}
