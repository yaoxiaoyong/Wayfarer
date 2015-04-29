package controllers;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import models.WayImpl;
import models.WayUser;
import play.Logger;
import play.db.jpa.Transactional;
import play.mvc.Controller;
import play.mvc.Http;
import play.mvc.Result;
import serializers.UserWaySerializer;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.apache.commons.lang3.exception.ExceptionUtils.getStackTrace;

public class UserController extends Controller {

    @Transactional
    public static Result index() {
        WayUser user = WayUser.findByEmail("ryanspillsbury90@gmail.com");
        if (user == null) {
            user = new WayUser();
            user.email = "ryanspillsbury90@gmail.com";
            user.firstName = "Ryan";
            user.lastName = "Pillsbury";
            user.savedWays = new ArrayList<>();
            user.savedWays.add(WayImpl.getWayById(1));
            WayUser.save(user);
        }

        return ok(user.getEmail());
    }

    @Transactional
    public static Result getWaysForUser(int userId) {
        WayUser user = WayUser.findById(userId);
        List<WayImpl> ways = WayImpl.getAllWays();
        try {
            return ok(UserWaySerializer.serialize(user, ways));
        } catch (Exception e) {
            String stacktrace = getStackTrace(e);
            Logger.error(stacktrace);
            return internalServerError(stacktrace);
        }
    }

    @Transactional
    public static Result saveUserWay(int userId, int wayId) {
        WayUser user = WayUser.findById(userId);
        WayImpl wayToSave = WayImpl.getWayById(wayId);
        if (user != null && wayToSave != null) {
            List<WayImpl> ways = user.getSavedWays();
            for (WayImpl way : ways) {
                if (way.getId() == wayId) {
                    return ok(user.toString()); // has already saved this way
                }
            }
            user.getSavedWays().add(wayToSave);
            WayUser.save(user);
            return ok(user.toString());
        }
        return ok((user != null) ? user.toString() : "");
    }

    @Transactional
    public static Result unsaveUserWay(int userId, int wayId) {
        WayUser user = WayUser.findById(userId);
        WayImpl wayToUnSave = WayImpl.getWayById(wayId);

        if (user != null && wayToUnSave != null) {
            List<WayImpl> ways = user.getSavedWays();
            for (int i = 0; i < ways.size(); i++) {
                WayImpl w = ways.get(i);
                if (w.getId() == wayId) {
                    ways.remove(i);
                    WayUser.save(user);
                    return ok(user.toString()); // has already saved this way
                }
            }

            return ok(user.toString()); // was never saved
        }
        return ok((user != null) ? user.toString() : "");
    }

    @Transactional
    public static Result updateUser(int userId) {
        WayUser user = WayUser.findById(userId);
        if ( user == null) {
            return internalServerError("There does not exist a user with id " + userId);
        }

        Http.RequestBody body = request().body();
        if (body.asText() == null || body.asText().length() == 0) {
            return internalServerError("Must pass in user attributes to save to new user");
        }

        try {
            Map<String, Object> map = new ObjectMapper().readValue(body.asText(), new TypeReference<Map<String, Object>>() {});

            user.email = map.containsKey("email") ? (String) map.get("email") : user.getEmail();
            user.firstName = map.containsKey("firstName") ? (String) map.get("firstName") : user.getFirstName();
            user.lastName = map.containsKey("lastName") ? (String) map.get("lastName") : user.getLastName();
            if (map.containsKey("savedWays")) {
                List<Integer> list = (List<Integer>) map.get("savedWays");
                List<WayImpl> savedWays = new ArrayList<>();
                for (Integer i : list) {
                    WayImpl way = WayImpl.getWayById(i);
                    if (way != null) {
                        savedWays.add(way);
                    }
                }
                if (savedWays.size() > 0) {
                    user.savedWays = savedWays;
                }
            }

            return ok(WayUser.save(user).toString());

        } catch (Exception e) {
            return internalServerError(getStackTrace(e));
        }
    }

    @Transactional
    public static Result createUser() {
        Http.RequestBody body = request().body();
        WayUser user;
        try {

            if (body.asText() == null || body.asText().length() == 0) {
                return ok(WayUser.save(new WayUser()).toString());
            }

            Map<String, Object> map = new ObjectMapper().readValue(body.asText(), new TypeReference<Map<String, Object>>() {});
            user = new WayUser();
            if (map.containsKey("id")) {
                Integer id = (Integer) map.get("id");
                if (WayUser.findById(id) != null) {
                    return ok("Can not create a user since a user already exists with id " + id);
                }
                user.id = id;
            }

            user.email = map.containsKey("email") ? (String) map.get("email") : null;
            user.firstName = map.containsKey("firstName") ? (String) map.get("firstName") : null;
            user.lastName = map.containsKey("lastName") ? (String) map.get("lastName") : null;

            if (map.containsKey("savedWays")) {
                List<Integer> list = (List<Integer>) map.get("savedWays");
                List<WayImpl> savedWays = new ArrayList<>();
                for (Integer i : list) {
                    WayImpl way = WayImpl.getWayById(i);
                    if (way != null) {
                        savedWays.add(way);
                    }
                }
                if (savedWays.size() > 0) {
                    user.savedWays = savedWays;
                }
            }
            return ok(WayUser.save(user).toString());
        } catch (Exception e) {
            return internalServerError(getStackTrace(e));
        }
    }


}
