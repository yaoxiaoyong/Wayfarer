import play.Application;
import play.GlobalSettings;
import play.Logger;
import play.db.jpa.JPA;
import play.db.jpa.Transactional;
import startup.ImportRunner;


public class Global extends GlobalSettings {

    @Transactional
    @Override
    public void onStart(Application app) {
        try {
            JPA.withTransaction(new ImportRunner());
        } catch (Throwable throwable) {
            Logger.error("Failed Import");
            throwable.printStackTrace();
        }
    }



    @Override
    public void onStop(Application app) {
        Logger.info("Application shutdown...");
    }
}
