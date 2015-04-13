package startup;

import models.WayImpl;
import play.Logger;
import play.libs.F;

import java.util.List;

public class ImportRunner implements F.Function0 {

    public static void doImport() throws Throwable {
        if (WayImpl.getWayById(1) == null) {
            try {
                List<WayImpl> ways = Import.doImport();
                int i = 1;
                for (WayImpl way : ways) {
                    WayImpl.saveWay(way);
                    System.out.println("Imported way number: " + i++);
                }
                Logger.info("Successfully ran import");
            }  catch (Throwable e) {
                Logger.error("There was an error with importing the data");
                throw e;
            }
        } else {
            Logger.info("Did not run import since it has already been ran");
        }
        Logger.info("Application has started");
    }


    @Override
    public Object apply() throws Throwable {
        doImport();
        return null;
    }
}
