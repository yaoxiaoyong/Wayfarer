package controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import models.WayUser;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Results;
import utility.Import;
import views.html.index;

public class Application extends Controller {

    public static Result index() {

        if (WayUser.find.all().size() == 0) {
            new WayUser("ryanspillsbury90@gmail.com", "Ryan Pillsbury", true, 1L).save();
        }
        return ok(index.render(WayUser.find.all()));
    }

    public static Result data() {
        try {
            return ok(new ObjectMapper().writeValueAsString(new Import().doImport()));
        } catch (Exception e) {
            return Results.internalServerError("Failed to process request\n\n" + e);
        }
    }

}
