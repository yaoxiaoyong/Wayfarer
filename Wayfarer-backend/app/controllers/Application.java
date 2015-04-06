package controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Results;
import utility.Import;
import views.html.index;

public class Application extends Controller {

    public static Result index() {
        return ok(index.render("Your new application is ready."));
    }

    public static Result data() {
        try {
            return ok(new ObjectMapper().writeValueAsString(new Import().doImport()));
        } catch (Exception e) {
            return Results.internalServerError("Failed to process request\n\n" + e);
        }
    }

}
