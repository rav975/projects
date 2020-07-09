import java.util.*;

//BOARD HAS CHIP TYPES, A SIZE, AND AN ARRAY OF CELLS
//CELLS ARE THEIR OWN OBJECTS IN A CLASS NESTED IN BOARD
public class Board {

    //CHIP TYPES. ANY COLOR MAY BE ADDED.
    static final char blackChip = 'B';
    static final char whiteChip = 'W';
    static final char nullChip = '_';
    //SIZE AND THE 2D ARRAY OF CELLS
    private int size;
    private Cell cellArray[][];

    //CONSTRUCT THE BOARD
    Board(int dimensions) {
        size = dimensions;
        cellArray = new Cell[dimensions][dimensions];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                cellArray[i][j] = new Cell(i ,j);
            }
        }
    }

    Cell getCell(int n, int m) {
        return cellArray[n][m];
    }
    int getSize() {
        return size;
    }

    void printBoard() {

        System.out.print("    ");
        for (int i = 1; i <= getSize(); i++) {

            if (i < 10)
                System.out.print(i + "  ");
            else
                System.out.print(i + " ");
        }
        System.out.println();
        for (int i = 0; i < getSize(); i++) {

            if ((i + 1) < 10)
                System.out.print(i + 1 + "   ");
            else
                System.out.print(i + 1 + "  ");

            for (int j = 0; j < getSize(); j++) {
                System.out.print(getCell(i, j).getStatus() + "  ");
            }
            System.out.println();
        }

    }

    //CELL HAS A ROW, COL, STATUS, AND BOOLEANS FOR SPECIAL POSITIONS(TOP ROW, CORNERS, ETC)
    //ALSO HAS A LIST OF DIRECTIONS THAT MAY BE TESTED BASED ON POSITION (TOP RIGHT CORNER CAN ONLY CHECK CELLS LEFT AND DOWN, ETC)
    class Cell {

        //DATA
        private int row;
        private int col;
        private char status = nullChip;
        //SPECIAL POSITIONS
        private boolean topRow;
        private boolean bottomRow;
        private boolean leftCol;
        private boolean rightCol;
        private boolean topLeftCorner;
        private boolean topRightCorner;
        private boolean bottomLeftCorner;
        private boolean bottomRightCorner;
        private boolean edgeCell;
        private boolean cornerCell;
        //VALID TEST DIRECTIONS
        private ArrayList<Character> testDirections = new ArrayList<>(1);

        //CONSTRUCT THE CELL
        Cell(int n, int m) {
            row = n;
            col = m;
            setPositions(n, m);
            setTestDirections();
        }

        //SET SPECIAL POSITIONS FOR THE CELL
        private void setPositions(int n, int m) {
            if(n==0)
                topRow = true;
            else if(n==size-1)
                bottomRow = true;
            else{
                topRow = false;
                bottomRow = false;
            }

            if (m == 0)
                leftCol = true;
            else if(m==size-1)
                rightCol = true;
            else {
                leftCol = false;
                rightCol = false;
            }

            if(topRow && leftCol)
                topLeftCorner = true;
            else if(topRow && rightCol)
                topRightCorner = true;
            else if(bottomRow && leftCol)
                bottomLeftCorner = true;
            else if(bottomRow && rightCol)
                bottomRightCorner = true;
            else{
                topLeftCorner = false;
                topRightCorner = false;
                bottomLeftCorner = false;
                bottomRightCorner = false;
            }
        }

        //SET VALID TEST DIRECTIONS FOR THE CELL
        //D = DOWN | U = UP | L = LEFT | R = RIGHT
        //T = UP LEFT | X = UP RIGHT | Y = DOWN LEFT | Z = DOWN RIGHT
        private void setTestDirections() {
            if(topLeftCorner){
                testDirections.add('D');
                testDirections.add('R');
                testDirections.add('Z');
                edgeCell = true;
                cornerCell = true;
            }
            else if(topRightCorner){
                testDirections.add('D');
                testDirections.add('L');
                testDirections.add('Y');
                edgeCell = true;
                cornerCell = true;
            }
            else if(bottomLeftCorner) {
                testDirections.add('U');
                testDirections.add('R');
                testDirections.add('X');
                edgeCell = true;
                cornerCell = true;
            }
            else if(bottomRightCorner) {
                testDirections.add('U');
                testDirections.add('L');
                testDirections.add('T');
                edgeCell = true;
                cornerCell = true;
            }
            else if(topRow) {
                testDirections.add('D');
                testDirections.add('L');
                testDirections.add('R');
                testDirections.add('Z');
                testDirections.add('Y');
                edgeCell = true;
            }
            else if(bottomRow) {
                testDirections.add('U');
                testDirections.add('L');
                testDirections.add('R');
                testDirections.add('T');
                testDirections.add('X');
                edgeCell = true;
                cornerCell = false;
            }
            else if(leftCol) {
                testDirections.add('D');
                testDirections.add('U');
                testDirections.add('R');
                testDirections.add('X');
                testDirections.add('Z');
                edgeCell = true;
                cornerCell = false;

            }
            else if(rightCol) {
                testDirections.add('D');
                testDirections.add('U');
                testDirections.add('L');
                testDirections.add('T');
                testDirections.add('Y');
                edgeCell = true;
                cornerCell = false;

            }
            else{
                testDirections.add('D');
                testDirections.add('U');
                testDirections.add('L');
                testDirections.add('R');
                testDirections.add('T');
                testDirections.add('X');
                testDirections.add('Y');
                testDirections.add('Z');
                edgeCell = false;
                cornerCell = false;

            }
        }

        boolean isCorner() {
            return cornerCell;
        }
        boolean isEdgeCell() {
            return edgeCell;
        }
        char getStatus() {
            return status;
        }
        void setToBlack() {
            status = blackChip;
        }
        void setToWhite() {
            status = whiteChip;
        }
        void setToNull() {
            status = nullChip;
        }
        ArrayList<Character> getTestDirections() {
            return testDirections;
        }

        //PRINT THE DATA FOR THE CELL. USED FOR TESTING.
        void printData() {
            System.out.println("Cell: (" + (row+1) + "," + (col+1) + ")\nStatus: " + status + "\nTop row: " + topRow + "" +
                    "\nBottom row: " + bottomRow + "\nLeft col: " + leftCol + "\nRight col: " + rightCol + "\nTop left corner: " + topLeftCorner +
                    "\nTop right corner: " + topRightCorner + "\nBottom left corner: " + bottomLeftCorner + "\nBottom right corner: "
                    + bottomRightCorner);

            for(int i = 0; i < testDirections.size(); i++) {
                System.out.print(testDirections.get(i) + " ");
            }
            System.out.println();
        }
    }
}
