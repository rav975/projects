import java.io.IOException;
import java.util.*;

//GAME STATS AND LOGIC FOR OTHELLO. CONSTRUCTING A GAME OF OTHELLO CONSTRUCTS A BOARD TO PLAY ON AS WELL.
public class Othello {

    private int blackScore = 2;
    private int whiteScore = 2;
    private int blackMoves = 4;
    private int whiteMoves = 4;
    private char turn = 'B';
    private Board gameBoard;
    private Player playerBlack;
    private Player playerWhite;

    //CONSTRUCT THE GAME
    private Othello(int size, Player black, Player white) {
        gameBoard = new Board(size);
        playerBlack = black;
        playerWhite = white;
        setInitialPieces();
    }

    private void setScore() {
        int blackCount = 0;
        int whiteCount = 0;
        for (int i = 0; i < gameBoard.getSize(); i++) {
            for (int j = 0; j < gameBoard.getSize(); j++) {
                if (gameBoard.getCell(i, j).getStatus() == Board.blackChip)
                    blackCount++;
                else if (gameBoard.getCell(i, j).getStatus() == Board.whiteChip)
                    whiteCount++;
            }
        }
        blackScore = blackCount;
        whiteScore = whiteCount;
    }
    private void changeTurn() {
        if (turn == Board.blackChip)
            turn = Board.whiteChip;
        else
            turn = Board.blackChip;
    }
    private void setPlayerBlack(Player black) {
        playerBlack = black;
    }
    private void setPlayerWhite(Player white) {
        playerWhite = white;
    }

    private Board getGameBoard() {
        return gameBoard;
    }
    private char getTurn() {
        return turn;
    }
    private int getBlackScore() {
        return blackScore;
    }
    private int getWhiteScore() {
        return whiteScore;
    }
    private int getBlackMoves() {
        return blackMoves;
    }
    private int getWhiteMoves() {
        return whiteMoves;
    }
    private Player getPlayerBlack() {
        return playerBlack;
    }
    private Player getPlayerWhite() {
        return playerWhite;
    }

    private void setInitialPieces() {
        gameBoard.getCell(gameBoard.getSize() / 2 - 1, gameBoard.getSize() / 2 - 1).setToBlack();
        gameBoard.getCell(gameBoard.getSize() / 2 - 1, gameBoard.getSize() / 2).setToWhite();
        gameBoard.getCell(gameBoard.getSize() / 2, gameBoard.getSize() / 2 - 1).setToWhite();
        gameBoard.getCell(gameBoard.getSize() / 2, gameBoard.getSize() / 2).setToBlack();
    }

    //MAKE MOVE AT COORDINATES(n,m)
    private void makeMove(int n, int m, boolean moveCheck) {

        //FLIPPED IS A HELPER BOOLEAN SO MORE THAN ONE DIRECTION IS TESTED
        boolean flipped = false;

        //FOR EACH TEST DIRECTION, BUILD AN ARRAY TO TEST IN THAT DIRECTION
        for (int i = 0; i < gameBoard.getCell(n, m).getTestDirections().size(); i++) {

            //DECLARE TEST ARRAY AND ADD THE TARGET CELL
            ArrayList<Board.Cell> testArray = new ArrayList<>(1);
            testArray.add(gameBoard.getCell(n, m));

            //MAKE THE TARGET CELL BLACK OR WHITE
            if (turn == Board.blackChip)
                gameBoard.getCell(n, m).setToBlack();
            else
                gameBoard.getCell(n, m).setToWhite();

            boolean startOnEdgeRow = false;
            boolean startOnEdgeCol = false;

            if(n == 0 || n == gameBoard.getSize() - 1)
                startOnEdgeRow = true;
            if(m == 0 || m == gameBoard.getSize() - 1)
                startOnEdgeCol = true;

            //BUILD THE TEST ARRAYS FOR EACH OF THE POSSIBLE DIRECTIONS
            //D = DOWN | U = UP | L = LEFT | R = RIGHT
            switch (gameBoard.getCell(n, m).getTestDirections().get(i)) {
                case 'D':
                    //IF ITS NOT AN EDGE CELL, WE NEED TO CHECK IF ITS PLACED ON THE END OF A LINE FIRST THEN TRAVERSE IF IT IS
                    if(!startOnEdgeRow)
                        if(gameBoard.getCell(n-1, m).getStatus() != Board.nullChip)
                            continue;
                    traverseDown(n, m, testArray);
                    break;
                case 'U':
                    if(!startOnEdgeRow)
                        if(gameBoard.getCell(n+1, m).getStatus() != Board.nullChip)
                            continue;
                    traverseUp(n, m, testArray);
                    break;
                case 'L':
                    if(!startOnEdgeCol)
                        if(gameBoard.getCell(n, m+1).getStatus() != Board.nullChip)
                            continue;
                    traverseLeft(n, m, testArray);
                    break;
                case 'R':
                    if(!startOnEdgeCol)
                        if(gameBoard.getCell(n, m-1).getStatus() != Board.nullChip)
                            continue;
                    traverseRight(n, m, testArray);
                    break;
                //T = UP LEFT | X = UP RIGHT | Y = DOWN LEFT | Z = DOWN RIGHT
                case 'T':
                    if(!gameBoard.getCell(n, m).isEdgeCell())
                        if(gameBoard.getCell(n+1, m+1).getStatus() != Board.nullChip)
                            continue;
                    traverseUL(n, m, testArray);
                    break;
                case 'X':
                    if(!gameBoard.getCell(n, m).isEdgeCell())
                        if(gameBoard.getCell(n+1, m-1).getStatus() != Board.nullChip)
                            continue;
                    traverseUR(n, m, testArray);
                    break;
                case 'Y':
                    if(!gameBoard.getCell(n, m).isEdgeCell())
                        if(gameBoard.getCell(n-1, m+1).getStatus() != Board.nullChip)
                            continue;
                    traverseDL(n, m, testArray);
                    break;
                case 'Z':
                    if(!gameBoard.getCell(n, m).isEdgeCell())
                        if(gameBoard.getCell(n-1, m-1).getStatus() != Board.nullChip)
                            continue;
                    traverseDR(n, m, testArray);
                    break;
            }
            //IF THE TEST ARRAY IS VALID, FLIP THE ROW AND SET FLIPPED TO TRUE SO IT KNOWS AT LEAST ONE TEST ARRAY WAS VALID
            //IF ITS NOT VALID THE ORIGINAL TARGET CELL WILL BE SET BACK TO NULL SO PROCESS CAN REPEAT FOR EACH TEST DIRECTION
            if(!moveCheck) {
                if (checkTestArray(testArray)) {
                    flipArray(testArray);
                    flipped = true;
                }
            }
            else {
                if(checkTestArray(testArray)) {
                    flipped = true;
                }
            }
        }
        //IF NO TEST ARRAYS IN ANY DIRECTION WERE VALID PRINT INVALID MOVE, IF AT LEAST ONE WAS VALID CHANGE THE TURN AND PRINT THE BOARD
        if(!moveCheck) {
            if (!flipped) {
                gameBoard.getCell(n, m).setToNull();
                System.out.println("INVALID MOVE.\n");
            }
            else {
                changeTurn();
            }
        }
        else {
            if(flipped) {
                if (turn == Board.blackChip)
                    blackMoves++;
                else
                    whiteMoves++;
            }
        }
    }

    private void checkForMoves() {
        if(turn == Board.blackChip)
            blackMoves = 0;
        else
            whiteMoves = 0;

        for(int n = 0; n < gameBoard.getSize(); n++) {
            for(int m = 0; m < gameBoard.getSize(); m++) {
                if(gameBoard.getCell(n, m).getStatus() != Board.nullChip)
                    continue;
                makeMove(n, m, true);
                gameBoard.getCell(n, m).setToNull();
            }
        }
        if(turn == Board.blackChip)
            System.out.println(turn + " has " + blackMoves + " moves.");
        else
            System.out.println(turn + " has " + whiteMoves + " moves.");
    }

    //TRAVERSAL METHODS TO BUILD TEST ARRAY
    private void traverseDown(int n, int m, ArrayList<Board.Cell> list) {
        //BOOLEAN FOR TRAVERSING EDGES
        boolean startOnEdgeCol = false;

        if((m == 0) || (m == (gameBoard.getSize() - 1)))
            startOnEdgeCol = true;

        int currentRow = n;
        //ADD THE CELLS THAT AREN'T NULL UNTIL THE EDGE IS REACHED. IF ITS AN EDGE TRAVERSAL IT WILL STOP WHEN IT REACHES A CORNER
        while (gameBoard.getCell(currentRow + 1, m).getStatus() != Board.nullChip) {
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
    private void traverseUp(int n, int m, ArrayList<Board.Cell> list) {

        boolean startOnEdgeCol = false;

        if((m == 0) || (m == (gameBoard.getSize() - 1)))
            startOnEdgeCol = true;

        int currentRow = n;

        while (gameBoard.getCell(currentRow - 1, m).getStatus() != Board.nullChip) {
            list.add(gameBoard.getCell(currentRow - 1, m));
            currentRow--;
            if(startOnEdgeCol) {
                if(gameBoard.getCell(currentRow, m).isCorner())
                    break;
            }
            else if (gameBoard.getCell(currentRow, m).isEdgeCell())
                break;
        }
    }
    private void traverseLeft(int n, int m, ArrayList<Board.Cell> list) {

        boolean startOnEdgeRow = false;

        if((n == 0) || (n == (gameBoard.getSize() - 1)))
            startOnEdgeRow = true;

        int currentCol = m;

        while (gameBoard.getCell(n, currentCol - 1).getStatus() != Board.nullChip) {
            list.add(gameBoard.getCell(n, currentCol - 1));
            currentCol--;
            if(startOnEdgeRow) {
                if(gameBoard.getCell(n, currentCol).isCorner())
                    break;
            }
            else if (gameBoard.getCell(n, currentCol).isEdgeCell())
                break;
        }
    }
    private void traverseRight(int n, int m, ArrayList<Board.Cell> list) {

        boolean startOnEdgeRow = false;

        if((n == 0) || (n == (gameBoard.getSize() - 1)))
            startOnEdgeRow = true;

        int currentCol = m;

        while (gameBoard.getCell(n, currentCol + 1).getStatus() != Board.nullChip) {
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
    private void traverseUL(int n, int m, ArrayList<Board.Cell> list) {

        int currentRow = n;
        int currentCol = m;

        while (gameBoard.getCell(currentRow - 1, currentCol - 1).getStatus() != Board.nullChip) {
            list.add(gameBoard.getCell(currentRow - 1, currentCol - 1));
            currentRow--;
            currentCol--;
            if (gameBoard.getCell(currentRow, currentCol).isEdgeCell())
                break;
        }
    }
    private void traverseUR(int n, int m, ArrayList<Board.Cell> list) {

        int currentRow = n;
        int currentCol = m;

        while (gameBoard.getCell(currentRow - 1, currentCol + 1).getStatus() != Board.nullChip) {
            list.add(gameBoard.getCell(currentRow - 1, currentCol + 1));
            currentRow--;
            currentCol++;
            if (gameBoard.getCell(currentRow, currentCol).isEdgeCell())
                break;
        }
    }
    private void traverseDL(int n, int m, ArrayList<Board.Cell> list) {

        int currentRow = n;
        int currentCol = m;

        while (gameBoard.getCell(currentRow + 1, currentCol - 1).getStatus() != Board.nullChip) {
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

        while (gameBoard.getCell(currentRow + 1, currentCol + 1).getStatus() != Board.nullChip) {
            list.add(gameBoard.getCell(currentRow + 1, currentCol + 1));
            currentRow++;
            currentCol++;
            if (gameBoard.getCell(currentRow, currentCol).isEdgeCell())
                break;
        }
    }

    //CHECK IF THE ARRAY OF CELLS IS A VALID MOVE
    private boolean checkTestArray(ArrayList<Board.Cell> testList) {

        boolean valid = false;

        //IF THE TEST ARRAY ISNT AT LEAST 3 CELLS ITS IMPOSSIBLE TO BE VALID
        if (testList.size() < 3)
            return false;
            //DEPENDING ON WHO'S TURN, TEST THE FIRST AND LAST ELEMENTS OF THE ARRAY AND THEN THE MIDDLE ELEMENTS
        else if (turn == Board.blackChip) {
            //IF THE FIRST AND LAST ELEMENT CHECK OUT, SET VALID TO TRUE AND TEST THE MIDDLE ELEMENTS
            if (testList.get(0).getStatus() == Board.blackChip && testList.get(testList.size() - 1).getStatus() == Board.blackChip) {
                valid = true;
                //IF ANY OF THE MIDDLE ELEMENTS ISN'T CORRECT, SET VALID TO FALSE
                for (int i = 1; i < testList.size() - 1; i++) {
                    if (testList.get(i).getStatus() != Board.whiteChip)
                        valid = false;
                }
            }
        }
        //SAME PROCESS FOR WHITE
        else {
            if (testList.get(0).getStatus() == Board.whiteChip && testList.get(testList.size() - 1).getStatus() == Board.whiteChip) {
                valid = true;
                for (int i = 1; i < testList.size() - 1; i++) {
                    if (testList.get(i).getStatus() != Board.blackChip)
                        valid = false;
                }
            }
        }
        return valid;
    }

    //FLIP THE CELLS IF THE TEST ARRAY IS VALID
    private void flipArray(ArrayList<Board.Cell> flipList) {

        for (int i = 0; i < flipList.size(); i++) {
            if (turn == Board.blackChip)
                flipList.get(i).setToBlack();
            else
                flipList.get(i).setToWhite();
        }
    }

    //PLAY THE GAME
    static void playOthello(Player black, Player white) throws IOException {
        //GAME OVER BOOLEAN AND N FOR AN N X N BOARD
        boolean gameOver = false;
        int n = 0;

        //IF BOARD SIZE IS TOO BIG OR SMALL IT WILL ASK AGAIN
        do {
            try {
                System.out.println("Enter n for an n x n game board:");
                Scanner input = new Scanner(System.in);
                n = input.nextInt();
            } catch (Exception e) {
                System.out.println("INVALID INPUT.");
            }
        } while((n > 50) || (n < 6));

        //CREATE THE GAME AND PRINT THE BOARD
        Othello game = new Othello(n, black, white);
        game.getGameBoard().printBoard();

        //UNTIL THE GAME IS OVER, ASK FOR COORDINATES AND TEST FOR OUT OF BOUNDS AND SPECIAL INSTRUCTION COORDINATES
        while(!gameOver) {

            if(game.getTurn() == Board.blackChip)
                System.out.println("BLACK'S MOVE\n999 999 = QUIT GAME\n000 000 = PASS");
            else
                System.out.println("WHITE'S MOVE\n999 999 = QUIT GAME\n000 000 = PASS");

            int x = 0;
            int y = 0;

            try {
                Scanner input2 = new Scanner(System.in);
                System.out.println("ENTER ROW:");
                x = input2.nextInt();
                System.out.println("ENTER COLUMN:");
                y = input2.nextInt();
            } catch(Exception e) {
                System.out.println("INVALID INPUT.\n");
                continue;
            }

            if((x == 999) && (y == 999)) {
                System.out.println("GAME ENDED.\n");

                gameOver = true;
                continue;
            }
            else if((x == 000) && (y == 000)) {
                System.out.println("TURN PASSED.\n");
                game.changeTurn();
                continue;
            }
            else if(((x < 1) || (x > n)) || (y < 1) || (y > n) || (game.getGameBoard().getCell(x-1,y-1).getStatus() != Board.nullChip)) {
                System.out.println("INVALID COORDINATES.\n");
                continue;
            }
            game.makeMove(x-1,y-1, false);
            game.getGameBoard().printBoard();
            game.setScore();
            System.out.println("Score: \nBlack: " + game.getBlackScore() + " \tWhite: " + game.getWhiteScore());
            System.out.println();

            game.checkForMoves();
            game.changeTurn();
            game.checkForMoves();
            game.changeTurn();

            if(game.getBlackMoves() == 0 && game.getWhiteMoves() == 0) {
                gameOver = true;
                if(game.getBlackScore() > game.getWhiteScore()) {
                    game.getPlayerBlack().addOthelloWin();
                    System.out.println("GAME OVER. BLACK WINS!\n");

                }
                else {
                    game.getPlayerWhite().addOthelloWin();
                    System.out.println("GAME OVER. WHITE WINS!\n");

                }
            }
        }
    }
}
