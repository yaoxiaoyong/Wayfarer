package utility;

import models.Way;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Pillsbury on 3/26/15.
 */
public class Import {

    private static final String DEFAULT_DATABASE_CSV = "./resources/ways.csv";

    public static void main(String[] args) throws Exception {
        new Import().doImport(DEFAULT_DATABASE_CSV);
    }

    public List<Way> doImport() throws Exception{
        return doImport(DEFAULT_DATABASE_CSV);
    }

    public List<Way> doImport(String filename) throws Exception {
        List<Way> db = new ArrayList<>();
        char doubleLeftQuote = '\u201C';
        char doubleRightQuote = '\u201D';

        int lineNumber = 0;
        int subCellIndex = 0;
        int columnNumber = 0;

        try
        {
            BufferedReader reader = new BufferedReader(new FileReader(filename));
            String line = reader.readLine(); // skip first line
            while ((line = reader.readLine()) != null)
            {
                lineNumber++;
                line = line.replace("\"", "");
                line = line.replace(doubleLeftQuote, '"');
                line = line.replace(doubleRightQuote, '"');
                Way way = new Way();
                for (columnNumber = 0; columnNumber < 9; columnNumber++) {
                    if ( columnNumber <= 2 || columnNumber == 8) {
                        int indexOfNextComma = (columnNumber == 0) ? line.indexOf(",") :
                                (line.indexOf("\",") != -1) ? line.indexOf("\",") + 1 : -1;
                        String cellValue = (indexOfNextComma != -1) ? line.substring(0, indexOfNextComma) : line;
                        if (indexOfNextComma != -1) {
                            line = line.substring(indexOfNextComma + 1);
                        }

                        switch (columnNumber) {
                            case 0:
                                way.id = Integer.parseInt(cellValue);
                                break;
                            case 1:
                                way.title = cellValue.substring(1, cellValue.length() - 1);
                                break;
                            case 2:
                                way.subTitle = cellValue.substring(1, cellValue.length() - 1);
                                break;
                            case 8:
                                way.coverImage = "assets/images/cover_images/" + cellValue.substring(1, cellValue.length() - 1);
                                break;
                        }
                    } else {
                        try {
                            if (line.indexOf(",") != 0) {
                                if (line.indexOf("[") != 0) {
                                    line = "[" + line;
                                    int tmp = line.indexOf("\",");
                                    if (tmp != -1) {
                                        line = line.substring(0, tmp + 1) + "]" + line.substring(tmp + 1);
                                    }
                                }
                                int indexOfNextClosingBracket = line.indexOf("]");
                                String cellValue = line.substring(1, indexOfNextClosingBracket);
                                if (indexOfNextClosingBracket != line.length() - 1) {
                                    line = line.substring(indexOfNextClosingBracket + 2);
                                }
                                if (cellValue != "") {
                                    String[] stringArray = cellValue.split("\"");
                                    List<String> stringList = new ArrayList<>();
                                    for (subCellIndex = 0; subCellIndex < stringArray.length; subCellIndex++) {
                                        if (stringArray[subCellIndex].length() > 0 && !stringArray[subCellIndex].equals(",") && !stringArray[subCellIndex].equals(", ") && !stringArray[subCellIndex].equals(" ")) {
                                            String str = stringArray[subCellIndex].trim();
                                            if (str.charAt(0) == '\"') str = str.substring(1);
                                            if (str.charAt(0) == '\"') str = str.substring(0, str.length() - 1);
                                            stringList.add(str);
                                        }
                                    }

                                    if (stringList.size() > 0) {
                                        switch (columnNumber) {
                                            case 3:
                                                way.descriptions = stringList;
                                                break;
                                            case 4:
                                                way.tasks = stringList;
                                                break;
                                            case 5:
                                                way.tips = stringList;
                                                break;
                                            case 6:
                                                way.items = stringList;
                                                break;
                                            case 7:
                                                way.transportation = stringList;
                                                break;
                                        }
                                    }
                                }
                            } else {
                                line = line.substring(1);
                            }
                        } catch (Exception e2) {
                            System.err.println(e2);
                            throw e2;
                        }
                    }
                }
                db.add(way);
            }
            reader.close();
            return db;
        }
        catch (Exception e)
        {
            System.err.println("Failed on line: " + lineNumber + " column: " + columnNumber);
            throw e;
        }
    }


}
